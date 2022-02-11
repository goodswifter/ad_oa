/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-17 19:39:18
 * @Description: 信令消息类型检查
 * @FilePath: \js_oa\lib\im\signal\signal_util.dart
 * @LastEditTime: 2021-12-16 16:48:23
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/message_controller.dart';
import 'package:js_oa/controller/message/voice_call/voice_call_controller.dart';
import 'package:js_oa/im/entity/voice_call_entity.dart';
import 'package:js_oa/im/notification/notification_manager.dart';
import 'package:js_oa/im/voice_call/call_action_interface.dart';
import 'package:js_oa/im/voice_call/voice_call_loading.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:vibration/vibration.dart';
import 'signal.dart';

class SignalCheckManager {
  static SignalCheckManager? instance;
  late final MessageController _messageController;
  late final NotificationManager notificationManager;
  factory SignalCheckManager.getInstance(
          {required NotificationManager notificationManager}) =>
      _getInstance(notificationManager);

  static _getInstance(NotificationManager manager) {
    if (instance == null) {
      instance = SignalCheckManager._interal(notificationManager: manager);
    }
    return instance;
  }

  SignalCheckManager._interal({required this.notificationManager}) {
    _messageController = Get.find();
  }

  ///参数：data 解析data json 获取对应key键用于判断属于哪种信令消息
  checkSignalMessageType(Signal signal,
      {required String data,
      required String inviteID,
      String? inviter,
      List<String>? inviteeList}) {
    try {
      Map<String, dynamic>? customMap = jsonDecode(data);
      if (customMap == null) {
        return;
      }
      switch (signal) {
        case Signal.InvitationCancelled:
          if (customMap.containsKey(CallAction.callType)) {
            ///语音类型信令
            Vibration.cancel();
            EasyLoading.dismiss();
            VoiceCallController callController = Get.find();
            callController.cancel();
          } else {
            ///其他类型信令
          }
          break;
        case Signal.InvitationTimeout:
          if (customMap.containsKey(CallAction.callType)) {
            ///语音类型信令 超时
            Vibration.cancel();
            _timeOutDimissDialog();
          } else {
            ///其他类型信令
          }
          break;
        case Signal.InviteeAccepted:
          if (customMap.containsKey(CallAction.callType)) {
            ///语音类型信令 接受
            Vibration.cancel();
            VoiceCallController callController = Get.find();
            callController.acceptCallBack();
          } else {
            ///其他类型信令
          }
          break;
        case Signal.InviteeRejected:
          if (customMap.containsKey(CallAction.callType)) {
            ///语音类型信令 拒绝
            Vibration.cancel();
            EasyLoading.dismiss();
            VoiceCallController callController = Get.find();
            callController.rejectCallBack();
            _timeOutDimissDialog();
          } else {
            ///其他类型信令
          }
          break;
        case Signal.ReceiveNewInvitation:
          if (customMap.containsKey(CallAction.callType)) {
            ///语音类型信令  新邀请
            VoiceCallSiganlEntity entity =
                VoiceCallSiganlEntity.fromJson(customMap);
            _showCallInviteDialog(inviteID, entity: entity);
          } else {
            ///其他类型信令
          }
          break;
        default:
      }
    } catch (e) {}
  }

  cancel() {
    Vibration.cancel();
    EasyLoading.dismiss();
    VoiceCallController callController = Get.find();
    callController.cancel();
  }

  ///弹窗显示语音邀请
  _showCallInviteDialog(String inviteID,
      {required VoiceCallSiganlEntity entity}) async {
    String name = entity.inviterName ?? inviteID;
    String avatar = entity.inviterAvatar ?? name;
    String content = entity.inviteTypeName ?? "";
    int roomid = entity.roomId ?? -1;
    int timeout = entity.timeout ?? 30;
    notificationManager.enableLoadingCallback();
    try {
      if (await Vibration.hasCustomVibrationsSupport() ?? true) {
        Vibration.vibrate(
          duration: 30000,
          pattern: [
            1200,
            1200,
            1200,
            1200,
            1200,
            1200,
            1200,
            1200,
            1200,
            1200,
            1200,
            1200,
            1200
          ],
        );
      }
      VoiceCallController callController = Get.find();
      callController.newInvitedSendSuccessCallBack();
      bool isSelfCalling = callController.getCurrentCallStatus();
      if (isSelfCalling) {
        Vibration.cancel();
        return;
      }
    } catch (e) {}
    if (_messageController.state == AppLifecycleState.paused) {
      V2TimMessage msg = V2TimMessage(elemType: 8);
      notificationManager.setNotificationDetail(
          nName: name,
          nContent: content,
          nAvatar: avatar,
          nRoomId: roomid,
          nInvitdId: inviteID);
      notificationManager.showNotification(msg: msg);
    } else {
      EasyLoading.showVoiceCall(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 38),
        duration: Duration(seconds: timeout),
        toastPosition: EasyLoadingToastPosition.top,
        indicator: VoiceCallLoadingWindow(
          name: name,
          content: content,
          faceUrl: avatar,
          roomid: roomid,
          inviteID: inviteID,
        ),
        dismissOnTap: false,
      );
    }
  }

  ///超时后 关闭弹窗
  _timeOutDimissDialog() {
    EasyLoading.dismiss();
    notificationManager.dismissCallback();
  }
}
