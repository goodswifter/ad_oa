/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-25 10:25:46
 * @Description: indexbar  索引bar相关配置
 * @FilePath: \js_oa\lib\pages\contacts\letter_list\index_bar_options.dart
 * @LastEditTime: 2021-10-12 16:26:48
 */

import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';

import 'index_bar_config_data.dart';

///索引布局宽度
const double kIndexBarWidth = 30;

///默认 一个字母索引的宽度
const double kIndexBarItemWidth = 30;
// 默认一个字母索引item的高度
const double kIndexBarItemHeight = 17;

class IndexBarOption {
  final double topMargin;
  final double rightMargin;
  final Color? indexbarBackgroundColor;
  final Color? touchDownTextColor;
  final Color? touchDownTextBackgroundColor;
  final TextStyle? selectedFloatingTextStyle;
  final Decoration downItemDecoration;
  final TextStyle defaultTextStyle;
  final double indexHintHeight;
  final double indexHintWidth;
  final Alignment indexHintAlignment;
  final Alignment indexHintChildAlignment;
  final Offset? indexHintPosition;
  final Offset indexHintOffset;
  final TextStyle indexHintTextStyle;
  final Decoration indexHintDecoration;
  List<String> barData;
  IndexBarOption({
    this.rightMargin = 0.0,
    this.topMargin = 15.0,
    this.indexbarBackgroundColor,
    this.touchDownTextColor,
    this.indexHintPosition,
    this.touchDownTextBackgroundColor,
    this.selectedFloatingTextStyle,
    this.barData = mBarData,
    this.indexHintChildAlignment = const Alignment(-0.23, 0.0),
    this.indexHintTextStyle =
        const TextStyle(fontSize: 24.0, color: Colors.white),
    this.indexHintOffset = const Offset(-18, 0),
    this.indexHintDecoration = const BoxDecoration(
      image: DecorationImage(
        image: AssetImage(
            "assets/images/contact/3.0x/ic_index_bar_bubble_gray.png"),
        fit: BoxFit.contain,
      ),
    ),
    this.indexHintAlignment = Alignment.centerRight,
    this.indexHintHeight = 50,
    this.indexHintWidth = 60,
    this.defaultTextStyle =
        const TextStyle(fontSize: 12, color: JSColors.black),
    this.downItemDecoration =
        const BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
  });
}
