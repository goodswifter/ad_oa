import 'package:js_oa/pages/workspace/entity/format_time.dart';

class WorkflowDetailEntity {
  String? workflowId;
  String? title;
  String? code;
  String? subTitle;
  String? currentStepInfo;
  List<GroupInfos>? groupInfos;
  WorkflowInfo? workflowInfo;
  int? approveStatus;
  int? contractId;
  int? creatorUserId;
  String? createdTime;

  WorkflowDetailEntity(
      {this.workflowId,
      this.title,
      this.code,
      this.subTitle,
      this.currentStepInfo,
      this.groupInfos,
      this.workflowInfo,
      this.approveStatus,
      this.contractId,
      this.createdTime,
      this.creatorUserId});

  WorkflowDetailEntity.fromJson(Map<String, dynamic> json) {
    workflowId = json['workflowId'];
    title = json['title'];
    code = json['code'];
    subTitle = json['subTitle'];
    currentStepInfo = json['currentStepInfo'];
    approveStatus = json['approveStatus'];
    contractId = json['contractId'];
    if (json['groupInfos'] != null) {
      groupInfos = [];
      json['groupInfos'].forEach((v) {
        groupInfos!.add(new GroupInfos.fromJson(v));
      });
    }
    workflowInfo = json['workflowInfo'] != null
        ? new WorkflowInfo.fromJson(json['workflowInfo'])
        : null;
    creatorUserId = json['creatorUserId'];
    createdTime = json['createdTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['code'] = this.code;
    data['subTitle'] = this.subTitle;
    data['currentStepInfo'] = this.currentStepInfo;
    data['creatorUserId'] = this.creatorUserId;
    data['createdTime'] = this.createdTime;
    if (this.groupInfos != null) {
      data['groupInfos'] = this.groupInfos!.map((v) => v.toJson()).toList();
    }
    if (this.workflowInfo != null) {
      data['workflowInfo'] = this.workflowInfo!.toJson();
    }
    return data;
  }
}

class GroupInfos {
  String? name;
  WorkFlowDetailContent? content;

  GroupInfos({this.name, this.content});

  GroupInfos.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    content = json['content'] != null
        ? new WorkFlowDetailContent.fromJson(json['content'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class WorkFlowDetailContent {
  //缴费信息
  String? clientName;
  double? money;
  String? paymentChannelName;
  String? paymentTime;
  String? remarks;
  //情况说明
  String? attachment;
  //案件概要
  String? contractSource;
  String? contractType;
  String? contractNumber;
  String? client;
  String? privies;
  String? thirdParty;
  String? lawyerName;
  //发票信息
  String? invoiceTypeName;
  String? invoiceDate;
  String? bank;
  String? bankAccount;
  String? address;
  String? tel;

  WorkFlowDetailContent({
    this.clientName,
    this.money,
    this.paymentChannelName,
    this.paymentTime,
    this.remarks,
    this.attachment,
    this.contractSource,
    this.contractType,
    this.contractNumber,
    this.client,
    this.privies,
    this.thirdParty,
    this.lawyerName,
    this.invoiceTypeName,
    this.invoiceDate,
    this.bank,
    this.address,
    this.tel,
  });

  WorkFlowDetailContent.fromJson(Map<String, dynamic> json) {
    clientName = json['ClientName'];
    money = json['Money'];
    paymentChannelName = json['PaymentChannelName'];
    paymentTime = FormatTime.timeStr(json['PaymentTime']);
    remarks = json['Remarks'];

    attachment = json['Attachment'];

    contractSource = json['ContractSource'];
    contractType = json['ContractTyper'];
    contractNumber = json['ContractNumber'];
    client = json['Client'];
    privies = json['Privies'];
    thirdParty = json['ThirdParty'];
    lawyerName = json['LawyerName'];

    invoiceTypeName = json['InvoiceTypeName'];
    invoiceDate = FormatTime.timeStr(json['InvoiceDate']);
    bank = json['bank'];
    bankAccount = json['bankAccount'];
    address = json['address'];
    tel = json['tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ClientName'] = clientName;
    // data['Money'] = money;
    // data['PaymentChannelName'] = paymentChannelName;
    // data['PaymentTime'] = paymentTime;
    // data['InvoicingDate'] = invoicingDate;
    // data['Remarks'] = remarks;
    // data['Attachment'] = attachment;
    // data['ContractNumber'] = contractNumber;
    // data['Client'] = client;
    // data['Privies'] = privies;
    // data['ThirdParty'] = thirdParty;
    // data['LawyerName'] = lawyerName;
    return data;
  }
}

class WorkflowInfo {
  bool? canHandle;
  String? handleExecutionPointerId;
  String? id;
  List<WorkflowSteps>? workflowSteps;

  WorkflowInfo(
      {this.canHandle,
      this.handleExecutionPointerId,
      this.workflowSteps,
      this.id});

  WorkflowInfo.fromJson(Map<String, dynamic> json) {
    canHandle = json['canHandle'];
    handleExecutionPointerId = json['handleExecutionPointerId'];
    id = json['id'];
    if (json['steps'] != null) {
      workflowSteps = [];
      json['steps'].forEach((v) {
        workflowSteps!.add(new WorkflowSteps.fromJson(v));
      });
    }
    if (json['workflowSteps'] != null) {
      workflowSteps = [];
      json['workflowSteps'].forEach((v) {
        workflowSteps!.add(new WorkflowSteps.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canHandle'] = this.canHandle;
    data['handleExecutionPointerId'] = this.handleExecutionPointerId;
    if (this.workflowSteps != null) {
      data['workflowSteps'] =
          this.workflowSteps!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkflowSteps {
  String? stepName;
  String? title;
  List<ApproveUsers>? users;
  int? auditStatus;

  WorkflowSteps({this.stepName, this.title, this.users, this.auditStatus});

  WorkflowSteps.fromJson(Map<String, dynamic> json) {
    stepName = json['stepName'];
    title = json['title'];
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((v) {
        users!.add(new ApproveUsers.fromJson(v));
      });
    }
    if (json['auditStatus'] == null) {
      auditStatus = 6;
    } else {
      auditStatus = json['auditStatus'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stepName'] = this.stepName;
    data['title'] = this.title;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['auditStatus'] = this.auditStatus;
    return data;
  }
}

class ApproveUsers {
  int? id;
  String? realName;
  String? avatar;
  bool? isApproved;

  ApproveUsers({this.id, this.realName, this.avatar, this.isApproved});

  ApproveUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    realName = json['realName'];
    avatar = json['avatar'];
    isApproved = json['isApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['realName'] = this.realName;
    data['avatar'] = this.avatar;
    data['isApproved'] = this.isApproved;
    return data;
  }
}
