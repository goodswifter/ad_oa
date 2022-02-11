class InvoiceInfoEntity {
  String? id;
  String? name;
  String? bank;
  String? bankAccount;
  String? address;
  String? tel;

  InvoiceInfoEntity(
      {this.id,
      this.name,
      this.bank,
      this.bankAccount,
      this.address,
      this.tel});

  InvoiceInfoEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bank = json['bank'];
    bankAccount = json['bankAccount'];
    address = json['address'];
    tel = json['tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['bank'] = this.bank;
    data['bankAccount'] = this.bankAccount;
    data['address'] = this.address;
    data['tel'] = this.tel;
    return data;
  }
}
