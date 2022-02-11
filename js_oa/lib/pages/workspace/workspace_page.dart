import 'package:flutter/material.dart';
import 'package:js_oa/pages/workspace/workspace_content.dart';

class WorkspacePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("工作台"),
        automaticallyImplyLeading: false,
      ),
      body: WorkContent(),
    );
  }
}
