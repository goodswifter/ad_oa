/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-25 10:28:57
 * @Description: 字母索引视图（子）
 * @FilePath: \js_oa\lib\pages\contacts\letter_list\base_index_bar.dart
 * @LastEditTime: 2021-11-23 13:53:40
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index_bar_config_data.dart';
import '../../../controller/contact/index_bar_detail_controller.dart';
import 'index_bar_options.dart';
import 'dart:math' as math;

class BaseIndexBar extends StatefulWidget {
  final List<String> barLetterData;
  final IndexedWidgetBuilder? itemBuilder;
  final TextStyle textStyle;
  final Color? barColor;
  final double width;
  final double itemHeight;

  BaseIndexBar(
      {Key? key,
      this.barLetterData = mBarData,
      this.itemBuilder,
      this.barColor,
      this.width = kIndexBarItemWidth,
      this.itemHeight = kIndexBarItemHeight,
      this.textStyle =
          const TextStyle(fontSize: 12.0, color: Color(0xFF666666))})
      : super(key: key);

  @override
  _BaseIndexBarState createState() => _BaseIndexBarState();
}

class _BaseIndexBarState extends State<BaseIndexBar> {
  late List<Widget> _children;
  int _widgetTop = 0;
  int _lastIndex = -1;

  final IndexBarDetailController _controller = Get.find();

  int _getIndex(double offset) {
    int index = offset ~/ widget.itemHeight;
    return math.min(index, widget.barLetterData.length - 1);
  }

  _triggerDragEvent(int action) {
    _controller.action = action;
    _controller.index = _lastIndex;
    _controller.tag = widget.barLetterData[_lastIndex];
    _controller.localPositionY = _lastIndex * widget.itemHeight;
    _controller.globalPositionY = _lastIndex * widget.itemHeight + _widgetTop;
    _controller.value.value++;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = widget.textStyle;
    if (widget.barColor != null) {
      style = TextStyle(fontSize: 12.0, color: widget.barColor);
    }
    _children = List.generate(widget.barLetterData.length, (index) {
      Widget child = widget.itemBuilder == null
          ? Center(
              child: Text("${widget.barLetterData[index]}", style: style),
            )
          : widget.itemBuilder!(context, index);
      return SizedBox(
        width: widget.width,
        height: widget.itemHeight,
        child: child,
      );
    });
    return GestureDetector(
      onVerticalDragDown: (DragDownDetails details) {
        //与接触屏幕，可能会开始垂直移动
        RenderBox box = context.findRenderObject() as RenderBox;
        // box.localToGlobal -> 当前BaseIndexBar布局 到全局 global整个页面布局的 相对距离
        Offset topLeftPosition = box.localToGlobal(Offset.zero);
        _widgetTop = topLeftPosition.dy.toInt();
        int index = _getIndex(details.localPosition.dy);
        if (index >= 0) {
          _lastIndex = index;
          _triggerDragEvent(IndexBarDragDetails.actionDown);
        }
      },
      onVerticalDragUpdate: (DragUpdateDetails details) {
        //与屏幕接触并垂直移动的指针在垂直方向上移动
        int index = _getIndex(details.localPosition.dy);
        if (index >= 0 && _lastIndex != index) {
          _lastIndex = index;
          _triggerDragEvent(IndexBarDragDetails.actionUpdate);
        }
      },
      onVerticalDragEnd: (DragEndDetails details) {
        //之前与屏幕接触并垂直移动的指针不再与屏幕接触，并且在停止接触屏幕时以特定速度移动
        _triggerDragEvent(IndexBarDragDetails.actionEnd);
      },
      onVerticalDragCancel: () {},
      onTap: null,
      behavior: HitTestBehavior.translucent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _children,
      ),
    );
  }
}
