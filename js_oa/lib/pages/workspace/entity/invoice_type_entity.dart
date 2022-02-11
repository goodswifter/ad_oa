class InvoiceTypeEntity {
  int? id;
  String? name;
  int? orderId;

  InvoiceTypeEntity({this.id, this.name, this.orderId});

  InvoiceTypeEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['orderId'] = this.orderId;
    return data;
  }
}
