import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/pages/workspace/approve/workflow/workflow.dart';
import 'package:js_oa/pages/workspace/controller/contract_controller.dart';
import 'package:js_oa/pages/workspace/controller/contract_invoice_flow_controller.dart';
import 'package:js_oa/pages/workspace/entity/contract_entity.dart';
import 'package:js_oa/pages/workspace/widgets/customRadio.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/widgets/alert_sheet/alert_dialog_widget.dart';

class ContractInvoiceFlow extends StatefulWidget {
  ContractInvoiceFlow({Key? key}) : super(key: key);

  @override
  _ContractInvoiceFlowState createState() => _ContractInvoiceFlowState();
}

class _ContractInvoiceFlowState extends State<ContractInvoiceFlow> {
  int? contractId = Get.arguments;
  late int invoiceTypegroupValue = 0;
  late int chooseClientgroupValue = 0;
  ContractInvoiceFlowController controller =
      Get.put(ContractInvoiceFlowController());

  @override
  void initState() {
    controller.indata.contractId = contractId.toString();
    controller.getContractInfo(contractId: contractId);
    controller.getWorkflowDefinition(code: "Invoice");
    controller.getInvoiceType();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("案件开票"),
          actions: [
            TextButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.contractInvoiceHistory,
                      arguments: controller.contract.value.id);
                },
                child: Text(
                  "历史记录",
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("合同概要"),
                            SizedBox(height: 8),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16),
                              color: Colors.white,
                              child: Obx(() {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "合同类别：${controller.contract.value.contractTypeName ?? " 暂无"}",
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "合同编号：${controller.contract.value.contractNumber ?? " 暂无"}",
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "业务来源：${controller.contract.value.clientSourceName ?? " 暂无"}",
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "委托方：${clientListString(controller.contract.value.clients ?? [])}",
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "利益相对方：${clientListString(controller.contract.value.privies ?? [])}",
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "第三方：${clientListString(controller.contract.value.thirdParties ?? [])}",
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      "负责律师：${controller.contract.value.realName ?? " 暂无"}",
                                    ),
                                  ],
                                );
                              }),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("选择客户"),
                            SizedBox(height: 8),
                            Obx(() {
                              return controller.contract.value.clients != null
                                  ? clientList(
                                      controller.contract.value.clients ?? [])
                                  : Container();
                            })
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("发票信息"),
                            SizedBox(height: 8),
                            invoiceInfo(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("选择发票类型"),
                            SizedBox(height: 8),
                            Obx(() {
                              return controller.invoiceTypedata.length > 0
                                  ? chooseInvoiceType()
                                  : Container();
                            })
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("开票金额"),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Icon(Icons.star_rate,
                                      size: 12, color: Colors.red),
                                  SizedBox(width: 4),
                                  Text(
                                    "输入开票金额（元）：",
                                    style: TextStyle(
                                        color: JSColors.textWeakColor),
                                  ),
                                  Expanded(
                                      child: TextField(
                                    controller: controller.moneyController,
                                    style: TextStyle(fontSize: 14),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("开票时间"),
                            SizedBox(height: 8),
                            invoiceTime(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("备注"),
                            SizedBox(height: 8),
                            Container(
                              color: Colors.white,
                              constraints: BoxConstraints(
                                  maxHeight: 150,
                                  maxWidth: double.infinity,
                                  minHeight: 50.0,
                                  minWidth: double.infinity),
                              padding: EdgeInsets.all(16),
                              child: TextField(
                                maxLines: null,
                                controller: controller.remarkController,
                                style: TextStyle(fontSize: 14),
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration.collapsed(
                                  hintText: "备注：仅限500字以内",
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("进展流程"),
                            SizedBox(height: 8),
                            Obx(() {
                              return controller
                                          .workflowInfo.value.workflowSteps !=
                                      null
                                  ? WorkFlow(
                                      flowInfo: controller.workflowInfo.value)
                                  : Container();
                            }),
                          ],
                        ),
                      ),
                      // SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                width: double.infinity,
                // color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: TextButton(
                      onPressed: () {
                        if (controller.checkInfo()) {
                          showCupertinoDialog(
                            context: context,
                            builder: (ctx) => AlertDialogWidget(
                              title: "确认提交",
                              confirmTitle: "提交",
                              confirmPressed: () {
                                controller.createInvoice(
                                    successCallBack: (value) {
                                  ContractController ctl =
                                      Get.put(ContractController());
                                  ctl.invoiceLoad();
                                  EasyLoading.showSuccess("提交成功");
                                  Get.back();
                                });
                              },
                            ),
                          );
                        }
                      },
                      child: Text(
                        "提交",
                        // style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              )
            ],
            // ),
          ),
        ));
  }

  Widget clientList(List<ClientLists> clients) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: clients.length,
              itemBuilder: (buildContext, index) {
                return CustomRadio<int>(
                  value: index,
                  groupValue: chooseClientgroupValue,
                  lable: Text(clients[index].name!),
                  onChanged: (value) {
                    setState(() {
                      controller.chooseClient.value = clients[value];
                      chooseClientgroupValue = value;
                      controller.indata.clientId = clients[value].id;
                      controller.getInvoiceInfo();
                    });
                  },
                );
              })
        ],
      ),
    );
  }

  Widget invoiceInfo() {
    return Obx(() {
      return Container(
        // height: 166,
        padding: EdgeInsets.all(16),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "开票名称：${controller.invoiceInfo.value.name ?? "暂无"}",
                ),
                SizedBox(height: 8),
                Text(
                  "开户行：${controller.invoiceInfo.value.bank ?? "暂无"}",
                ),
                SizedBox(height: 8),
                Text(
                  "银行账户：${controller.invoiceInfo.value.bankAccount ?? "暂无"}",
                ),
                SizedBox(height: 8),
                Text(
                  "地址：${controller.invoiceInfo.value.address ?? "暂无"}",
                ),
                SizedBox(height: 8),
                Text(
                  "电话：${controller.invoiceInfo.value.tel ?? "暂无"}",
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget chooseInvoiceType() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.invoiceTypedata.length,
              itemBuilder: (buildContext, index) {
                return CustomRadio<int>(
                  value: index,
                  groupValue: invoiceTypegroupValue,
                  lable: Text(controller.invoiceTypedata[index].name!),
                  onChanged: (value) {
                    setState(() {
                      invoiceTypegroupValue = value;
                      controller.indata.invoiceTypeId =
                          controller.invoiceTypedata[value].id;
                    });
                  },
                );
              })
        ],
      ),
    );
  }

  Widget invoiceTime() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Row(
        children: [
          Icon(Icons.star_rate, size: 12, color: Colors.red),
          SizedBox(width: 4),
          Text(
            "选择开票时间：",
            style: TextStyle(color: JSColors.textWeakColor),
          ),
          Expanded(
              child: TextField(
            controller: controller.invoiceDateController,
            style: TextStyle(fontSize: 14),
            keyboardType: TextInputType.none,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            onTap: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  minTime: DateTime(2021, 1, 1, 00, 01),
                  maxTime: DateTime(2099, 12, 31, 23, 59), onChanged: (date) {
                // print('change $date in time zone ' +
                //     date.timeZoneOffset.inHours.toString());
                // print('time zone $date');
              }, onConfirm: (date) {
                controller.invoiceDateController.text =
                    DateFormat("yyyy-MM-dd HH:mm:ss").format(date).toString();
                controller.indata.invoiceDate = date.toUtc().toString();
                print(date.toUtc().toString());
              }, locale: LocaleType.zh);
            },
          ))
        ],
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
