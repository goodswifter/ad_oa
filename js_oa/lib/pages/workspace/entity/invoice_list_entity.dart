import 'package:js_oa/pages/workspace/entity/format_time.dart';

class InvoiceListEntity {
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  List<InvoiceItems>? items;
  bool? hasPrevPages;
  bool? hasNextPages;

  InvoiceListEntity(
      {this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.items,
      this.hasPrevPages,
      this.hasNextPages});

  InvoiceListEntity.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new InvoiceItems.fromJson(v));
      });
    }
    hasPrevPages = json['hasPrevPages'];
    hasNextPages = json['hasNextPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pageIndex'] = this.pageIndex;
    data['pageSize'] = this.pageSize;
    data['totalCount'] = this.totalCount;
    data['totalPages'] = this.totalPages;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['hasPrevPages'] = this.hasPrevPages;
    data['hasNextPages'] = this.hasNextPages;
    return data;
  }
}

class InvoiceItems {
  int? invoiceTypeId;
  String? invoiceTypeName;
  int? contractId;
  String? contractName;
  int? clientId;
  String? clientName;
  double? money;
  String? invoiceDate;
  String? contractNumber;
  int? approveStatus;
  String? workflowId;

  InvoiceItems(
      {this.invoiceTypeId,
      this.invoiceTypeName,
      this.contractId,
      this.contractName,
      this.clientId,
      this.clientName,
      this.money,
      this.invoiceDate,
      this.contractNumber,
      this.approveStatus,
      this.workflowId});

  InvoiceItems.fromJson(Map<String, dynamic> json) {
    invoiceTypeId = json['invoiceTypeId'];
    invoiceTypeName = json['invoiceTypeName'];
    contractId = json['contractId'];
    contractName = json['contractName'];
    clientId = json['clientId'];
    clientName = json['clientName'];
    money = json['money'];
    invoiceDate = FormatTime.timeStr(json['invoiceDate']);
    contractNumber = json['contractNumber'];
    approveStatus = json['approveStatus'];
    workflowId = json['workflowId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoiceTypeId'] = this.invoiceTypeId;
    data['invoiceTypeName'] = this.invoiceTypeName;
    data['contractId'] = this.contractId;
    data['contractName'] = this.contractName;
    data['clientId'] = this.clientId;
    data['clientName'] = this.clientName;
    data['money'] = this.money;
    data['invoiceDate'] = this.invoiceDate;
    return data;
  }
}
