/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 14:52:29
 * @Description: 单条聊天文本消息 UI布局
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\component\message_widget.dart
 * @LastEditTime: 2022-01-04 17:45:49
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/pages/message/conversation_detail/component/message_content_widget.dart';
import 'package:js_oa/utils/date/chat_date_transform_util.dart';
import 'package:js_oa/widgets/contact/avatar_widget.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

class MessageWidget extends StatelessWidget {
  final V2TimMessage message;
  final Key? key;
  final String toUser;
  final String userName;
  final String conversationID;
  final String myAvatar;
  final String myName;
  const MessageWidget({
    required this.message,
    required this.toUser,
    required this.userName,
    required this.myName,
    required this.myAvatar,
    required this.conversationID,
    this.key,
  }) : super(key: key);
  getShowMessage() {
    String msg = '';
    switch (message.elemType) {
      case 1:
        msg = message.textElem!.text!;
        break;
      case 2:
        msg = message.customElem!.data!;
        break;
      case 3:
        msg = message.imageElem!.path!;
        break;
      case 4:
        msg = message.soundElem!.path!;
        break;
      case 5:
        msg = message.videoElem!.videoPath ?? "";
        break;
      case 6:
        msg = message.fileElem!.fileName!;
        break;
      case 7:
        msg = message.locationElem!.desc!;
        break;
      case 8:
        msg = message.faceElem!.data!;
        break;
      case 9:
        msg = "系统消息";
        break;
    }
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    if (message.msgID == null || message.msgID == '') {
      return const SizedBox();
    }

    return Column(
      children: [
        Text(
          ChatDateTransformUtils.getNewChatTime(
              timesamp: message.timestamp!,
              timesampType: DateTimeMessageType.chatContent),
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 11, color: JSColors.textWeakColor, height: 1.6),
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
          child: Row(
            textDirection:
                message.isSelf! ? TextDirection.rtl : TextDirection.ltr,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  if (!message.isSelf!) {
                    Get.toNamed(AppRoutes.contactsDetail,
                        parameters: {"id": toUser});
                  }
                },
                child: Avatar(
                  avatar:
                      message.isSelf! ? myAvatar : message.faceUrl ?? userName,
                  width: 40,
                  height: 40,
                  radius: 4.8,
                  userName: message.isSelf! ? myName : userName,
                ),
              ),
              MessageContentWidget(
                isSelf: message.isSelf!,
                message: message,
                messageContent: getShowMessage(),
              ),
              const SizedBox(width: 47, height: 37)
            ],
          ),
        ),
      ],
    );
  }
}
