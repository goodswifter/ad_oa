import 'package:flutter/material.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/res/text_styles.dart';
import 'package:js_oa/utils/other/text_util.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-07 16:45:34
/// Description  :
///

class PhoneTitleWidget extends StatelessWidget {
  final String title;
  final String? subtitle;

  PhoneTitleWidget({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Text(title, style: TextStyles.textBold24),
            alignment: Alignment.centerLeft,
          ),
          Container(
            height: 40,
            child: TextUtil.isNotEmpty(subtitle)
                ? Text(subtitle!, style: TextStyles.textGray14)
                : Gaps.empty,
          ),
        ],
      ),
    );
  }
}
