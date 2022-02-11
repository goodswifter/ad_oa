import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/pages/workspace/controller/approve_controller.dart';
import 'package:js_oa/pages/workspace/entity/approve_list_entity.dart';
import 'package:js_oa/utils/workflow/approve_status_until.dart';

class ApproceContentInvoiceCell extends StatelessWidget {
  final ApproveItem? data;
  final int? index;
  ApproceContentInvoiceCell({Key? key, this.data, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ApproveController>(
        id: index,
        builder: (model) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.invoiceDetail, arguments: {
                "workflowId": data!.workflowId,
                "tag": "",
                "index": index
              })!
                  .then((value) {
                print("更新开票状态");
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
                width: double.infinity,
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data!.title ?? "暂无",
                      style: TextStyle(fontSize: 17),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "合同编号：${data!.content!.contractNumber ?? "暂无"}",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 6),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "开票金额：", style: TextStyle(fontSize: 12)),
                          TextSpan(
                              text: "${data!.content!.money ?? "暂无"}",
                              style: TextStyle(fontSize: 12, color: Colors.red))
                        ],
                      ),
                    ),
                    // RichText(text: text),
                    SizedBox(height: 6),
                    Text(
                      "开票时间：${data!.content!.invoiceDate ?? "暂无"}",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        // Icon(Icons.people_alt_outlined),
                        // SizedBox(width: 6),
                        // Expanded(
                        //   child: Text(
                        //     "由${data!.content!.clientName}提交",
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
