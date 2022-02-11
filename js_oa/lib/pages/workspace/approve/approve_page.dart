import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/approve/approve_content.dart';

class ApprovePage extends StatelessWidget {
  ApprovePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = Get.arguments;
    int contentType = 0;
    // if (title.contains("待处理")) {
    //   contentType = 1;
    // }
    switch (title) {
      case "待处理":
        contentType = 1;
        break;
      case "已处理":
        contentType = 2;
        break;
      case "已发起":
        contentType = 3;
        break;
      case "我收到":
        contentType = 4;
        break;
      default:
        contentType = 1;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // backgroundColor: Colors.yellow,
      ),
      body: ApproceContent(contentType: contentType),
    );
  }
}
