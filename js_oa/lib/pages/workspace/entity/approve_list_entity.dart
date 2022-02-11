import 'package:js_oa/pages/workspace/entity/format_time.dart';

class ApproveListEntity {
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  List<ApproveItem>? items;
  bool? hasPrevPages;
  bool? hasNextPages;

  ApproveListEntity(
      {this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.items,
      this.hasPrevPages,
      this.hasNextPages});

  ApproveListEntity.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new ApproveItem.fromJson(v));
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

class ApproveItem {
  String? workflowId;
  String? title;
  ApproveContent? content;
  String? code;
  int? approveStatus;
  String? realName;
  String? createdTime;

  ApproveItem(
      {this.workflowId,
      this.title,
      this.content,
      this.code,
      this.approveStatus,
      this.realName,
      this.createdTime});

  ApproveItem.fromJson(Map<String, dynamic> json) {
    workflowId = json['workflowId'];
    title = json['title'];
    content = json['content'] != null
        ? new ApproveContent.fromJson(json['content'])
        : null;
    code = json['code'];
    approveStatus = json['approveStatus'];
    realName = json['realName'];
    createdTime = FormatTime.timeStr(json['createdTime']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['workflowId'] = this.workflowId;
    data['title'] = this.title;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    data['code'] = this.code;
    data['approveStatus'] = this.approveStatus;
    data['realName'] = this.realName;
    data['createdTime'] = this.createdTime;
    return data;
  }
}

class ApproveContent {
  String? clientName;
  String? contractNumber;
  double? money;
  String? paymentChannelName;
  String? paymentTime;
  String? invoiceDate;
  int? approveStatus;

  ApproveContent(
      {this.clientName,
      this.contractNumber,
      this.money,
      this.paymentChannelName,
      this.paymentTime,
      this.invoiceDate,
      this.approveStatus});

  ApproveContent.fromJson(Map<String, dynamic> json) {
    clientName = json['ClientName'];
    contractNumber = json['ContractNumber'];
    money = json['Money'];
    paymentChannelName = json['PaymentChannelName'];
    paymentTime = FormatTime.timeStr(json['PaymentTime']);
    invoiceDate = FormatTime.timeStr(json['InvoiceDate']);
    approveStatus = json['ApproveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientName'] = this.clientName;
    data['ContractNumber'] = this.contractNumber;
    data['Money'] = this.money;
    data['PaymentChannelName'] = this.paymentChannelName;
    data['PaymentTime'] = this.paymentTime;
    data['InvoiceDate'] = this.invoiceDate;
    data['ApproveStatus'] = this.approveStatus;
    return data;
  }
}
