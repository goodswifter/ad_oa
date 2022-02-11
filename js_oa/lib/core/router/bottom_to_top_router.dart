/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-03 14:32:33
 * @Description: 下 -> 上 路由切换效果
 * @FilePath: \js_oa\lib\core\router\bottom_to_top_router.dart
 * @LastEditTime: 2021-11-03 14:32:34
 */
import 'package:flutter/material.dart';

class BottomToTopRouter<T> extends PageRouteBuilder<T> {
  final Widget page;
  BottomToTopRouter({required this.page})
      : super(
            transitionDuration: Duration(milliseconds: 300),
            pageBuilder: (context, a1, a2) {
              return page;
            },
            transitionsBuilder: (context, a1, a2, Widget child) {
              return SlideTransition(
                position: Tween<Offset>(
                        begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
                    .animate(CurvedAnimation(
                        parent: a1, curve: Curves.fastOutSlowIn)),
                child: child,
              );
            });
}
