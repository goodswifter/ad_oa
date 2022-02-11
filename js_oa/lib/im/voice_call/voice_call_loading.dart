/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-19 10:55:13
 * @Description: 接收到语音邀请后的全局loading窗口
 * @FilePath: \js_oa\lib\im\voice_call\voice_call_loading.dart
 * @LastEditTime: 2021-12-07 15:49:19
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/im/entity/voice_call_entity.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/widgets/contact/avatar_widget.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';

///点击window进入通话页面的点击事件
typedef EnterEvent = Function();

///点击挂断button的点击回调
typedef RejectEvent = Function();

///点击接听button的点击回调
typedef AcceptCallEvent = Function();

class VoiceCallLoadingWindow extends StatefulWidget {
  ///邀请人的名字
  final String name;

  ///邀请内容
  final String content;

  ///邀请人的头像
  final String faceUrl;

  ///邀请人创建的房间id
  final int roomid;

  ///邀请人的id
  final String inviteID;

  final EnterEvent? enterEvent;
  final RejectEvent? rejectEvent;
  final AcceptCallEvent? acceptCallEvent;
  VoiceCallLoadingWindow({
    Key? key,
    required this.content,
    required this.faceUrl,
    required this.name,
    this.enterEvent,
    required this.inviteID,
    this.acceptCallEvent,
    this.rejectEvent,
    required this.roomid,
  }) : super(key: key);

  @override
  _VoiceCallLoadingWindowState createState() => _VoiceCallLoadingWindowState();
}

class _VoiceCallLoadingWindowState extends State<VoiceCallLoadingWindow> {
  _sendRejectMessage() async {
    await TencentImSDKPlugin.v2TIMManager
        .getSignalingManager()
        .reject(
            inviteID: widget.inviteID, data: jsonEncode(_getRejectCustomMap()))
        .then((value) {
      EasyLoading.dismiss();
    });
  }

  _getRejectCustomMap() {
    VoiceCallSiganlEntity entity =
        VoiceCallSiganlEntity(inviteTypeName: "拒绝语音邀请", callType: 3);
    Map<String, dynamic> customMap = entity.toJson();
    return customMap;
  }

  ///整体布局点击事件
  _layoutClickEvent() {
    if (widget.enterEvent != null) {
      widget.enterEvent!.call();
    } else {
      Map<String, dynamic> dataMap = Map();
      dataMap['name'] = widget.name;
      dataMap['faceUrl'] = widget.faceUrl;
      dataMap['toUser'] = widget.inviteID;
      dataMap['inviteId'] = widget.inviteID;
      dataMap['roomid'] = widget.roomid;
      EasyLoading.dismiss();
      Get.toNamed(AppRoutes.calling, arguments: dataMap);
    }
  }

  ///挂断按钮点击事件
  _rejectButtonClickEvent() {
    if (widget.rejectEvent != null) {
      widget.rejectEvent!.call();
    } else {
      _sendRejectMessage();
    }
  }

  ///接听按钮点击事件
  _acceptButtonClickEvent() {
    if (widget.acceptCallEvent != null) {
      widget.acceptCallEvent!.call();
    } else {
      Map<String, dynamic> dataMap = Map();
      dataMap['name'] = widget.name;
      dataMap['faceUrl'] = widget.faceUrl;
      dataMap['toUser'] = widget.inviteID;
      dataMap['isInviter'] = false;
      dataMap['inviteId'] = widget.inviteID;
      dataMap['roomid'] = widget.roomid;
      EasyLoading.dismiss();
      Get.toNamed(AppRoutes.calling, arguments: dataMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _layoutClickEvent();
      },
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 38,
                  width: 38,
                  margin: const EdgeInsets.all(12),
                  child: Avatar(
                    avatar: widget.faceUrl,
                    height: 38,
                    width: 38,
                    radius: 6,
                    userName: widget.name,
                  ),
                ),
                Container(
                  height: 38,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        widget.content,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      )
                    ],
                  ),
                ),
              ],
            ),
            flex: 5,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    _rejectButtonClickEvent();
                  },
                  child: Container(
                    height: 38,
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(90)),
                    child: Icon(
                      Icons.call_end,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    _acceptButtonClickEvent();
                  },
                  child: Container(
                    height: 38,
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(90)),
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            flex: 4,
          ),
        ],
      ),
    );
  }
}
