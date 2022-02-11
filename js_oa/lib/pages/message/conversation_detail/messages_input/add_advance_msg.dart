/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 10:10:25
 * @Description:  点击"+" 添加对应消息
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_input\add_advance_msg.dart
 * @LastEditTime: 2021-11-24 17:55:59
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/input_control/input_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';

class AddAdvanceMessage extends StatefulWidget {
  final String toUser;
  AddAdvanceMessage({Key? key, required this.toUser}) : super(key: key);

  @override
  _AddAdvanceMessageState createState() => _AddAdvanceMessageState();
}

class _AddAdvanceMessageState extends State<AddAdvanceMessage>
    with SingleTickerProviderStateMixin {
  final InputController _controller = Get.find();
  late final AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1100));
    _controller.setSendAndAddButtonChangeBuilder(() {
      _animationController.forward(from: 0.5);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => _controller.showAddButton.value
          ? Container(
              key: UniqueKey(), // UniqueKey:生成专属key 独一无二的key
              height: 56,
              width: 48,
              margin: const EdgeInsets.only(right: 3),
              child: IconButton(
                  onPressed: () => _controller.addButtonClickEvent(),
                  icon: const Icon(
                    Icons.add_circle_outline,
                    size: 28,
                  )),
            )
          : SlideTransition(
              position: Tween(begin: Offset(1, 0), end: Offset(0, 0))
                  .chain(CurveTween(curve: Curves.elasticInOut))
                  .animate(_animationController),
              child: Container(
                key: UniqueKey(),
                width: 50,
                height: 56,
                margin: const EdgeInsets.only(top: 8, bottom: 8, right: 5),
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.center,
                child: TextButton(
                    onPressed: () =>
                        _controller.sendButtonClickEvent(toUser: widget.toUser),
                    child: const Text(
                      "发送",
                      style: TextStyle(color: JSColors.white),
                    )),
              ),
            ),
    );
  }
}
