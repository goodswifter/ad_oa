/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-22 17:42:54
 * @Description: 消息类型 返回不同消息widget
 * @FilePath: \js_oa\lib\pages\message\message_item\elemtype_text.dart
 * @LastEditTime: 2021-12-13 15:58:48
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/im/voice_call/call_action_interface.dart';
import 'package:tencent_im_sdk_plugin/enum/message_elem_type.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_custom_elem.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

class ElemTypeTextWidget extends StatelessWidget {
  final int elemType;
  final V2TimMessage lastMessage;
  const ElemTypeTextWidget(
      {Key? key, required this.elemType, required this.lastMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      elemType == 1
          ? lastMessage.textElem == null
              ? ''
              : lastMessage.textElem!.text!
          : lastMessage.elemType == MessageElemType.V2TIM_ELEM_TYPE_GROUP_TIPS
              ? '[系统消息]'
              : lastMessage.elemType == MessageElemType.V2TIM_ELEM_TYPE_SOUND
                  ? '[语音消息]'
                  : lastMessage.elemType ==
                          MessageElemType.V2TIM_ELEM_TYPE_CUSTOM
                      ? _checkMessageType()
                      : lastMessage.elemType ==
                              MessageElemType.V2TIM_ELEM_TYPE_IMAGE
                          ? '[图片]'
                          : lastMessage.elemType ==
                                  MessageElemType.V2TIM_ELEM_TYPE_VIDEO
                              ? '[视频]'
                              : lastMessage.elemType ==
                                      MessageElemType.V2TIM_ELEM_TYPE_FILE
                                  ? '[文件]'
                                  : lastMessage.elemType ==
                                          MessageElemType.V2TIM_ELEM_TYPE_FACE
                                      ? '[表情]'
                                      : '',
      style: TextStyle(
        color: JSColors.textWeakColor,
        fontSize: 14,
      ),
      maxLines: 1,
      textAlign: TextAlign.left,
    );
  }

  String _checkMessageType() {
    String type = "";
    V2TimCustomElem elem = lastMessage.customElem!;
    if (elem.data == null) {
      return "";
    } else {
      Map<String, dynamic> customMap = jsonDecode(elem.data!);
      if (customMap.containsKey("data")) {
        Map<String, dynamic>? data = jsonDecode(customMap['data']);
        if (data == null) {
          type = "[语音通话]";
        } else {
          if (data.containsKey(CallAction.callType)) {
            type = "[语音通话]";
          } else {}
        }
      } else {
        type = "审批通知";
      }
      return type;
    }
  }
}
