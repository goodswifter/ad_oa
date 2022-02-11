import 'package:flutter/material.dart';
import 'package:js_oa/core/layout/int_extension.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/res/images.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-10-22 17:01:22
/// Description  :
///

class PersonInfoListTileItem extends StatelessWidget {
  PersonInfoListTileItem({
    required this.title,
    this.trailing,
    this.isShowArrow = true,
    this.onTap,
  });

  final String title;
  final String? trailing;
  final bool isShowArrow;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 52.px,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.px,
          vertical: 1.px,
        ),
        tileColor: Colors.white,
        title: Text(title),
        trailing: trailing != null
            ? GestureDetector(
                onTap: onTap,
                child: Container(
                  color: Colors.white,
                  alignment: Alignment.centerRight,
                  width: 200,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(trailing!),
                      isShowArrow ? Images.arrowRight : Gaps.empty,
                    ],
                  ),
                ),
              )
            : Gaps.empty,
      ),
    );
  }
}
