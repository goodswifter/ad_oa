import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_indata.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_service.dart';
import 'package:js_oa/pages/workspace/entity/contract_entity.dart';
import 'package:js_oa/pages/workspace/entity/payment_type_entity.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';
import 'package:js_oa/utils/other/toast_util.dart';

class ContractPaymentFlowController extends GetxController {
  final chooseClient = ClientLists().obs;
  final workflowInfo = WorkflowInfo().obs;
  final contract = ContractItem().obs;
  final paymentTypedata = <PaymentTypeEntity>[].obs;

  var isrefresh = false.obs;

  CreatePaymentIndata indata = CreatePaymentIndata();
  WorkSpaceService workSpaceService = WorkSpaceService();
  TextEditingController clientController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  TextEditingController timeController = TextEditingController(
      text:
          DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString());
  TextEditingController agencyController = TextEditingController(); //代办人
  TextEditingController remarkController = TextEditingController();

  void getContractInfo({int? contractId}) {
    workSpaceService.getOldContractGetContractIntro(
      contractId: contractId,
      success: (value) {
        contract.value = value;
        indata.userId = value.userId;
        contract.refresh();
        //默认选择第一个
        chooseClient.value = value.clients!.first;
        indata.clientId = value.clients!.first.id;
        clientController.text = value.clients!.first.name!;
      },
    );
  }

  void getWorkflowDefinition({
    String? code,
    Function(WorkflowInfo)? successCallBack,
  }) {
    workSpaceService.getWorkflowGetWorkflowDefinition(
        code: code!,
        success: (value) {
          workflowInfo.value = value;
          workflowInfo.refresh();
        });
  }

  void getPaymentType() {
    workSpaceService.getPaymentChannelGetList(
      success: (value) {
        paymentTypedata.value = value;
        //默认选择第一个
        indata.paymentChannelId = value.first.id;
      },
    );
  }

  void createPayment({
    Function(String)? successCallBack,
  }) {
    workSpaceService.postPaymentCreate(
        query: indata,
        success: (value) {
          successCallBack!(value);
        },
        failure: (error) {
          ToastUtil.showToast(error.message);
        });
  }

  bool checkInfo() {
    indata.remarks = remarkController.text;
    if (chooseClient.value.id == null) {
      ToastUtil.showToast("请选择缴费人");
      return false;
    } else {
      indata.clientId = chooseClient.value.id;
    }
    if (clientController.text.isEmpty) {
      ToastUtil.showToast("请选择缴费人");
      return false;
    }
    if (agencyController.text.isEmpty) {
      ToastUtil.showToast("请输入代办人");
      return false;
    } else {
      indata.agent = agencyController.text;
    }
    if (moneyController.text.isEmpty) {
      ToastUtil.showToast("请输入缴费金额");
      return false;
    } else {
      indata.money = moneyController.text;
    }
    if (indata.paymentTime == null) {
      indata.paymentTime = DateFormat("yyyy-MM-dd HH:mm:ss")
          .parse(timeController.text)
          .toUtc()
          .toString();
    }

    if ((chooseClient.value.name != clientController.text) &&
        indata.attachment == null) {
      ToastUtil.showToast("缴费人与客户不一致，请上传情况说明");
      return false;
    }
    return true;
  }
}
