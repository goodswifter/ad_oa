/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-01 17:24:02
 * @Description: im模块初始化类
 * @FilePath: \js_oa\lib\im\im_init.dart
 * @LastEditTime: 2021-12-31 14:28:39
 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_oa/im/signal/signal.dart';
import 'package:js_oa/im/signal/signal_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tencent_im_sdk_plugin/enum/log_level_enum.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_custom_elem.dart';
import 'package:tpns_flutter_plugin/tpns_flutter_plugin.dart';
import 'tpns_config.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/c2c_conversation_controller.dart';
import 'package:js_oa/controller/message/message_controller.dart';
import 'package:js_oa/im/notification/notification_manager.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimAdvancedMsgListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimConversationListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSDKListener.dart';
import 'package:tencent_im_sdk_plugin/enum/V2TimSignalingListener.dart';
import 'package:tencent_im_sdk_plugin/manager/v2_tim_manager.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';

class TencentIMInitSdk {
  late final V2TIMManager _timManager;
  late final MessageController _messageController;
  final NotificationManager _notificationManager = NotificationManager();
  String _lastMessageId = "";
  final XgFlutterPlugin tPush = new XgFlutterPlugin();

  TencentIMInitSdk() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle style =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(style);
    }
    _timManager = TencentImSDKPlugin.v2TIMManager;
    _messageController = Get.put<MessageController>(MessageController());
    _init();
    _initPlatformState();
  }

  ///IM 功能初始化回调监听
  void _init() async {
    await Permission.storage.request();
    V2TimValueCallback<bool> initRsr = await _timManager.initSDK(
        sdkAppID: TpnsConfig.sdkappid,
        loglevel: LogLevelEnum.V2TIM_LOG_DEBUG,
        listener: V2TimSDKListener(
          onConnectFailed: (code, error) {},
          onConnectSuccess: () {},
          onConnecting: () {},
          onKickedOffline: () {},
          onSelfInfoUpdated: (info) {},
          onUserSigExpired: () {},
        ));

    if (initRsr.code == 0) {
      ///注册高级消息监听器
      _timManager.getMessageManager().addAdvancedMsgListener(
              listener: V2TimAdvancedMsgListener(
            onRecvC2CReadReceipt: (receiptList) {
              C2cConversationController conversationController = Get.find();
              receiptList.forEach((element) {
                conversationController.updateC2CMessageByUserId(
                    user: element.userID);
              });
            },
            onRecvMessageRevoked: (msgID) {},
            onRecvNewMessage: (msg) {
              V2TimCustomElem? elem = msg.customElem;
              if ((elem != null && "" == elem.desc) ||
                  (elem != null && elem.desc == null)) {
                return;
              }
              if (msg.textElem != null && msg.textElem!.text == "·对方已挂断·") {
                SignalCheckManager.getInstance(
                        notificationManager: _notificationManager)
                    .cancel();
              }
              String key = msg.userID!;
              if (_messageController.state == AppLifecycleState.paused) {
                if (_lastMessageId != msg.msgID!) {
                  if (msg.elemType == 2) {
                    _notificationManager.showNotification(msg: msg);
                  }
                  _lastMessageId = msg.msgID!;
                }
              }
              C2cConversationController conversationController = Get.find();
              if (key == conversationController.userId &&
                  msg.msgID! != _lastMessageId) {
                _lastMessageId = msg.msgID!;
                conversationController.addMessage(msg);
                _messageController
                    .setMessageReaded(conversationController.userId);
              }
            },
            onSendMessageProgress: (message, progress) {},
          ));

      ///注册会话监听器
      _timManager.getConversationManager().setConversationListener(
              listener: V2TimConversationListener(
            onConversationChanged: (conversationList) {
              _messageController.onConversationChanged(conversationList);
            },
            onNewConversation: (conversationList) {
              _messageController.onConversationChanged(conversationList);
            },
            onSyncServerFailed: () {},
            onSyncServerFinish: () {},
            onSyncServerStart: () {},
          ));

      ///信令消息监听器
      _timManager.getSignalingManager().addSignalingListener(
              listener: V2TimSignalingListener(
            onInvitationCancelled: (inviteID, inviter, data) {
              SignalCheckManager.getInstance(
                      notificationManager: _notificationManager)
                  .checkSignalMessageType(Signal.InvitationCancelled,
                      data: data, inviteID: inviteID, inviter: inviter);
            },
            onInvitationTimeout: (inviteID, inviteeList) {
              SignalCheckManager.getInstance(
                      notificationManager: _notificationManager)
                  .checkSignalMessageType(Signal.InvitationTimeout,
                      data: "", inviteID: inviteID, inviteeList: inviteeList);
            },
            onInviteeAccepted: (inviteID, invitee, data) {
              SignalCheckManager.getInstance(
                      notificationManager: _notificationManager)
                  .checkSignalMessageType(Signal.InviteeAccepted,
                      data: data, inviteID: inviteID, inviter: invitee);
            },
            onInviteeRejected: (inviteID, invitee, data) {
              SignalCheckManager.getInstance(
                      notificationManager: _notificationManager)
                  .checkSignalMessageType(Signal.InviteeRejected,
                      data: data, inviteID: inviteID, inviter: invitee);
            },
            onReceiveNewInvitation:
                (inviteID, inviter, groupID, inviteeList, data) {
              SignalCheckManager.getInstance(
                      notificationManager: _notificationManager)
                  .checkSignalMessageType(Signal.ReceiveNewInvitation,
                      data: data,
                      inviteID: inviteID,
                      inviter: inviter,
                      inviteeList: inviteeList);
            },
          ));
    }
  }

  ///初始化TPNS推送功能
  Future<void> _initPlatformState() async {
    XgFlutterPlugin.xgApi.enableOtherPush();
    tPush.setEnableDebug(true);
    tPush.addEventHandler(onRegisteredDeviceToken: (msg) async {
      /// 注册推送服务失败回调
    }, onRegisteredDone: (msg) async {
      /// 注册推送服务成功回调
    }, unRegistered: (msg) async {
      /// 注销推送服务回调
    }, onReceiveNotificationResponse: (Map<String, dynamic> map) async {
      /// 前台收到通知消息回调
    }, onReceiveMessage: (Map<String, dynamic> map) async {
      /// 收到透传、静默消息回调
    }, xgPushDidSetBadge: (msg) async {
      /// 设置角标回调仅iOS
    }, xgPushDidBindWithIdentifier: (msg) async {
      /// 绑定账号和标签回调
    }, xgPushDidUnbindWithIdentifier: (msg) async {
      /// 解绑账号和标签回调
    }, xgPushDidUpdatedBindedIdentifier: (msg) async {
      /// 更新账号和标签回调
    }, xgPushDidClearAllIdentifiers: (msg) async {
      /// 清除所有账号和标签回调
    }, xgPushClickAction: (Map<String, dynamic> map) async {
      /// 通知点击回调
    });

    if (Platform.isIOS) {
      tPush.configureClusterDomainName(TpnsConfig.TPNS_DomainName);
      tPush.startXg(
          TpnsConfig.TPNS_iOS_AccessID, TpnsConfig.TPNS_iOS_AccessKey);
    } else if (Platform.isAndroid) {
      if (await XgFlutterPlugin.xgApi.isMiuiRom()) {
        ///小米手机
        XgFlutterPlugin.xgApi.setMiPushAppId(appId: TpnsConfig.xiaomiPushAppId);
        XgFlutterPlugin.xgApi
            .setMiPushAppKey(appKey: TpnsConfig.xiaomiPushAppKey);

        XgFlutterPlugin.xgApi.regPush();
      } else if (await XgFlutterPlugin.xgApi.isOppoRom()) {
        ///oppo手机
        XgFlutterPlugin.xgApi.setOppoPushAppId(appId: TpnsConfig.oppoPushAppId);
        XgFlutterPlugin.xgApi
            .setOppoPushAppKey(appKey: TpnsConfig.oppoPushAppkey);

        XgFlutterPlugin.xgApi.regPush();
      } else if (await XgFlutterPlugin.xgApi.isEmuiRom()) {
        ///华为手机

        XgFlutterPlugin.xgApi.regPush();
      } else if (await XgFlutterPlugin.xgApi.isVivoRom()) {
        ///vivo 手机

        XgFlutterPlugin.xgApi.regPush();
      } else if (await XgFlutterPlugin.xgApi.isMeizuRom()) {
        ///魅族手机

        XgFlutterPlugin.xgApi.setMzPushAppId(appId: "APP_ID");
        XgFlutterPlugin.xgApi.setMzPushAppKey(appKey: "APPKEY");
        XgFlutterPlugin.xgApi.regPush();
      }
      tPush.startXg(
          TpnsConfig.TPNS_Android_AccessID, TpnsConfig.TPNS_Adnroid_AccessKey);
    }
  }
}
