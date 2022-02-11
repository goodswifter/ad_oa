// To parse this JSON data, do
//
//     final uploadResultEntity = uploadResultEntityFromJson(jsonString);

import 'dart:convert';

UserEntity uploadResultEntityFromJson(String str) =>
    UserEntity.fromJson(json.decode(str));

String uploadResultEntityToJson(UserEntity data) => json.encode(data.toJson());

class UserEntity {
  UserEntity({
    this.id,
    this.userName,
    this.realName,
    this.avatar,
    this.phoneNumber,
    this.email,
    this.licenseNumber,
    this.organizationUnitId,
    this.organizationUnitName,
    this.organizationUnitFullName,
    this.organName = '',
    this.sex = false,
    this.lawfirmId,
    this.lawfirmName,
    this.lawfirmFullName,
  });

  int? id;
  String? userName;
  String? realName;
  String? avatar;
  String? phoneNumber;
  String? email;
  String? licenseNumber;
  String? organizationUnitId;

  /// organizationUnitFullName的最后一个字段: 律师
  String? organizationUnitName;

  /// 京师律师事务所-北京-业务部门-律师
  String? organizationUnitFullName;

  /// organizationUnitFullName的前两个字段
  /// 京师律师事务所-北京
  String organName;
  bool sex;
  int? lawfirmId;
  String? lawfirmName;
  String? lawfirmFullName;

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    // 截取事务所名称
    //  -> 京师律师事务所-北京
    String? orgFullName = json["organizationUnitFullName"];
    String organName = '';
    List<String> orgNames = [];
    if (orgFullName != null) orgNames = orgFullName.split('-');
    if (orgNames.length > 1) organName = orgNames[0] + '-' + orgNames[1];
    return UserEntity(
      id: json["id"],
      userName: json["userName"],
      realName: json["realName"],
      avatar: json["avatar"],
      phoneNumber: json["phoneNumber"],
      email: json["email"],
      licenseNumber: json["licenseNumber"],
      organizationUnitId: json["organizationUnitId"],
      organizationUnitName: json["organizationUnitName"],
      organizationUnitFullName: json["organizationUnitFullName"],
      organName: organName,
      sex: json["sex"],
      lawfirmId: json["lawfirmId"],
      lawfirmName: json["lawfirmName"],
      lawfirmFullName: json["lawfirmFullName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "realName": realName,
        "avatar": avatar,
        "phoneNumber": phoneNumber,
        "email": email,
        "licenseNumber": licenseNumber,
        "organizationUnitId": organizationUnitId,
        "organizationUnitName": organizationUnitName,
        "organizationUnitFullName": organizationUnitFullName,
        "sex": sex,
        "lawfirmId": lawfirmId,
        "lawfirmName": lawfirmName,
        "lawfirmFullName": lawfirmFullName,
      };
}
