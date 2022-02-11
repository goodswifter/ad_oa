import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/pages/workspace/controller/approve_controller.dart';
import 'package:js_oa/pages/workspace/entity/approve_list_entity.dart';
import 'package:js_oa/utils/workflow/approve_status_until.dart';

class ApproveContentPaymentCell extends StatelessWidget {
  final ApproveItem? data;
  final int? index;
  ApproveContentPaymentCell({Key? key, this.data, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApproveController>(
        id: index,
        builder: (model) {
          return GestureDetector(
            onTap: () {
              print(data!.workflowId);
              Get.toNamed(AppRoutes.paymentDetail, arguments: {
                "workflowId": data!.workflowId,
                "tag": "",
                "index": index
              })!
                  .then((value) {
                print("更新缴费状态");
                if (value == null) {
                  return;
                }
                if (value["isSuccess"]) {
                  model.data[index!].approveStatus = value["status"];
                  model.update([index!]);
                }
              });
            },
            child: Card(
              margin: EdgeInsets.only(left: 12, top: 12, right: 12),
              child: Container(
                padding: EdgeInsets.all(12.0),
                // height: 175,
                // color: Colors.pink,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data!.title ?? "暂无",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 12),
                    // Text("缴费次数：2",
                    //     style:
                    //         TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                    // SizedBox(height: 6),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "缴费金额：", style: TextStyle(fontSize: 12)),
                          TextSpan(
                              text: "${data!.content!.money ?? "暂无"}",
                              style: TextStyle(fontSize: 12, color: Colors.red))
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    Text("缴费时间：${data!.content!.paymentTime ?? "暂无"}",
                        style: TextStyle(fontSize: 12)),
                    SizedBox(height: 6),
                    Text("缴费方式：${data!.content!.paymentChannelName ?? "暂无"}",
                        style: TextStyle(fontSize: 12)),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        // Icon(Icons.people),
                        // SizedBox(width: 6),
                        // Expanded(
                        //   child: Text(
                        //     "缴费方式：${data!.content!.paymentChannelName}",
                        //     style: TextStyle(fontSize: 14),
                        //   ),
                        // ),
                        Text(
                          ApproveStatusUntil.getApproveStatusStr(
                                      data!.approveStatus)
                                  .ststusStr ??
                              "暂无",
                          style: TextStyle(
                              color: ApproveStatusUntil.getApproveStatusStr(
                                      data!.approveStatus)
                                  .color),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
