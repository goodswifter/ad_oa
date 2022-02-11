import 'package:flutter/material.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';

class PaymentDetailContract extends StatelessWidget {
  final WorkFlowDetailContent? detail;
  PaymentDetailContract({Key? key, this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(left: 12, top: 12, right: 12),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "合同类别：${detail!.contractType ?? "暂无"}",
            ),
            SizedBox(height: 6),
            Text(
              "合同编号：${detail!.contractNumber ?? "暂无"}",
            ),
            SizedBox(height: 6),
            Text(
              "业务来源：${detail!.contractSource ?? "暂无"}",
            ),
            SizedBox(height: 6),
            Text(
              "委托方：${detail!.client ?? "暂无"}",
            ),
            SizedBox(height: 6),
            Text(
              "利益相对方：${detail!.privies ?? "暂无"}",
            ),
            SizedBox(height: 6),
            Text(
              "第三方：${detail!.thirdParty ?? "暂无"}",
            ),
            SizedBox(height: 6),
            Text(
              "负责律师：${detail!.lawyerName ?? "暂无"}",
            ),
          ],
        ),
      ),
    );
  }
}
