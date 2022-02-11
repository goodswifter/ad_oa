/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-12-15 15:31:27
 * @Description: 消息列表 系统消息布局
 * @FilePath: \js_oa\lib\pages\message\system_message\sys_msg_item_widget.dart
 * @LastEditTime: 2021-12-22 09:14:23
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/utils/date/chat_date_transform_util.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

import '../message_item/readcount_widget.dart';

class SystemMessageItemWidget extends StatelessWidget {
  final V2TimMessage lastMessage;
  final int unreadCount;
  final String conversationID;
  final String userID;
  const SystemMessageItemWidget({
    required this.lastMessage,
    required this.unreadCount,
    required this.conversationID,
    required this.userID,
  });
  @override
  Widget build(BuildContext context) {
    String dec = lastMessage.customElem == null
        ? ""
        : lastMessage.customElem!.desc == null
            ? " "
            : lastMessage.customElem!.desc!;
    String iconData = "assets/images/message/message_invoice.png";
    return Container(
      padding: const EdgeInsets.only(left: 2, right: 2, top: 1, bottom: 1),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          Map<String, dynamic> argument = Map();
          argument["conversationID"] = conversationID;
          argument["userID"] = userID;
          argument['conversationName'] = userID;
          argument['unreadCount'] = unreadCount;
          Get.toNamed(AppRoutes.systemMessage, arguments: argument);
        },
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
                    child: Container(
                      width: 48,
                      height: 48,
                      color: Colors.orange,
                      child: Image.asset(iconData),
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
                            "审批",
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
                          Expanded(
                              child: Text(
                            dec,
                            style: TextStyle(
                              color: JSColors.textWeakColor,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.left,
                          )),
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
      ),
    );
  }
}
