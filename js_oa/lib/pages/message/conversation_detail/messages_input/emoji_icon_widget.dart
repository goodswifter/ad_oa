/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 10:12:07
 * @Description: 输入表情消息
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_input\emoji_icon_widget.dart
 * @LastEditTime: 2021-12-29 16:14:48
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/input_control/input_controller.dart';

class EmojiIconWidget extends StatelessWidget {
  final String toUser;
  EmojiIconWidget({Key? key, required this.toUser}) : super(key: key);
  final InputController _inputController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 55,
      child: IconButton(
          icon: const Icon(
            Icons.mood,
            size: 28,
            color: Colors.black,
          ),
          onPressed: () => _inputController.emojiButtonClickEvent()),
    );
  }
}
