import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/constants/resource.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/widgets/image_button.dart';

class ApproveBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10), bottomStart: Radius.circular(10)),
        color: Colors.white,
      ),
      height: 96,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ImageButton(
              title: "待处理",
              image: Image.asset(R.ASSETS_IMAGES_WORKSPACE_DAICHULI_PNG),
              onTap: () {
                Get.toNamed(AppRoutes.approve, arguments: "待处理");
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: ImageButton(
              title: "已处理",
              image: Image.asset(R.ASSETS_IMAGES_WORKSPACE_YICHULI_PNG),
              // badge: 10,
              // height: 100,
              onTap: () => Get.toNamed(AppRoutes.approve, arguments: "已处理"),
            ),
          ),
          Expanded(
            flex: 1,
            child: ImageButton(
              title: "已发起",
              image: Image.asset(R.ASSETS_IMAGES_WORKSPACE_YIFAQI_PNG),
              onTap: () => Get.toNamed(AppRoutes.approve, arguments: "已发起"),
            ),
          ),
          Expanded(
            flex: 1,
            child: ImageButton(
              title: "我收到",
              image: Image.asset(R.ASSETS_IMAGES_WORKSPACE_WOSHOUDAO_PNG),
              onTap: () => Get.toNamed(AppRoutes.approve, arguments: "我收到"),
            ),
          ),
        ],
      ),
    );
  }
}
