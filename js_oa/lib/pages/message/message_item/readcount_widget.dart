/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-22 17:47:50
 * @Description: 消息列表item 未读消息 widget
 * @FilePath: \js_oa\lib\pages\message\message_item\readcount_widget.dart
 * @LastEditTime: 2021-11-24 17:37:33
 */
import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';

class UnreadCountWidget extends StatelessWidget {
  final int unreadCount;
  const UnreadCountWidget({Key? key, required this.unreadCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: unreadCount > 0
          ? PhysicalModel(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(9),
              clipBehavior: Clip.antiAlias,
              child: Container(
                color: JSColors.readColor,
                width: 18,
                height: 18,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      unreadCount > 99 ? '...' : unreadCount.toString(),
                      textAlign: TextAlign.center,
                      textWidthBasis: TextWidthBasis.parent,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            )
          : null,
      width: 18,
      height: 18,
      margin: const EdgeInsets.only(right: 16),
    );
  }
}
