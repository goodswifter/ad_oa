/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-31 15:06:04
 * @Description: 通讯录搜索结果 item布局
 * @FilePath: \js_oa\lib\pages\contacts\search\search_result_item_widget.dart
 * @LastEditTime: 2021-12-07 15:48:24
 */
import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/widgets/contact/avatar_widget.dart';

typedef RouteBuilder = Function();

class ContactSearchResultItemWidget extends StatelessWidget {
  final String? avatar;
  final String name;
  final String phoneNumber;
  final RouteBuilder? routeBuilder;
  const ContactSearchResultItemWidget(
      {Key? key,
      this.avatar = "",
      this.name = "",
      this.phoneNumber = "",
      this.routeBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 68,
      child: InkWell(
        onTap: () {
          if (routeBuilder != null) {
            routeBuilder!.call();
          }
        },
        child: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 68,
                height: 68,
                child: Padding(
                  padding: const EdgeInsets.all(11),
                  child: PhysicalModel(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(4.8),
                    clipBehavior: Clip.antiAlias,
                    child: Avatar(
                      width: 48,
                      height: 48,
                      radius: 0,
                      avatar: (avatar == null || avatar == "") ? name : avatar!,
                      userName: name,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: JSColors.hexToColor("ededed"),
                              width: 1,
                              style: BorderStyle.solid))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 22,
                        margin: const EdgeInsets.only(top: 12),
                        child: Text(name,
                            style: TextStyle(
                                color: JSColors.hexToColor("111111"),
                                height: 1)),
                      ),
                      Container(
                        height: 28,
                        margin: const EdgeInsets.only(top: 2),
                        child: Text(
                          phoneNumber,
                          style: TextStyle(
                            color: JSColors.textWeakColor,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
