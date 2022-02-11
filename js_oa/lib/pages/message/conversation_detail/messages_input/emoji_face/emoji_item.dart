/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-10-14 15:50:20
 * @Description:单个表情widget布局
 * @FilePath: \js_oa\lib\utils\emoji\emoji_item.dart
 * @LastEditTime: 2021-10-22 16:38:22
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/input_control/input_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';

class EmojiItemWidgtet extends StatefulWidget {
  final String? name;
  final int unicode;
  final String toUser;
  final Function? close;
  EmojiItemWidgtet(
      {Key? key,
      this.close,
      this.name,
      required this.toUser,
      required this.unicode})
      : super(key: key);

  @override
  _EmojiItemWidgtetState createState() => _EmojiItemWidgtetState();
}

class _EmojiItemWidgtetState extends State<EmojiItemWidgtet> {
  final InputController controller = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          controller.editingController.text =
              controller.editingController.text +
                  String.fromCharCode(widget.unicode);
          controller.editingController.selection = TextSelection.fromPosition(
              TextPosition(offset: controller.editingController.text.length));
        },
        child: Container(
          color: JSColors.background_grey_light,
          child: Text(
            String.fromCharCode(widget.unicode),
            style: TextStyle(
              fontSize: 26,
            ),
          ),
        ));
  }
}
