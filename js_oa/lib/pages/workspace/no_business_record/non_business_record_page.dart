import 'package:flutter/material.dart';
import 'package:js_oa/pages/workspace/no_business_record/non_business_record_content.dart';

class NonBusinessRecordPage extends StatelessWidget {
  const NonBusinessRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("非业务合同备案"),
      ),
      body: SafeArea(child: NonBusinessRecordContent()),
    );
  }
}
