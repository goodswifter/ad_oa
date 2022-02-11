import 'package:js_oa/pages/workspace/entity/format_time.dart';

class PaymentHistoryListEntity {
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  List<PaymentHistoryItems>? items;
  bool? hasPrevPages;
  bool? hasNextPages;

  PaymentHistoryListEntity(
      {this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.items,
      this.hasPrevPages,
      this.hasNextPages});

  PaymentHistoryListEntity.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new PaymentHistoryItems.fromJson(v));
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

class PaymentHistoryItems {
  int? id;
  bool? isInput;
  double? money;
  int? contractId;
  int? clientId;
  int? paymentChannelId;
  int? userId;
  String? agent;
  String? paymentTime;
  String? attachment;
  String? remarks;
  String? paymentChannelName;
  String? clientName;
  String? contractNumber;
  int? approveStatus;

  PaymentHistoryItems({
    this.id,
    this.isInput,
    this.money,
    this.contractId,
    this.clientId,
    this.paymentChannelId,
    this.userId,
    this.agent,
    this.paymentTime,
    this.attachment,
    this.remarks,
    this.paymentChannelName,
    this.clientName,
    this.contractNumber,
    this.approveStatus,
  });

  PaymentHistoryItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isInput = json['isInput'];
    money = json['money'];
    contractId = json['contractId'];
    clientId = json['clientId'];
    paymentChannelId = json['paymentChannelId'];
    userId = json['userId'];
    agent = json['agent'];
    paymentTime = FormatTime.timeStr(json['paymentTime']);
    attachment = json['attachment'];
    remarks = json['remarks'];
    paymentChannelName = json['paymentChannelName'];
    clientName = json['clientName'];
    contractNumber = json['contractNumber'];
    approveStatus = json['approveStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isInput'] = this.isInput;
    data['money'] = this.money;
    data['contractId'] = this.contractId;
    data['clientId'] = this.clientId;
    data['paymentChannelId'] = this.paymentChannelId;
    data['userId'] = this.userId;
    data['agent'] = this.agent;
    data['paymentTime'] = this.paymentTime;
    data['attachment'] = this.attachment;
    data['remarks'] = this.remarks;
    data['paymentChannelName'] = this.paymentChannelName;
    data['clientName'] = this.clientName;
    data['contractNumber'] = this.contractNumber;
    data['approveStatus'] = this.approveStatus;
    return data;
  }
}
