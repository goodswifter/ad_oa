/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-02 15:48:17
 * @Description: 消息列表 会话item 页面布局 一级
 * @FilePath: \js_oa\lib\pages\message\message_item\conversation_item_widget.dart
 * @LastEditTime: 2021-12-13 15:49:01
 */
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/message_controller.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'conversation_layout_widget.dart';

class ConversationItemWidget extends StatelessWidget {
  final String conversationID;
  final String showName;
  final String faceUrl;
  final V2TimMessage lastMessage;
  final int unreadCount;
  final int type;
  final String userID;
  const ConversationItemWidget({
    Key? key,
    required this.conversationID,
    required this.faceUrl,
    required this.lastMessage,
    required this.showName,
    required this.type,
    required this.unreadCount,
    required this.userID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 1, bottom: 1),
      color: Colors.white,
      child: Slidable(
          child: ConversationLayout(
            name: showName,
            faceUrl: faceUrl,
            lastMessage: lastMessage,
            unreadCount: unreadCount,
            conversationID: conversationID,
            userID: userID,
          ),
          endActionPane: ActionPane(
            extentRatio: 0.3,
            motion: ScrollMotion(),
            children: [
              SlidableAction(
                flex: 1,
                onPressed: (context) {
                  _delete();
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: '删除',
              ),
            ],
          )),
    );
  }

  _delete() async {
    await TencentImSDKPlugin.v2TIMManager
        .getConversationManager()
        .deleteConversation(
          conversationID: conversationID,
        )
        .then((value) {
      MessageController controller = Get.find();
      controller.removeConversationById(conversationID);
    });
  }
}
