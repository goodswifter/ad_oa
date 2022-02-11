/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-25 10:17:29
 * @Description: 字母索引的竖直长条视图 【a-z视图】
 * @FilePath: \js_oa\lib\pages\contacts\letter_list\letter_index_bar.dart
 * @LastEditTime: 2021-11-15 09:49:02
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_index_bar.dart';
import 'index_bar_config_data.dart';
import '../../../controller/contact/index_bar_detail_controller.dart';
import 'index_bar_options.dart';

class LetterIndexBar extends StatefulWidget {
  final IndexBarOption? option;
  final List<String> data;

  LetterIndexBar({
    Key? key,
    this.option,
    this.data = mBarData,
  }) : super(key: key);

  @override
  _LetterIndexBarState createState() => _LetterIndexBarState();
}

class _LetterIndexBarState extends State<LetterIndexBar> {
  final IndexBarDetailController _controller = Get.find();
  static OverlayEntry? _overlayEntry;
  @override
  void initState() {
    super.initState();
    _controller.setOverlayShow(() {
      if (_isActionDown()) {
        _controller.update(["index_bg_color"]);
      } else if (_isActionUpdate()) {
        _addOvlerlay(context);
        _controller.update(["index_bg_color"]);
      } else {
        _removeOverlay();
      }
    });
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  bool _isActionUpdate() {
    return _controller.action == IndexBarDetailController.actionUpdate;
  }

  bool _isActionDown() {
    return _controller.action == IndexBarDragDetails.actionDown;
  }

  _addOvlerlay(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(builder: (BuildContext ctx) {
        double left;
        double top;
        if (_controller.option!.indexHintPosition != null) {
          left = _controller.option!.indexHintPosition!.dx;
          top = _controller.option!.indexHintPosition!.dy;
        } else {
          if (_controller.option!.indexHintAlignment == Alignment.centerRight) {
            left = MediaQuery.of(context).size.width -
                kIndexBarWidth -
                _controller.option!.indexHintWidth +
                _controller.option!.indexHintOffset.dx;
            top = _controller.floatTop + _controller.option!.indexHintOffset.dy;
          } else {
            left = MediaQuery.of(context).size.width / 2 -
                _controller.option!.indexHintWidth / 2 +
                _controller.option!.indexHintOffset.dx;
            top = MediaQuery.of(context).size.height / 2 -
                _controller.option!.indexHintHeight / 2 +
                _controller.option!.indexHintOffset.dy;
          }
        }
        return Positioned(
            left: left,
            top: top,
            child: Material(
              color: Colors.transparent,
              child: _buildIndexHint(ctx, _controller.indexTag),
            ));
      });
      overlayState!.insert(_overlayEntry!);
    } else {
      //重新绘制UI，类似setState
      _overlayEntry!.markNeedsBuild();
    }
  }

  Widget _buildIndexHint(BuildContext context, String tag) {
    //可以暴露悬空布局的构造方式给外部使用
    Widget child;
    TextStyle textStyle = _controller.option!.indexHintTextStyle;
    child = Text('$tag', style: textStyle);
    return Container(
      alignment: _controller.option!.indexHintChildAlignment,
      width: _controller.option!.indexHintWidth,
      height: _controller.option!.indexHintHeight,
      decoration: _controller.option!.indexHintDecoration,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      width: 28,
      // height: 600,
      margin: EdgeInsets.only(
          right: widget.option!.rightMargin, top: widget.option!.topMargin),
      alignment: Alignment.center,
      child: BaseIndexBar(
        barLetterData: _controller.option!.barData,
        itemHeight: _controller.itemHeight!,
        itemBuilder: (BuildContext context, int index) {
          return GetBuilder<IndexBarDetailController>(
              id: "index_bg_color",
              builder: (controller) {
                return _buildItem(context, index);
              });
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    String tag = widget.data[index];
    Decoration decoration;
    TextStyle textStyle;
    //_isActionDown() &&
    decoration = (_controller.selectIndex == index)
        ? _controller.option!.downItemDecoration
        : BoxDecoration();
    textStyle = (_controller.selectIndex == index)
        ? TextStyle(fontSize: 12, color: Colors.white)
        : widget.option!.defaultTextStyle;
    return Container(
      alignment: Alignment.center,
      decoration: decoration,
      child: Text('$tag', style: textStyle),
    );
  }
}
