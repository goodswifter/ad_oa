/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-17 15:36:27
 * @Description: 本地通知管理
 * @FilePath: \js_oa\lib\im\notification\notification_manager.dart
 * @LastEditTime: 2021-12-09 16:01:38
 */
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:js_oa/im/voice_call/voice_call_loading.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

class NotificationManager {
  late final FlutterLocalNotificationsPlugin localNotification;
  String name = "";
  String content = "";
  String avatar = "";
  int roomid = 1;
  String inviteID = "";
  bool isCanshowLoading = true;
  NotificationManager() {
    var androidInitialize = AndroidInitializationSettings("ic_launcher");
    var iOSInitialize = IOSInitializationSettings(
        requestBadgePermission: true,
        requestSoundPermission: true,
        requestAlertPermission: true);
    var initialzationSettings =
        InitializationSettings(android: androidInitialize, iOS: iOSInitialize);
    localNotification = FlutterLocalNotificationsPlugin()
      ..initialize(initialzationSettings,
          onSelectNotification: onSelectNotification);
  }

  setNotificationDetail(
      {required String nName,
      required String nContent,
      required String nAvatar,
      required int nRoomId,
      required String nInvitdId}) {
    this.avatar = nAvatar;
    this.content = nContent;
    this.inviteID = nInvitdId;
    this.name = nName;
    this.roomid = nRoomId;
  }

  dismissCallback() {
    isCanshowLoading = false;
  }

  enableLoadingCallback() {
    isCanshowLoading = true;
  }

  Future<dynamic> onSelectNotification(String? payload) async {
    if (!isCanshowLoading) return;
    EasyLoading.showVoiceCall(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 38),
      duration: Duration(seconds: 20),
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

  showNotification({V2TimMessage? msg, String? title, String? body}) async {
    var androidDetails = AndroidNotificationDetails(
        "channelId", "Local Notification", "通知描述",
        importance: Importance.high);
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    String notificationTitle = "";
    String notificationbody = "";
    if (msg != null) {
      notificationTitle = "京师OA";
      switch (msg.elemType) {
        case 1: //文本消息
          notificationbody = msg.textElem!.text!;
          break;
        case 2: //自定义消息
          notificationbody = msg.customElem!.desc!;
          break;
        case 3: //图片消息
          notificationbody = "[图片]";
          break;
        case 4:
          notificationbody = "[语音]";
          break;
        case 5:
          notificationbody = "[视频]";
          break;
        case 6:
          notificationbody = "[文件]";
          break;
        case 7:
          notificationbody = "[通知]";
          break;
        case 8:
          notificationbody = "[语音邀请]";
          break;
        case 9:
          break;
      }
    }
    await localNotification.show(
        0, notificationTitle, notificationbody, generalNotificationDetails);
  }
}
