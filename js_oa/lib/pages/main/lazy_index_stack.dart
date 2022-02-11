import 'package:flutter/material.dart';

/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-24 14:53:12
 * @Description: 导航栏懒加载  缓存
 * @FilePath: \js_oa\lib\pages\main\lazy_index_stack.dart
 * @LastEditTime: 2021-11-15 10:09:31
 */
class LazyStackChild {
  final bool preload;

  final Widget? child;

  LazyStackChild({@required this.child, this.preload = false});
}

class LazyIndexStack extends StatefulWidget {
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final StackFit sizing;
  final int? index;
  final List<LazyStackChild> children;
  LazyIndexStack(
      {Key? key,
      this.alignment = AlignmentDirectional.topStart,
      this.textDirection,
      this.sizing = StackFit.loose,
      required this.index,
      this.children = const <LazyStackChild>[]})
      : super(key: key);

  @override
  _LazyIndexStackState createState() => _LazyIndexStackState();
}

class _LazyIndexStackState extends State<LazyIndexStack> {
  late final List<Widget> _childrens;

  late final List<bool> _hasShowedlist;

  @override
  void initState() {
    super.initState();
    int length = widget.children.length;
    _childrens = List.generate(length, (index) {
      if (index == widget.index || widget.children[index].preload) {
        return widget.children[index].child!;
      } else {
        return Container();
      }
    });
    _hasShowedlist = List.generate(length, (index) {
      return index == widget.index || widget.children[index].preload;
    });
  }

  @override
  void didUpdateWidget(covariant LazyIndexStack oldWidget) {
    if (!_hasShowedlist[widget.index!]) {
      _hasShowedlist[widget.index!] = true;
      _childrens[widget.index!] = widget.children[widget.index!].child!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.index,
      children: _childrens,
      alignment: widget.alignment,
      textDirection: widget.textDirection,
      sizing: widget.sizing,
    );
  }
}
