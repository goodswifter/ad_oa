class WorkspaceLayoutEntity {
  String? groupName;
  int? orderId;
  List<WorkspaceLayoutItem>? items;

  WorkspaceLayoutEntity({this.groupName, this.orderId, this.items});

  WorkspaceLayoutEntity.fromJson(Map<String, dynamic> json) {
    groupName = json['groupName'];
    orderId = json['orderId'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items?.add(new WorkspaceLayoutItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['groupName'] = this.groupName;
    data['orderId'] = this.orderId;
    if (this.items != null) {
      data['items'] = this.items?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkspaceLayoutItem {
  String? name;
  String? icon;
  String? route;
  String? workflowCode;
  int? orderId;

  WorkspaceLayoutItem({this.name, this.icon, this.route, this.orderId});

  WorkspaceLayoutItem.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    route = json['route'];
    workflowCode = json['workflowCode'];
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['route'] = this.route;
    data['workflowCode'] = this.workflowCode;
    data['orderId'] = this.orderId;
    return data;
  }
}
