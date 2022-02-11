import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/pages/workspace/entity/contract_entity.dart';

class ContractMineCell extends StatelessWidget {
  final ContractItem? detail;
  final String? financeType;
  ContractMineCell({Key? key, this.detail, this.financeType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        switch (financeType) {
          case "Invoice":
            Get.toNamed(AppRoutes.contractInvoiceFlow, arguments: detail!.id);
            break;
          case "Payment":
            Get.toNamed(AppRoutes.contractPaymentFlow, arguments: detail!.id);
            break;
          default: //测试
        }
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
                "合同类别：${detail!.contractTypeName ?? "暂无"}",
              ),
              SizedBox(height: 8),
              Text(
                "合同编号：${detail!.contractNumber ?? "暂无"}",
              ),
              SizedBox(height: 8),
              Text(
                "业务来源：${detail!.clientSourceName ?? "暂无"}",
              ),
              SizedBox(height: 8),
              Text(
                "委托方：${clientListString(detail!.clients ?? [])}",
              ),
              SizedBox(height: 8),
              Text(
                "利益相对方：${clientListString(detail!.privies ?? [])}",
              ),
              SizedBox(height: 8),
              Text(
                "第三方：${clientListString(detail!.thirdParties ?? [])}",
              ),
              SizedBox(height: 8),
              Text(
                "负责律师：${detail!.realName ?? "暂无"}",
              ),
            ],
          ),
        ),
      ),
    );
  }

  String clientListString(List<ClientLists> clients) {
    String clientStr = "";
    if (clients.length > 0) {
      for (ClientLists item in clients) {
        clientStr += item.name! + " ";
      }
    }
    return clientStr == "" ? "暂无" : clientStr;
  }
}
