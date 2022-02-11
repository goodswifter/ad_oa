import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/api/api.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_indata.dart';
import 'package:js_oa/pages/workspace/entity/contract_entity.dart';
import 'package:js_oa/pages/workspace/entity/invoice_history_list_entity.dart';
import 'package:js_oa/pages/workspace/entity/invoice_info_entity.dart';
import 'package:js_oa/pages/workspace/entity/invoice_list_entity.dart';
import 'package:js_oa/pages/workspace/entity/invoice_type_entity.dart';
import 'package:js_oa/pages/workspace/entity/payment_history_list_entity.dart';
import 'package:js_oa/pages/workspace/entity/payment_list_entity.dart';
import 'package:js_oa/pages/workspace/entity/payment_type_entity.dart';
import 'package:js_oa/pages/workspace/entity/workflow_detail_entity.dart';
import 'package:js_oa/pages/workspace/entity/workspace_layout_entity.dart';
import 'package:js_oa/utils/http/src/http_client.dart';
import 'package:js_oa/utils/http/src/http_exceptions.dart';
import 'package:js_oa/utils/http/src/http_response.dart';
import 'package:js_oa/pages/workspace/entity/approve_list_entity.dart';

typedef void Success<T>(T data);
typedef void Failure(HttpException data);

class WorkSpaceService {
  final HttpClient dio = Get.find();

  void getWorkSpaceGetMyLayout(
      {Success<List<WorkspaceLayoutEntity>>? success, Failure? failure}) async {
    HttpResponse appResponse = await dio.get(apiWorkSpaceGetMyLayout);
    if (appResponse.ok) {
      List<WorkspaceLayoutEntity> workLayout = [];
      for (var item in appResponse.data) {
        workLayout.add(WorkspaceLayoutEntity.fromJson(item));
      }
      success!(workLayout);
    } else {
      failure!(appResponse.error!);
    }
  }

  //http://192.168.52.56:18080/api/Contract/GetPagedList?PageIndex=1&PageSize=20
  //获取合同列表
  Future<ContractEntity> getOldContractGetPagedList({
    ContractListIndata? indata,
    Success<ContractEntity>? success,
    Failure? failure,
  }) async {
    Map<String, dynamic> paraments = {
      "PageIndex": indata!.pageIndex,
      "PageSize": indata.pageSize,
    };
    if (indata.clientName!.isNotEmpty) {
      paraments.addAll({"ClientName": indata.clientName});
    }
    if (indata.name!.isNotEmpty) {
      paraments.addAll({"Name": indata.name});
    }
    HttpResponse appResponse =
        await dio.get(apiOldContractGetPagedList, queryParameters: paraments);
    if (appResponse.ok) {
      ContractEntity data = ContractEntity.fromJson(appResponse.data);
      success!(data);
      return data;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

  //http://192.168.52.56:18080/api/Workflow/GetPagedList?Code=Created&PageIndex=1&PageSize=20
  //工作台审核、已处理、已提交接口
  Future<ApproveListEntity> getWorkflowtGetPagedList({
    WorkSpaceApproveIndata? query,
    Success? success,
    Failure? failure,
  }) async {
    Map<String, dynamic> paraments = {
      "Tag": query!.tag,
      "PageIndex": query.pageIndex,
      "PageSize": query.pageSize,
    };
    //Code所属流程编码
    if (query.code!.isNotEmpty) {
      paraments.addAll({"Code": query.code});
    }
    if (query.approveStatus!.isNotEmpty) {
      paraments.addAll({"ApproveStatus": query.approveStatus});
    }
    if (query.realName!.isNotEmpty) {
      paraments.addAll({"RealName": query.realName});
    }

    HttpResponse appResponse =
        await dio.get(apiWorkflowGetPagedList, queryParameters: paraments);
    if (appResponse.ok) {
      ApproveListEntity dd = ApproveListEntity.fromJson(appResponse.data);
      success!(dd);
      return dd;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

  //http://192.168.52.56:18080/api/Workflow/GetById/08d98093-a251-44b6-8640-0bb9d489f325
  //获取工作流详情
  Future<WorkflowDetailEntity> getWorkflowGetById(
    String workFlowId, {
    Success<WorkflowDetailEntity>? success,
    Failure? failure,
  }) async {
    HttpResponse appResponse =
        await dio.get(apiWorkflowGetById + "/" + workFlowId);
    if (appResponse.ok) {
      WorkflowDetailEntity detail =
          WorkflowDetailEntity.fromJson(appResponse.data);
      success!(detail);
      return detail;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

//'http://192.168.52.56:18080/api/Invoice/GetPagedList?PageIndex=1&PageSize=20
//获取开票记录
  Future<InvoiceListEntity> getInvoiceGetPagedList({
    InvoiceListIndata? query,
    Success<InvoiceListEntity>? success,
    Failure? failure,
  }) async {
    Map<String, dynamic> paraments = {
      "PageIndex": query!.pageIndex,
      "PageSize": query.pageSize,
    };
    if (query.clientName!.isNotEmpty) {
      paraments.addAll({"ClientName": query.clientName});
    }
    HttpResponse appResponse =
        await dio.get(apiInvoiceGetPagedList, queryParameters: paraments);
    if (appResponse.ok) {
      InvoiceListEntity detail = InvoiceListEntity.fromJson(appResponse.data);
      success!(detail);
      return detail;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

  //http://192.168.52.56:18080/api/Payment/GetPagedList?PageIndex=1&PageSize=20
  //获取缴费记录
  Future<PaymentListEntity> getPaymentGetPagedList({
    PaymentListIndata? query,
    Success<PaymentListEntity>? success,
    Failure? failure,
  }) async {
    Map<String, dynamic> paraments = {
      "PageIndex": query!.pageIndex,
      "PageSize": query.pageSize,
    };
    if (query.clientName!.isNotEmpty) {
      paraments.addAll({"ClientName": query.clientName});
    }
    HttpResponse appResponse =
        await dio.get(apiPaymentGetPagedList, queryParameters: paraments);
    if (appResponse.ok) {
      PaymentListEntity detail = PaymentListEntity.fromJson(appResponse.data);
      success!(detail);
      return detail;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

  //http://192.168.52.56:18080/api/Workflow/ApproveWork
  //审核工作流
  Future<bool> postWorkflowApproveWork({
    String? executionPointerId,
    bool? pass,
    String? remarks,
    Success<bool>? success,
    Failure? failure,
  }) async {
    Map<String, dynamic> indata = {
      "executionPointerId": executionPointerId,
      "pass": pass,
      "remarks": remarks
    };
    HttpResponse appResponse =
        await dio.post(apiWorkflowApproveWork, data: indata);
    if (appResponse.ok) {
      success!(true);
      return true;
    } else {
      debugPrint("====" + appResponse.error.toString());
      failure!(appResponse.error!);
      return Future.error(appResponse.error!);
    }
  }

  //'http://192.168.52.56:18080/api/Workflow/GetWorkflowDefinition/payment'
  //获取工作流模板
  Future<WorkflowInfo> getWorkflowGetWorkflowDefinition({
    String? code,
    Success<WorkflowInfo>? success,
    Failure? failure,
  }) async {
    HttpResponse appResponse = await dio.get(
        apiWorkflowGetWorkflowDefinition + "/" + code!,
        isShowEasyLoading: false);
    if (appResponse.ok) {
      WorkflowInfo flowInfo = WorkflowInfo.fromJson(appResponse.data);
      success!(flowInfo);
      return flowInfo;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

  //'http://192.168.52.56:18080/api/Invoice/Create'
  //创建开票
  Future<String> posInvoiceCreate({
    CreateInvoiceIndata? query,
    Success<String>? success,
    Failure? failure,
  }) async {
    Map<String, dynamic> indata = {
      "id": query!.id,
      "clientId": query.clientId,
      "contractId": query.contractId,
      "money": query.money,
      "invoiceDate": query.invoiceDate,
      "remarks": query.remarks ?? "",
      "invoiceTypeId": query.invoiceTypeId,
      "code": query.code,
    };
    HttpResponse appResponse = await dio.post(apiInvoiceCreate, data: indata);
    if (appResponse.ok) {
      success!(appResponse.data["workflowId"]);
      return appResponse.data["workflowId"];
    } else {
      debugPrint("====" + appResponse.error.toString());
      failure!(appResponse.error!);
      return Future.error(appResponse.error!);
    }
  }

  //http://192.168.52.56:18080/api/Payment/Create
  //创建缴费
  Future<String> postPaymentCreate({
    CreatePaymentIndata? query,
    Success<String>? success,
    Failure? failure,
  }) async {
    Map<String, dynamic> indata = {
      "id": query!.id,
      "isInput": query.isInput,
      "clientId": query.clientId,
      "contractId": query.contractId,
      "money": query.money,
      "paymentChannelId": query.paymentChannelId,
      "userId": query.userId,
      "agent": query.agent,
      "paymentTime": query.paymentTime,
      "attachment": query.attachment,
      "remarks": query.remarks ?? "",
      "code": query.code,
    };
    HttpResponse appResponse = await dio.post(apiPaymentCreate, data: indata);
    if (appResponse.ok) {
      success!(appResponse.data["workflowId"]);
      return appResponse.data["workflowId"];
    } else {
      debugPrint("====" + appResponse.error.toString());
      failure!(appResponse.error!);
      return Future.error(appResponse.error!);
    }
  }

  //'http://192.168.52.56:18080/api/PaymentChannel/GetList'
  //获取缴费方式
  Future<List<PaymentTypeEntity>> getPaymentChannelGetList({
    Success<List<PaymentTypeEntity>>? success,
    Failure? failure,
  }) async {
    HttpResponse appResponse =
        await dio.get(apiPaymentChannelGetList, isShowEasyLoading: false);
    if (appResponse.ok) {
      List<PaymentTypeEntity> paymentType = [];
      for (var item in appResponse.data) {
        paymentType.add(PaymentTypeEntity.fromJson(item));
      }
      success!(paymentType);
      return paymentType;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

//'http://192.168.52.56:18080/api/Contract/GetContractIntro/2'
//获取合同简介
  Future<ContractItem> getOldContractGetContractIntro({
    int? contractId,
    Success<ContractItem>? success,
    Failure? failure,
  }) async {
    HttpResponse appResponse = await dio.get(
        apiOldContractGetContractIntro + "/" + contractId.toString(),
        isShowEasyLoading: false);
    if (appResponse.ok) {
      ContractItem item = ContractItem.fromJson(appResponse.data);
      success!(item);
      return item;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

  //'http://192.168.52.56:18080/api/Payment/GetPagedListForContract?ContractId=2&PageIndex=1&PageSize=33'
  //获取合同的缴费历史
  Future<PaymentHistoryListEntity> getPaymentGetPagedListForContract({
    int? contractId,
    int? pageIndex,
    Success<PaymentHistoryListEntity>? success,
    Failure? failure,
  }) async {
    Map<String, dynamic> paraments = {
      "ContractId": contractId,
      "PageIndex": pageIndex,
      "PageSize": 20,
    };
    HttpResponse appResponse = await dio.get(apiPaymentGetPagedListForContract,
        queryParameters: paraments);
    if (appResponse.ok) {
      PaymentHistoryListEntity historys =
          PaymentHistoryListEntity.fromJson(appResponse.data);
      success!(historys);
      return historys;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

  //'http://192.168.52.56:18080/api/Invoice/GetPagedListForContract?ContractId=2&PageIndex=1&PageSize=33'
  //获取合同的开票历史
  Future<InvoiceHistoryListEntity> getInvoiceGetPagedListForContract({
    int? contractId,
    int? pageIndex,
    Success<InvoiceHistoryListEntity>? success,
    Failure? failure,
  }) async {
    Map<String, dynamic> paraments = {
      "ContractId": contractId,
      "PageIndex": pageIndex,
      "PageSize": 20,
    };
    HttpResponse appResponse = await dio.get(apiInvoiceGetPagedListForContract,
        queryParameters: paraments);
    if (appResponse.ok) {
      InvoiceHistoryListEntity historys =
          InvoiceHistoryListEntity.fromJson(appResponse.data);
      success!(historys);
      return historys;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

  //'http://192.168.52.56:18080/api/Client/GetInvoiceById/3'
  //http://192.168.52.56:18080/api/Client/GetOldClientById/1
  //获取用户发票信息
  Future<InvoiceInfoEntity> getClientGetOldClientById({
    int? id,
    Success<InvoiceInfoEntity>? success,
    Failure? failure,
  }) async {
    HttpResponse appResponse = await dio.get(
        apiClientGetOldClientById + "/" + id.toString(),
        isShowEasyLoading: false);
    if (appResponse.ok) {
      InvoiceInfoEntity item = InvoiceInfoEntity.fromJson(appResponse.data);
      success!(item);
      return item;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

  //'http://192.168.52.56:18080/api/InvoiceType/GetList'
  //获取发票类型
  Future<List<InvoiceTypeEntity>> getInvoiceTypeGetList({
    Success<List<InvoiceTypeEntity>>? success,
    Failure? failure,
  }) async {
    HttpResponse appResponse =
        await dio.get(apiInvoiceTypeGetList, isShowEasyLoading: false);
    if (appResponse.ok) {
      List<InvoiceTypeEntity> types = [];
      for (var item in appResponse.data) {
        types.add(InvoiceTypeEntity.fromJson(item));
      }
      success!(types);
      return types;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

  //'http://192.168.52.56:18080/api/Workflow/RevokeWork/1'
  //撤销工作流
  Future<bool> postWorkflowRevokeWork({
    String? id,
    Success<bool>? success,
    Failure? failure,
  }) async {
    HttpResponse appResponse = await dio.post(apiWorkflowRevokeWork + "/" + id!,
        isShowEasyLoading: false);
    if (appResponse.ok) {
      success!(true);
      return true;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }

  //http://api.oa.dev.jingshonline.net/api/NonBusinessContract/Create
  //新增非业务合同备案
  Future<bool> postNonBusinessContractCreate({
    CreateNonBusinessContractIndata? nonBusines,
    Success<bool>? success,
    Failure? failure,
  }) async {
    HttpResponse appResponse = await dio.post(
      apiNonBusinessContractCreate,
      data: nonBusines,
    );
    if (appResponse.ok) {
      success!(true);
      return true;
    } else {
      debugPrint("====" + appResponse.error.toString());
      return Future.error(appResponse.error!);
    }
  }
}
