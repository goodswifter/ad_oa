/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-29 16:40:31
 * @Description: 单个advance 模型
 * @FilePath: \js_oa\lib\pages\messages\conversation_detail\messages_input\advance\advance_item_model.dart
 * @LastEditTime: 2021-09-29 16:41:39
 */
import 'package:flutter/material.dart';

class AdvanceItemModel {
  final String name;
  final Icon icon;
  final Function onPressed;

  AdvanceItemModel(
      {required this.name, required this.icon, required this.onPressed});
}
