/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-10-15 15:00:16
 * @Description: 添加表情消息
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_input\emoji_face\add_emoji_msg.dart
 * @LastEditTime: 2021-12-13 16:50:40
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/input_control/input_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/utils/emoji/emoji.dart';
import 'package:js_oa/utils/emoji/emoji_data.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_input/emoji_face/emoji_item.dart';

class AddEmojiMessage extends StatefulWidget {
  final String toUser;
  AddEmojiMessage({Key? key, required this.toUser}) : super(key: key);

  @override
  _AddEmojiMessageState createState() => _AddEmojiMessageState();
}

class _AddEmojiMessageState extends State<AddEmojiMessage> {
  final InputController _controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: GridView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 8,
            childAspectRatio: 1,
          ),
          children: emojiData.map((e) {
            Emoji item = Emoji.fromJson(e);
            return EmojiItemWidgtet(
              toUser: widget.toUser,
              unicode: item.unicode,
              name: item.name,
              close: () {
                Navigator.pop(context);
              },
            );
          }).toList(),
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  _controller.backSpaceButtonClickEvent();
                },
                child: SafeArea(
                  child: Container(
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 1),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: JSColors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5))),
                    child: Image.asset("assets/images/message/backspace.png"),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  _controller.sendButtonClickEvent(toUser: widget.toUser);
                },
                child: Container(
                  width: 40,
                  margin: const EdgeInsets.only(top: 1),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "发送",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
