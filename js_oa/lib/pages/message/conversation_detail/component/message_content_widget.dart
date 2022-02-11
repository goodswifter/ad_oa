/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 16:48:42
 * @Description: 会话详情  具体某一条消息的内容
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\component\message_content_widget.dart
 * @LastEditTime: 2021-12-31 16:41:59
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/c2c_conversation_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/im/voice_call/call_action_interface.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_widget/custom_message.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_widget/file_message.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_widget/image_message.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_widget/sound_message.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_widget/video_message.dart';
import 'package:js_oa/widgets/message/bubble_clipper.dart';
import 'package:tencent_im_sdk_plugin/enum/message_elem_type.dart';
import 'package:tencent_im_sdk_plugin/enum/message_status.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_custom_elem.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

class MessageContentWidget extends StatelessWidget {
  final V2TimMessage message;
  final String messageContent;
  final bool isSelf;
  final TextAlign _textAlign = TextAlign.left;
  MessageContentWidget({
    Key? key,
    required this.isSelf,
    required this.message,
    required this.messageContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late CrossAxisAlignment crossAxisAlignment;
    late EdgeInsetsGeometry padding;
    late EdgeInsetsGeometry contentPadding;
    late Color color;
    late Color textColor;
    double roundRadius = 6.5;
    double elevation = 0;
    if (isSelf) {
      crossAxisAlignment = CrossAxisAlignment.end;
      padding = const EdgeInsets.only(right: 7);
      contentPadding =
          const EdgeInsets.only(left: 10, right: 17, top: 10, bottom: 10);
      color = Color(int.parse('BFDFFF', radix: 16)).withAlpha(255);

      textColor = JSColors.hexToColor('171538');
    } else {
      crossAxisAlignment = CrossAxisAlignment.start;
      padding = const EdgeInsets.only(left: 7);
      contentPadding =
          const EdgeInsets.only(left: 17, right: 10, top: 10, bottom: 10);
      color = Colors.white;
      textColor = JSColors.hexToColor('000000');
    }
    if (message.elemType == MessageElemType.V2TIM_ELEM_TYPE_CUSTOM) {
      roundRadius = 10;
      elevation = 0.4;
      contentPadding =
          const EdgeInsets.only(left: 0, right: 10, top: 10, bottom: 10);
      color = JSColors.white;
      textColor = JSColors.hexToColor('171538');
    }
    if (message.elemType == MessageElemType.V2TIM_ELEM_TYPE_IMAGE ||
        message.elemType == MessageElemType.V2TIM_ELEM_TYPE_VIDEO) {
      color = JSColors.hexToColor('F2F2F2');
      contentPadding =
          const EdgeInsets.only(left: 2, right: 2, top: 1, bottom: 1);
    }
    return Expanded(
        child: Container(
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 1, bottom: 1),
            child: PhysicalShape(
              elevation: elevation,
              clipper: BubbleClipper(isSelf: isSelf, roundRadius: roundRadius),
              color: color,
              child: Padding(
                padding: contentPadding,
                child: _getMessageByType(textColor),
              ),
            ),
          ),
          GetBuilder<C2cConversationController>(
              id: "message_read",
              builder: (cc) {
                return geteHandleBar();
              }),
        ],
      ),
    ));
  }

  ///根据消息类型返回对应消息布局
  _getMessageByType(Color color) {
    switch (message.elemType) {
      case 1:
        return Text(
          messageContent,
          textAlign: _textAlign,
          style: TextStyle(fontSize: 16, color: color),
        );
      case MessageElemType.V2TIM_ELEM_TYPE_CUSTOM:
        V2TimCustomElem elem = message.customElem!;
        return _checkCustomMessageType(elem, color);
      case MessageElemType.V2TIM_ELEM_TYPE_IMAGE:
        return ImageMessage(message, isSelf);
      case MessageElemType.V2TIM_ELEM_TYPE_FACE:
        return Container(
          child: Text("表情 ${message.faceElem!.data}"),
        );
      case MessageElemType.V2TIM_ELEM_TYPE_SOUND:
        return SoundMessage(message, _textAlign, isSelf);
      case MessageElemType.V2TIM_ELEM_TYPE_VIDEO:
        return VideoMessage(message, isSelf);
      case MessageElemType.V2TIM_ELEM_TYPE_FILE:
        return FileMessage(message);
    }
  }

  Widget _checkCustomMessageType(V2TimCustomElem elem, Color color) {
    if (elem.data == null) {
      return Container();
    } else {
      Widget wid;
      Map<String, dynamic> customMap = jsonDecode(elem.data!);
      if (customMap.containsKey("data")) {
        Map<String, dynamic>? data = jsonDecode(customMap['data']);
        if (data == null) {
          wid = Container();
          return wid;
        } else {
          if (data.containsKey(CallAction.callType)) {
            String content = data['inviteTypeName'];
            wid = Padding(
              padding:
                  const EdgeInsets.only(left: 9, right: 9, top: 4, bottom: 4),
              child: Text(
                content,
                textAlign: _textAlign,
                style: TextStyle(fontSize: 16, color: color),
              ),
            );
            return wid;
          } else {
            return Container();
          }
        }
      } else {
        wid = CustomMessage(message, isSelf);
        return wid;
      }
    }
  }

  geteHandleBar() {
    Widget wid = Container();
    if (isSelf) {
      if (message.status == MessageStatus.V2TIM_MSG_STATUS_SEND_SUCC) {
        if (message.isPeerRead! &&
            (message.groupID == null || message.groupID == '')) {
          wid = Text(
            "已读  ",
            style: TextStyle(color: JSColors.textWeakColor, fontSize: 10),
          );
        }
        if (message.isPeerRead == false &&
            (message.groupID == null || message.groupID == '')) {
          wid = Text(
            "未读  ",
            style: TextStyle(color: JSColors.textWeakColor, fontSize: 10),
          );
        }
      }
    }
    if (message.status == MessageStatus.V2TIM_MSG_STATUS_SEND_FAIL) {
      wid = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.info,
            size: 14,
            color: JSColors.readColor,
          ),
          Text(
            "发送失败 ",
            style:
                TextStyle(fontSize: 10, color: JSColors.readColor, height: 1.4),
          )
        ],
      );

      if (message.status == MessageStatus.V2TIM_MSG_STATUS_SENDING) {
        wid = const Text(
          "发送中... ",
          style: TextStyle(
            fontSize: 10,
            color: JSColors.primaryColor,
          ),
        );
      }
    }

    return wid;
  }
}
