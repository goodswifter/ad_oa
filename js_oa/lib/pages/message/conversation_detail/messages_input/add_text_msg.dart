/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-24 16:22:28
 * @Description: 输入 文本消息
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_input\add_text_msg.dart
 * @LastEditTime: 2022-01-04 16:43:12
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/input_control/input_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';

class AddTextMessgae extends StatefulWidget {
  final String toUser;
  AddTextMessgae({Key? key, required this.toUser}) : super(key: key);

  @override
  _AddTextMessgaeState createState() => _AddTextMessgaeState();
}

class _AddTextMessgaeState extends State<AddTextMessgae> {
  final InputController _inputController = Get.find();

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(4),
      clipBehavior: Clip.antiAlias,
      child: Container(
        alignment: Alignment.center,
        height: 38,
        padding: const EdgeInsets.only(left: 7, right: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                width: 0.8,
                style: BorderStyle.solid,
                color: JSColors.background_grey),
            color: Colors.white),
        child: TextField(
          autofocus: false,
          controller: _inputController.editingController,
          focusNode: _inputController.focusNode,
          onSubmitted: (s) {
            _inputController.focusNode.requestFocus();
            _inputController.sendButtonClickEvent(toUser: widget.toUser);
          },
          onTap: () {},
          autocorrect: false,
          textAlign: TextAlign.left,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.send,
          cursorColor: JSColors.hexToColor('006eff').withOpacity(0.25),
          decoration: InputDecoration(
            border: InputBorder.none,
            isCollapsed: true,
            isDense: true,
          ),
          style: const TextStyle(fontSize: 16),
          // maxLines: 1,
        ),
      ),
    );
  }
}
