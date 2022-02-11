/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-06 14:23:38
 * @Description: 未读消息 数字角标二次封装
 * @FilePath: \js_oa\lib\widgets\message\badge_widget.dart
 * @LastEditTime: 2021-11-15 10:49:30
 */
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

class JsBadge extends StatelessWidget {
  final int readCounts;
  final Widget child;
  const JsBadge({Key? key, required this.readCounts, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Badge(
      elevation: 0.5,
      padding: const EdgeInsets.only(left: 5, right: 5, top: 3, bottom: 3),
      shape: readCounts > 9 ? BadgeShape.square : BadgeShape.circle,
      borderRadius:
          readCounts > 9 ? BorderRadius.circular(10) : BorderRadius.zero,
      showBadge: readCounts != 0,
      child: child,
      badgeContent: Text(
        readCounts > 99 ? "99+" : readCounts.toString(),
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
