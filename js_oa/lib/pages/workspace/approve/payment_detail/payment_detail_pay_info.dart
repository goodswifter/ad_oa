import 'package:flutter/material.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';

class PaymentDetailPayInfo extends StatelessWidget {
  final GroupInfos? detail;
  PaymentDetailPayInfo({Key? key, this.detail}) : super(key: key);

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
              "缴费人：${detail!.content!.clientName ?? "暂无"}",
            ),
            SizedBox(height: 6),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "缴费金额："),
                  TextSpan(
                      text: "${detail!.content!.money ?? "暂无"}",
                      style: TextStyle(color: Colors.red))
                ],
              ),
            ),
            SizedBox(height: 6),
            Text("缴费时间：${detail!.content!.paymentTime ?? "暂无"}"),
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       TextSpan(text: "缴费时间："),
            //       TextSpan(
            //           text: "${detail!.content!.paymentTime ?? "暂无"}",
            //           style: TextStyle(color: Colors.red))
            //     ],
            //   ),
            // ),
            SizedBox(height: 6),
            Text(
              "缴费方式：${detail!.content!.paymentChannelName ?? "暂无"}",
            ),
            SizedBox(height: 6),
            Text(
              "备注：${detail!.content!.remarks ?? "暂无"}",
            ),
          ],
        ),
      ),
    );
  }
}
