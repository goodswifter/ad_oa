import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/res/images.dart';
import 'package:js_oa/res/text_styles.dart';
import 'package:js_oa/widgets/load_image.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-23 14:28:06
/// Description  :
///

class MineListItem extends StatelessWidget {
  final String title;
  final String? leadImage;
  final IconData leadIcon;
  final String route;
  final String subTitle;
  final GestureTapCallback? onTap;

  MineListItem({
    required this.title,
    this.leadImage = "",
    this.leadIcon = Icons.home_filled,
    this.route = "",
    this.subTitle = "",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: ListTile(
        tileColor: Colors.white,
        leading:
            leadImage!.length > 0 ? LoadAssetImage(leadImage!) : Icon(leadIcon),
        title: Text(
          title,
          style: TextStyle(fontSize: 16),
        ),
        trailing: Container(
          alignment: Alignment.centerRight,
          width: 180,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              subTitle != ""
                  ? Text(
                      subTitle,
                      style: TextStyles.textGray14,
                    )
                  : Gaps.empty,
              Images.arrowRight,
            ],
          ),
        ),
        onTap: onTap == null ? () => Get.toNamed(route) : onTap,
      ),
    );
  }
}
