import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';

class ContractRefundRecordCell extends StatelessWidget {
  const ContractRefundRecordCell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.invoiceDetail);
        },
        child: Card(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "退款金额：8888",
                  style: TextStyle(fontSize: 17),
                ),
                SizedBox(height: 12),
                Text(
                  "收款人账号：64564621891231321",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 6),
                Text(
                  "收款人姓名：张兴",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 6),
                Text(
                  "收款人开户行：上海浦发银行",
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.people_alt_outlined),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "由张翔兵提交",
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    Text("已由XX处理"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
