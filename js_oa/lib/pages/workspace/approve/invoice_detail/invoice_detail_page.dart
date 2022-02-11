import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/approve/invoice_detail/invoice_detail_content.dart';

class InvoiceDetailPage extends StatelessWidget {
  const InvoiceDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map? arguments = Get.arguments;
    return Scaffold(
      appBar: AppBar(title: Text("详情")),
      body: SafeArea(
          child: InvoiceDetailContent(
        workflowId: arguments!["workflowId"],
        tag: arguments["tag"],
        index: arguments["index"],
      )),
    );
  }
}
