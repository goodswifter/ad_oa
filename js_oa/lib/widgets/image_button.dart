import 'package:flutter/material.dart';
import 'package:js_oa/res/dimens.dart';
import 'package:js_oa/res/gaps.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-18 15:52:27
/// Description  :
///

class ImageButton extends StatelessWidget {
  final Widget image;
  final String title;
  final double titleSize;
  final int? badge;
  final double width;
  final double height;
  final double gap;
  final Function()? onTap;

  ImageButton({
    required this.image,
    required this.title,
    this.titleSize = 14,
    this.badge = 0,
    this.width = 50,
    this.height = 88,
    this.gap = 4,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: width,
        // height: height,
        // color: Colors.yellow,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                image,
                badgeWidget(context),
              ],
              clipBehavior: Clip.none,
            ),
            SizedBox(height: gap),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: titleSize),
            ),
          ],
        ),
      ),
    );
  }

  Widget badgeWidget(BuildContext context) {
    return Positioned(
      top: -8,
      right: -10,
      child: badge != 0
          ? DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).errorColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.5, vertical: 2.0),
                child: Text(
                  "$badge",
                  style: TextStyle(
                      color: Colors.white, fontSize: Dimens.font_sp10),
                ),
              ),
            )
          : Gaps.empty,
    );
  }
}
