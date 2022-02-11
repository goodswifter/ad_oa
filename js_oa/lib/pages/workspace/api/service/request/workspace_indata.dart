class WorkSpaceApproveIndata {
  String? tag;
  String? code;
  String? approveStatus;
  String? realName;
  int pageIndex;
  int pageSize;

  WorkSpaceApproveIndata({
    this.tag,
    this.code = "",
    this.approveStatus = "",
    this.realName = "",
    this.pageSize = 20,
    this.pageIndex = 1,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = Map();
    map['pageIndex'] = this.pageIndex;
    map['pageCount'] = this.pageSize;
    map['tag'] = this.tag;
    map['code'] = this.code;
    map['approveStatus'] = this.approveStatus;
    map['realName'] = this.realName;
    return map;
  }
}

class ContractListIndata {
  String? clientName;
  String? name;
  int pageIndex;
  int pageSize;

  ContractListIndata({
    this.clientName = "",
    this.name = "",
    this.pageSize = 20,
    this.pageIndex = 1,
  });
}

class InvoiceListIndata {
  double? minMoney;
  double? maxMoney;
  String? beginInvoiceDate;
  String? endInvoiceDate;
  String? clientName;
  int? invoiceTypeId;
  String? userName;
  int? contractId;
  int? userId;
  int pageIndex;
  int pageSize;

  InvoiceListIndata({
    this.clientName = "",
    this.pageSize = 20,
    this.pageIndex = 1,
  });
}

class PaymentListIndata {
  int? contractId;
  int? userId;
  String? clientName;
  double? minMoney;
  double? maxMoney;
  String? beginPaymentDate;
  String? endPaymentDate;
  int pageIndex;
  int pageSize;

  PaymentListIndata({
    this.clientName = "",
    this.pageSize = 20,
    this.pageIndex = 1,
  });
}

class CreateInvoiceIndata {
  int? id;
  int? clientId;
  String? contractId;
  String? money;
  String? invoiceDate;
  String? remarks;
  int? invoiceTypeId;
  String? code;

  CreateInvoiceIndata({
    this.id = 0,
    this.clientId,
    this.contractId,
    this.money,
    this.remarks,
    this.invoiceDate,
    this.invoiceTypeId,
    this.code = "Invoice",
  });
}

class CreatePaymentIndata {
  int? id;
  bool? isInput;
  String? money;
  String? contractId;
  int? clientId;
  int? paymentChannelId;
  int? userId;
  String? agent;
  String? paymentTime;
  String? attachment;
  String? remarks;
  String? code;

  CreatePaymentIndata({
    this.id = 0,
    this.isInput = true,
    this.money,
    this.clientId,
    this.contractId,
    this.paymentChannelId,
    this.userId,
    this.agent,
    this.paymentTime,
    this.attachment,
    this.remarks,
    this.code = "Payment",
  });
}

class CreateNonBusinessContractIndata {
  String? purpose;
  String? receiver;
  List<NonBusinessContractImages>? files;

  CreateNonBusinessContractIndata({this.purpose, this.receiver, this.files});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purpose'] = this.purpose;
    data['receiver'] = this.receiver;
    if (this.files != null) {
      data['files'] = this.files!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NonBusinessContractImages {
  // int? id;
  String? url;
  String? path;
  String? name;

  NonBusinessContractImages({this.url, this.path, this.name});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['url'] = this.url;
    data['path'] = this.path;
    data['name'] = this.name;
    return data;
  }
}
