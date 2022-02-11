/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-22 17:20:47
 * @Description: 消息页面 顶部搜索框
 * @FilePath: \js_oa\lib\pages\message\top_search_widget.dart
 * @LastEditTime: 2021-12-14 09:35:31
 */
import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';

typedef SearchIntentBuilder = Function();

class MessageTopSearchWidget extends StatelessWidget {
  final SearchIntentBuilder intentBuilder;
  const MessageTopSearchWidget({Key? key, required this.intentBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          intentBuilder.call();
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(color: JSColors.homeSearchBackground))),
          child: Container(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
            width: double.infinity,
            padding: const EdgeInsets.only(left: 15, top: 9, bottom: 9),
            decoration: BoxDecoration(
              color: JSColors.homeSearchBackground,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/message/search.png",
                    width: 16, height: 16),
                SizedBox(width: 5),
                Text(' 搜索',
                    style: TextStyle(color: JSColors.black6, fontSize: 14))
              ],
            ),
          ),
        ));
  }
}
