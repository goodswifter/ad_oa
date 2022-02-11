import 'package:flutter/material.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';

class InvoiceDetailContentInfo extends StatelessWidget {
  final GroupInfos? detail;
  InvoiceDetailContentInfo({Key? key, this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(left: 12, top: 12, right: 12),
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("发票类型：${detail!.content!.invoiceTypeName ?? "暂无"}"),
            // SizedBox(height: 6),
            // Text("开票名称：单位"),
            SizedBox(height: 6),
            Text("开票名称：${detail!.content!.clientName ?? "暂无"}"),
            SizedBox(height: 6),
            // Text("纳税人识别号码：1326002906613260029066"),
            // SizedBox(height: 6),
            Text("开户行：${detail!.content!.bank ?? "暂无"}"),
            SizedBox(height: 6),
            Text("银行账户：${detail!.content!.bankAccount ?? "暂无"}"),
            SizedBox(height: 6),
            Text("地址：${detail!.content!.address ?? "暂无"}"),
            SizedBox(height: 6),
            Text("电话：${detail!.content!.tel ?? "暂无"}"),
            SizedBox(height: 6),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "开票金额："),
                  TextSpan(
                      text: "${detail!.content!.money ?? "暂无"}",
                      style: TextStyle(color: Colors.red))
                ],
              ),
            ),
            SizedBox(height: 6),
            Text("开票时间：${detail!.content!.invoiceDate ?? "暂无"}"),
            // Text.rich(
            //   TextSpan(
            //     children: [
            //       TextSpan(text: "开票时间："),
            //       TextSpan(
            //           text: "${detail!.content!.invoiceDate ?? "暂无"}",
            //           style: TextStyle(color: Colors.red))
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
