class ContractEntity {
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  List<ContractItem>? items;
  bool? hasPrevPages;
  bool? hasNextPages;

  ContractEntity(
      {this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.items,
      this.hasPrevPages,
      this.hasNextPages});

  ContractEntity.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new ContractItem.fromJson(v));
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

class ContractItem {
  int? id;
  String? name;
  String? contractNumber;
  int? userId;
  String? realName;
  int? contractTypeId;
  String? contractTypeName;
  int? clientSourceId;
  String? clientSourceName;
  List<ClientLists>? clients;
  List<ClientLists>? privies;
  List<ClientLists>? thirdParties;

  ContractItem(
      {this.id,
      this.name,
      this.contractNumber,
      this.userId,
      this.realName,
      this.contractTypeId,
      this.contractTypeName,
      this.clientSourceId,
      this.clientSourceName,
      this.clients,
      this.privies,
      this.thirdParties});

  ContractItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contractNumber = json['contractNumber'];
    userId = json['userId'];
    realName = json['realName'];
    contractTypeId = json['contractTypeId'];
    contractTypeName = json['contractTypeName'];
    clientSourceId = json['clientSourceId'];
    clientSourceName = json['clientSourceName'];
    if (json['clients'] != null) {
      clients = [];
      json['clients'].forEach((v) {
        clients!.add(new ClientLists.fromJson(v));
      });
    }
    if (json['privies'] != null) {
      privies = [];
      json['privies'].forEach((v) {
        privies!.add(new ClientLists.fromJson(v));
      });
    }
    if (json['thirdParties'] != null) {
      thirdParties = [];
      json['thirdParties'].forEach((v) {
        thirdParties!.add(new ClientLists.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['contractNumber'] = this.contractNumber;
    data['userId'] = this.userId;
    data['realName'] = this.realName;
    data['contractTypeId'] = this.contractTypeId;
    data['contractTypeName'] = this.contractTypeName;
    data['clientSourceId'] = this.clientSourceId;
    data['clientSourceName'] = this.clientSourceName;
    if (this.clients != null) {
      data['clients'] = this.clients!.map((v) => v.toJson()).toList();
    }
    if (this.privies != null) {
      data['privies'] = this.privies!.map((v) => v.toJson()).toList();
    }
    if (this.thirdParties != null) {
      data['thirdParties'] = this.thirdParties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ClientLists {
  int? id;
  String? name;
  bool? isSelected;

  ClientLists({this.id, this.name, this.isSelected = false});

  ClientLists.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
