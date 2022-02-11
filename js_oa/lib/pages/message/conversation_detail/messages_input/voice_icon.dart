/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 10:18:42
 * @Description: 输入 语音消息
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_input\voice_icon.dart
 * @LastEditTime: 2021-11-24 17:54:19
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/input_control/input_controller.dart';

class VoiceIconWidget extends StatefulWidget {
  final String toUser;
  static final String voiceIcon = "voiceIcon";
  VoiceIconWidget({Key? key, required this.toUser}) : super(key: key);

  @override
  _VoiceIconWidgetState createState() =>
      _VoiceIconWidgetState(voiceIcon: voiceIcon);
}

class _VoiceIconWidgetState extends State<VoiceIconWidget> {
  final String voiceIcon;
  _VoiceIconWidgetState({required this.voiceIcon});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputController>(
      id: voiceIcon,
      builder: (inputController) {
        return Container(
          width: 48,
          height: 55,
          child: IconButton(
              onPressed: () => inputController.voiceButtonClickEvent(),
              icon: Icon(
                inputController.showVoiceIcon
                    ? Icons.keyboard_voice
                    : Icons.keyboard,
                size: 28,
                color: Colors.black,
              )),
        );
      },
    );
  }
}
