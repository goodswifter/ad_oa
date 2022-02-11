import 'package:js_oa/pages/workspace/entity/format_time.dart';

class PaymentListEntity {
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  List<PaymentItems>? items;
  bool? hasPrevPages;
  bool? hasNextPages;

  PaymentListEntity(
      {this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.items,
      this.hasPrevPages,
      this.hasNextPages});

  PaymentListEntity.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new PaymentItems.fromJson(v));
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

class PaymentItems {
  int? id;
  bool? isInput;
  double? money;
  int? contractId;
  int? clientId;
  int? paymentChannelId;
  String? agent;
  String? paymentTime;
  String? attachment;
  String? remarks;
  String? paymentChannelName;
  int? userId;
  String? userName;
  String? contractNumber;
  String? clientName;
  String? realName;
  int? approveStatus;
  String? workflowId;

  PaymentItems(
      {this.id,
      this.isInput,
      this.money,
      this.contractId,
      this.clientId,
      this.paymentChannelId,
      this.agent,
      this.paymentTime,
      this.attachment,
      this.remarks,
      this.paymentChannelName,
      this.userId,
      this.userName,
      this.contractNumber,
      this.clientName,
      this.realName,
      this.approveStatus,
      this.workflowId});

  PaymentItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isInput = json['isInput'];
    money = json['money'];
    contractId = json['contractId'];
    clientId = json['clientId'];
    paymentChannelId = json['paymentChannelId'];
    agent = json['agent'];
    paymentTime = FormatTime.timeStr(json['paymentTime']);
    attachment = json['attachment'];
    remarks = json['remarks'];
    paymentChannelName = json['paymentChannelName'];
    userId = json['userId'];
    userName = json['userName'];
    contractNumber = json['contractNumber'];
    clientName = json['clientName'];
    realName = json['realName'];
    approveStatus = json['approveStatus'];
    workflowId = json['workflowId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isInput'] = this.isInput;
    data['money'] = this.money;
    data['contractId'] = this.contractId;
    data['clientId'] = this.clientId;
    data['paymentChannelId'] = this.paymentChannelId;
    data['agent'] = this.agent;
    data['paymentTime'] = this.paymentTime;
    data['attachment'] = this.attachment;
    data['remarks'] = this.remarks;
    data['paymentChannelName'] = this.paymentChannelName;
    data['userId'] = this.userId;
    data['userName'] = this.userName;
    data['contractNumber'] = this.contractNumber;
    data['clientName'] = this.clientName;
    return data;
  }
}
