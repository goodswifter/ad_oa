/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-18 18:06:18
 * @Description: 联系人详情
 * @FilePath: \js_oa\lib\entity\contact\contact_detail_entity.dart
 * @LastEditTime: 2021-11-23 10:40:39
 */
class ContactDetailEntity {
  int? id;
  String? userName;
  String? realName;
  String? avatar;
  bool? sex;
  String? phoneNumber;
  String? email;
  String? positionName;
  String? organizationUnitName;
  String? organizationUnitFullName;

  ContactDetailEntity(
      {this.id,
      this.userName,
      this.realName,
      this.avatar,
      this.sex,
      this.phoneNumber,
      this.email,
      this.positionName,
      this.organizationUnitName,
      this.organizationUnitFullName});

  ContactDetailEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    realName = json['realName'];
    avatar = json['avatar'];
    sex = json['sex'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    positionName = json['positionName'];
    organizationUnitName = json['organizationUnitName'];
    organizationUnitFullName = json['organizationUnitFullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userName'] = this.userName;
    data['realName'] = this.realName;
    data['avatar'] = this.avatar;
    data['sex'] = this.sex;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['positionName'] = this.positionName;
    data['organizationUnitName'] = this.organizationUnitName;
    data['organizationUnitFullName'] = this.organizationUnitFullName;
    return data;
  }
}
