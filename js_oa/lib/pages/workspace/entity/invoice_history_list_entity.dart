import 'package:js_oa/pages/workspace/entity/format_time.dart';

class InvoiceHistoryListEntity {
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  List<InvoiceHistoryItems>? items;
  bool? hasPrevPages;
  bool? hasNextPages;

  InvoiceHistoryListEntity(
      {this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.items,
      this.hasPrevPages,
      this.hasNextPages});

  InvoiceHistoryListEntity.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new InvoiceHistoryItems.fromJson(v));
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

class InvoiceHistoryItems {
  int? id;
  int? clientId;
  int? contractId;
  double? money;
  String? invoiceDate;
  String? remarks;
  int? invoiceTypeId;
  String? invoiceTypeName;
  String? contractName;
  String? contractNumber;
  String? clientName;
  int? approveStatus;

  InvoiceHistoryItems(
      {this.id,
      this.clientId,
      this.contractId,
      this.money,
      this.invoiceDate,
      this.remarks,
      this.invoiceTypeId,
      this.invoiceTypeName,
      this.contractName,
      this.contractNumber,
      this.clientName,
      this.approveStatus});

  InvoiceHistoryItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['clientId'];
    contractId = json['contractId'];
    money = json['money'];
    invoiceDate = FormatTime.timeStr(json['invoiceDate']);
    remarks = json['remarks'];
    invoiceTypeId = json['invoiceTypeId'];
    invoiceTypeName = json['invoiceTypeName'];
    contractName = json['contractName'];
    contractNumber = json['contractNumber'];
    clientName = json['clientName'];
    approveStatus = json['approveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['clientId'] = this.clientId;
    data['contractId'] = this.contractId;
    data['money'] = this.money;
    data['invoiceDate'] = this.invoiceDate;
    data['remarks'] = this.remarks;
    data['invoiceTypeId'] = this.invoiceTypeId;
    data['invoiceTypeName'] = this.invoiceTypeName;
    data['contractName'] = this.contractName;
    data['contractNumber'] = this.contractNumber;
    data['clientName'] = this.clientName;
    data['approveStatus'] = this.approveStatus;
    return data;
  }
}
