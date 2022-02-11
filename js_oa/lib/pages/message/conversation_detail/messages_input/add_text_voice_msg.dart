/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 10:17:09
 * @Description: 输入 文本消息
 * @FilePath: \js_oa\lib\pages\messages\conversation_detail\messages_input\add_text_voice_msg.dart
 * @LastEditTime: 2021-10-22 16:41:09
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/input_control/input_controller.dart';
import 'package:js_oa/pages/main/lazy_index_stack.dart';

import 'add_text_msg.dart';
import 'add_voice_msg.dart';
import 'voice_icon.dart';

class AddTextOrVoiceMessage extends StatelessWidget {
  final String toUser;
  AddTextOrVoiceMessage({Key? key, required this.toUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputController>(
      id: VoiceIconWidget.voiceIcon,
      builder: (inputController) {
        return Expanded(
            child: LazyIndexStack(
          alignment: Alignment.center,
          index: inputController.showVoiceIcon ? 0 : 1,
          children: [
            LazyStackChild(
                child: AddTextMessgae(
              toUser: toUser,
            )),
            LazyStackChild(
                child: AddVoiceMessage(
              toUser: toUser,
            )),
          ],
        ));
      },
    );
  }
}
