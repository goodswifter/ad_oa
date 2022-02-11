import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/constants/resource.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/pages/workspace/entity/workspace_layout_entity.dart';
import 'package:js_oa/widgets/image_button.dart';

class WorkContentCell extends StatelessWidget {
  final WorkspaceLayoutEntity? work;
  WorkContentCell({Key? key, this.work});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 12, top: 12, right: 12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              work!.groupName!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.fromLTRB(4, 0, 4, 8),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: work!.items!.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, //交叉轴 子Widget的个数
                crossAxisSpacing: 2, //交叉轴  分割线宽度
                mainAxisSpacing: 2, //主轴 分割线宽度
                childAspectRatio: 0.9 //item的宽高比
                ),
            itemBuilder: (BuildContext context, int index) {
              return ImageButton(
                gap: 4,
                title: work!.items![index].name!,
                titleSize: 13,
                image: Image.network(
                  work!.items![index].icon!,
                  // "https://img1.baidu.com/it/u=666639976,4125045110&fm=26",
                  width: 40,
                  height: 40,
                  errorBuilder: (context, obj, trace) {
                    return Image.asset(
                      R.ASSETS_IMAGES_WORKSPACE_DEFAULT_PNG,
                      width: 40,
                      height: 40,
                    );
                  },
                ),
                onTap: () {
                  switch (work!.items![index].route) {
                    case "Invoice":
                    case "Payment":
                      Get.toNamed(AppRoutes.contract,
                          arguments: work!.items![index]);
                      break;
                    case "NonBusinessContractFiling":
                      Get.toNamed(AppRoutes.noBusinessRecordPage);
                      break;
                    default:
                      Get.toNamed(AppRoutes.unknown);
                  }
                },
              );
              // return Container(
              //   height: 300,
              //   color: Colors.pink,
              // );
            },
          )
        ],
      ),
    );
  }
}
