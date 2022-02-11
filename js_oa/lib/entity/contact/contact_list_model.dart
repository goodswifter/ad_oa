/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-24 15:07:22
 * @Description: 
 * @FilePath: \js_oa\lib\entity\contact\contact_list_model.dart
 * @LastEditTime: 2021-11-15 16:35:46
 */

class ContactListModel {
  int? pageIndex;

  int? pageSize;
  int? totalCount;
  int? totalPages;
  List<Items>? items;
  bool? hasPrevPages;
  bool? hasNextPages;

  ContactListModel(
      {this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.items,
      this.hasPrevPages,
      this.hasNextPages});

  ContactListModel.fromJson(Map<String, dynamic> json) {
    pageIndex = json['pageIndex'];
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
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

abstract class ISuspensionBean {
  String getSecentLetter();
  String getThirdLetter();
  String getSuspensionTag(); //Suspension Tag
}

class Items extends ISuspensionBean {
  int? id;
  bool? sex;
  String? avatar;
  String? realName;
  String? phoneNumber;
  String? email;
  String? userTypeName;
  String? organizationUnitFullName;
  String? tagIndex;
  String? letterName;
  String? organizationUnitName;
  String? imId;
  String? userName;
  String? secentLetter;
  String? thirdLetter;
  Items(
      {this.id,
      this.avatar = "",
      this.realName,
      this.phoneNumber,
      this.email,
      this.userName,
      this.userTypeName,
      this.tagIndex,
      this.organizationUnitName,
      this.sex,
      this.letterName,
      this.secentLetter = "**",
      this.thirdLetter = "**",
      this.imId,
      this.organizationUnitFullName});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    avatar = json['avatar'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    userName = json['userName'];
    realName = json['realName'] ?? userName;
    sex = json['sex'] ?? true;
    organizationUnitName = json['organizationUnitName'];
    imId = id.toString();
    userTypeName = json['userTypeName'];
    secentLetter = "**";
    thirdLetter = "**";
    organizationUnitFullName = json['organizationUnitFullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.id;
    data['organizationUnitName'] = this.organizationUnitName;
    data['avatr'] = this.avatar;
    data['sex'] = this.sex;
    data['realName'] = this.realName;
    data['userName'] = this.userName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['imId'] = this.imId;
    data['userTypeName'] = this.userTypeName;
    data['organizationUnitFullName'] = this.organizationUnitFullName;
    return data;
  }

  @override
  String getSuspensionTag() => tagIndex!;

  @override
  String getSecentLetter() => secentLetter!;

  @override
  String getThirdLetter() => thirdLetter!;
}
