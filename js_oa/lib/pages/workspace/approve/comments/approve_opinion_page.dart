import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_service.dart';
import 'package:js_oa/pages/workspace/controller/approve_controller.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:js_oa/widgets/alert_sheet/alert_dialog_widget.dart';

class ApproveOpinionPage extends StatefulWidget {
  ApproveOpinionPage({Key? key}) : super(key: key);

  @override
  _ApproveOpinionPageState createState() => _ApproveOpinionPageState();
}

class _ApproveOpinionPageState extends State<ApproveOpinionPage> {
  TextEditingController textFileController = TextEditingController();
  Map dic = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("审批意见"),
          actions: [
            TextButton(
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (ctx) => AlertDialogWidget(
                      title: "确认提交",
                      confirmTitle: "提交",
                      confirmPressed: () {
                        WorkSpaceService().postWorkflowApproveWork(
                            executionPointerId: dic["pointerId"],
                            pass: dic["pass"],
                            remarks: textFileController.text,
                            success: (value) {
                              if (value) {
                                switch (dic["code"]) {
                                  case "Invoice":
                                  case "Payment":
                                    ApproveController approveCtl =
                                        Get.put(ApproveController());
                                    if (approveCtl.data.length > 0) {
                                      approveCtl.data[dic["index"]]
                                          .approveStatus = dic["pass"] ? 1 : 2;
                                      approveCtl.update([dic["index"]]);
                                      Get.until((route) =>
                                          Get.currentRoute ==
                                          AppRoutes.approve);
                                    } else {
                                      Get.until((route) =>
                                          Get.currentRoute ==
                                          AppRoutes.systemMessage);
                                    }

                                    break;
                                  // case "Payment":
                                  //   ApproveController approveCtl =
                                  //       Get.put(ApproveController());
                                  //   if (approveCtl.data.length > 0) {
                                  //     approveCtl.data[dic["index"]]
                                  //         .approveStatus = dic["pass"] ? 1 : 2;
                                  //     approveCtl.update([dic["index"]]);
                                  //     Get.until((route) =>
                                  //         Get.currentRoute ==
                                  //         AppRoutes.approve);
                                  //   } else {
                                  //     Get.until((route) =>
                                  //         Get.currentRoute ==
                                  //         AppRoutes.conversation);
                                  //   }
                                  //   break;
                                  default:
                                    Get.back();
                                }
                                EasyLoading.showSuccess("审批成功");
                              }
                            },
                            failure: (error) {
                              ToastUtil.showToast(error.message);
                            });
                      },
                    ),
                  );
                },
                child: Text(
                  "提交",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        body: Column(
          children: [
            SizedBox(height: 1),
            Container(
              color: Colors.white,
              constraints: BoxConstraints(
                  maxHeight: 250,
                  maxWidth: double.infinity,
                  minHeight: 48.0,
                  minWidth: double.infinity),
              padding: EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
              child: TextField(
                maxLines: null,
                controller: textFileController,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration.collapsed(
                  hintText: "审批意见",
                ),
              ),
            ),
          ],
        ));
  }
}
