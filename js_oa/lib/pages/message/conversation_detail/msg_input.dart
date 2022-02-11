/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 09:27:25
 * @Description: 会话 聊天页面  信息输入方式入口
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\msg_input.dart
 * @LastEditTime: 2022-01-04 16:41:34
 */
import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_input/add_advance_msg.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_input/emoji_icon_widget.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_input/add_text_voice_msg.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_input/voice_icon.dart';

class MsgInput extends StatelessWidget {
  MsgInput({Key? key, required this.toUser}) : super(key: key);
  final String toUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 55,
        color: JSColors.background_grey_light,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            VoiceIconWidget(toUser: toUser),
            AddTextOrVoiceMessage(toUser: toUser),
            EmojiIconWidget(toUser: toUser),
            AddAdvanceMessage(toUser: toUser),
          ],
        ),
      ),
    );
  }
}
