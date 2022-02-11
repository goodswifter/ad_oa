import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/pages/workspace/controller/contract_controller.dart';
import 'package:js_oa/pages/workspace/entity/payment_list_entity.dart';
import 'package:js_oa/utils/workflow/approve_status_until.dart';

class ContractPaymentRecordCell extends StatelessWidget {
  final PaymentItems? data;
  final int? index;
  ContractPaymentRecordCell({Key? key, this.data, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContractController>(
        id: index,
        builder: (model) {
          return GestureDetector(
            onTap: () {
              // print(data!.workflowId);
              Get.toNamed(AppRoutes.paymentDetail,
                      arguments: {"workflowId": data!.workflowId, "tag": ""})!
                  .then((value) {
                if (value == null) {
                  return;
                }
                if (value["isSuccess"]) {
                  (model.recordData[index!] as PaymentItems).approveStatus =
                      value["status"];
                  model.update([index!]);
                }
              });
            },
            child: Card(
              margin: EdgeInsets.only(left: 12, top: 12, right: 12),
              child: Container(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "缴费人：${data!.clientName ?? "暂无"}",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 12),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: "缴费金额：", style: TextStyle(fontSize: 12)),
                          TextSpan(
                              text: "${data!.money ?? "暂无"}",
                              style: TextStyle(fontSize: 12, color: Colors.red))
                        ],
                      ),
                    ),
                    SizedBox(height: 6),
                    Text("缴费时间：${data!.paymentTime ?? "暂无"}",
                        style: TextStyle(fontSize: 12)),
                    SizedBox(height: 6),
                    Text("缴费方式：${data!.paymentChannelName ?? "暂无"}",
                        style: TextStyle(fontSize: 12)),
                    SizedBox(height: 6),
                    Row(
                      children: [
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
