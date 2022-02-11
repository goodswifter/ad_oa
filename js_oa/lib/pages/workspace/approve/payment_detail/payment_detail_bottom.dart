import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/pages/workspace/controller/approve_controller.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/widgets/alert_sheet/alert_dialog_widget.dart';

class PaymentDetailBottom extends StatelessWidget {
  final String? tag; //从哪个页面来
  final int? index; //从第几行过来的
  final WorkflowDetailEntity? data;
  PaymentDetailBottom({Key? key, this.tag, this.data, this.index})
      : super(key: key);
  final ApproveController controller = Get.put(ApproveController());
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 60) / 2;
    if (loginController.userinfo.value.id == data!.creatorUserId &&
        tag == "3") {
      //是自己的提交的审批
      switch (data!.approveStatus) {
        case 0: //审核中
        case 4: //等待审核
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            height: 60,
            width: double.infinity,
            child: Container(
              height: 44,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (ctx) => AlertDialogWidget(
                      title: "确认撤销",
                      confirmTitle: "撤销",
                      confirmPressed: () {
                        controller.revokeWorkFlow(
                            flowId: data!.workflowId,
                            successCallBack: (value) {
                              EasyLoading.showSuccess("撤销成功");
                              Get.back(
                                  result: {"isSuccess": true, "status": 3});
                            });
                      },
                    ),
                  );
                },
                child: Text(
                  "撤销",
                  // style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          );
        case 2: //审核未通过
        case 3: //已撤销
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            height: 60,
            width: double.infinity,
            child: Container(
              height: 44,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                onPressed: () {
                  switch (data!.code) {
                    case "Invoice":
                      Get.toNamed(AppRoutes.contractInvoiceFlow,
                          arguments: data!.contractId);
                      break;
                    case "Payment":
                      Get.toNamed(AppRoutes.contractPaymentFlow,
                          arguments: data!.contractId);
                      break;
                    default:
                  }
                },
                child: Text(
                  "重新提交",
                  // style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          );
        default:
          return Container();
      }
    } else {
      if (data!.workflowInfo!.canHandle!) {
        return Container(
          height: 60,
          // color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: width,
                height: 44,
                decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.approveOpinion,
                      arguments: {
                        "pointerId":
                            data!.workflowInfo!.handleExecutionPointerId!,
                        "workflowId": data!.workflowId,
                        "code": data!.code,
                        "pass": false,
                        "index": index,
                      },
                    );
                  },
                  child: Text(
                    "拒绝",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ),
              ),
              Container(
                height: 44,
                width: width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    // border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5)),
                child: TextButton(
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.approveOpinion,
                      arguments: {
                        "pointerId":
                            data!.workflowInfo!.handleExecutionPointerId!,
                        "workflowId": data!.workflowId,
                        "code": data!.code,
                        "pass": true,
                        "index": index,
                      },
                    );
                  },
                  child: Text(
                    "同意",
                    style: TextStyle(fontSize: 15, color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        );
      } else {
        String statusStr = "";
        switch (data!.approveStatus) {
          case 1: //通过
            statusStr = "审核已通过";
            break;
          case 2: //未通过
            statusStr = "审核未通过";
            break;
          case 3: //已撤销
            statusStr = "申请已撤销";
            break;
          default:
            statusStr = "未知状态";
        }
        return Container(
          height: 60,
          width: double.infinity,
          // color: Colors.white,
          child: Center(child: Text(statusStr)),
        );
      }
    }
  }
}
