/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-02 15:59:06
 * @Description: 消息列表 会话item 页面布局 二级
 * @FilePath: \js_oa\lib\pages\message\message_item\conversation_layout_widget.dart
 * @LastEditTime: 2021-12-29 16:55:24
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/im/voice_call/call_action_interface.dart';
import 'package:js_oa/utils/date/chat_date_transform_util.dart';
import 'package:js_oa/widgets/contact/avatar_widget.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_custom_elem.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

import 'elemtype_text.dart';
import 'readcount_widget.dart';

class ConversationLayout extends StatelessWidget {
  final String name;
  final String faceUrl;
  final V2TimMessage lastMessage;
  final int unreadCount;
  final String conversationID;
  final String userID;
  const ConversationLayout({
    required this.name,
    required this.faceUrl,
    required this.lastMessage,
    required this.unreadCount,
    required this.conversationID,
    required this.userID,
  });

  String getFaceUrl() {
    return (faceUrl == '') ? name : faceUrl;
  }

  ///点击消息条目进入对话页面
  _intentAction() {
    Map<String, dynamic> argument = Map();
    argument["conversationID"] = conversationID;
    argument["userID"] = userID;
    argument['conversationName'] = name;
    argument['unreadCount'] = unreadCount;
    Get.toNamed(AppRoutes.conversation, arguments: argument);
  }

  bool _checkMessageType() {
    V2TimCustomElem? elem = lastMessage.customElem;
    if (elem == null) {
      return false;
    } else {
      Map<String, dynamic> customMap = jsonDecode(elem.data!);
      if (customMap.containsKey("data")) {
        Map<String, dynamic>? data = jsonDecode(customMap['data']);
        if (data == null) {
          return false;
        } else {
          if (data.containsKey(CallAction.callType)) {
            return false;
          } else {}
        }
      } else {
        return true;
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _intentAction(),
      child: Container(
        child: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              child: Padding(
                padding: const EdgeInsets.all(9),
                child: PhysicalModel(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(4.8)),
                  clipBehavior: Clip.antiAlias,
                  child: Avatar(
                    width: 48,
                    height: 48,
                    radius: 0,
                    avatar: getFaceUrl(),
                    userName: name,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: JSColors.hexToColor("ededed"),
                          width: 0.7,
                          style: BorderStyle.solid))),
              child: Column(
                children: [
                  Container(
                    height: 22,
                    margin: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                          name,
                          style: TextStyle(
                              color: JSColors.hexToColor("111111"),
                              fontSize: 17,
                              height: 1),
                          textAlign: TextAlign.left,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        Container(
                          child: Text(
                            ChatDateTransformUtils.getNewChatTime(
                                timesamp: lastMessage.timestamp!,
                                timesampType:
                                    DateTimeMessageType.conversationList),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Color(int.parse('b0b0b0', radix: 16))
                                    .withAlpha(255),
                                fontSize: 12),
                          ),
                          width: 105,
                          padding: const EdgeInsets.only(right: 16),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 28,
                    margin: const EdgeInsets.only(top: 1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: _checkMessageType(),
                          child: Text(
                            "[审批]",
                            style: TextStyle(
                              color: unreadCount > 0
                                  ? Colors.red.withAlpha(240)
                                  : JSColors.textWeakColor,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                            child: ElemTypeTextWidget(
                                lastMessage: lastMessage,
                                elemType: lastMessage.elemType)),
                        UnreadCountWidget(unreadCount: unreadCount)
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
