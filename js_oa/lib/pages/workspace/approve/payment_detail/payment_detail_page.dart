import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/approve/payment_detail/payment_detail_content.dart';

class PaymentDetailPage extends StatelessWidget {
  const PaymentDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map? arguments = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("详情"),
      ),
      body: SafeArea(
          child: PaymentDetailContent(
        workflowId: arguments!["workflowId"],
        tag: arguments["tag"],
        index: arguments["index"],
      )),
    );
  }
}
