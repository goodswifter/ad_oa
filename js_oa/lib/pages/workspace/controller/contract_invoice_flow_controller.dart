import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_indata.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_service.dart';
import 'package:js_oa/pages/workspace/entity/contract_entity.dart';
import 'package:js_oa/pages/workspace/entity/invoice_info_entity.dart';
import 'package:js_oa/pages/workspace/entity/invoice_type_entity.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:intl/intl.dart';

class ContractInvoiceFlowController extends GetxController {
  final chooseClient = ClientLists().obs;
  final workflowInfo = WorkflowInfo().obs;
  final contract = ContractItem().obs;
  final invoiceInfo = InvoiceInfoEntity().obs;
  final invoiceTypedata = <InvoiceTypeEntity>[].obs;

  CreateInvoiceIndata indata = CreateInvoiceIndata();
  TextEditingController moneyController = TextEditingController();
  TextEditingController invoiceDateController = TextEditingController(
      text:
          DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString());
  TextEditingController invoiceTypeController = TextEditingController();
  TextEditingController remarkController = TextEditingController();
  WorkSpaceService workSpaceService = WorkSpaceService();

  void getContractInfo({int? contractId}) {
    workSpaceService.getOldContractGetContractIntro(
      contractId: contractId,
      success: (value) {
        contract.value = value;
        contract.refresh();
        //默认选择第一个
        chooseClient.value = value.clients!.first;
        indata.clientId = value.clients!.first.id;
        getInvoiceInfo(contractId: value.clients!.first.id);
      },
    );
  }

  void getInvoiceInfo({int? contractId}) {
    workSpaceService.getClientGetOldClientById(
      id: chooseClient.value.id,
      success: (value) {
        invoiceInfo.value = value;
        invoiceInfo.refresh();
      },
    );
  }

  void getInvoiceType({int? contractId}) {
    workSpaceService.getInvoiceTypeGetList(
      success: (value) {
        invoiceTypedata.value = value;
        //默认选择第一个
        indata.invoiceTypeId = value.first.id;
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
          // workflowInfo.update((val) { })
        });
  }

  void createInvoice({
    Function(String)? successCallBack,
  }) {
    workSpaceService.posInvoiceCreate(
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
    if (moneyController.text.isEmpty) {
      ToastUtil.showToast("请输入开票金额");
      return false;
    } else {
      indata.money = moneyController.text;
    }
    if (indata.invoiceDate == null) {
      indata.invoiceDate = DateFormat("yyyy-MM-dd HH:mm:ss")
          .parse(invoiceDateController.text)
          .toUtc()
          .toString();
    }
    return true;
  }
}
