/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-31 14:15:09
 * @Description: 人员信息实体
 * @FilePath: \js_oa\lib\entity\contact\user_type_entity.dart
 * @LastEditTime: 2021-11-16 18:07:00
 */

class UserTypeEntity {
  int? totalCount;
  int? totalPages;
  List<UserTypeItem>? items;

  UserTypeEntity({this.totalCount, this.items, this.totalPages});

  UserTypeEntity.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add(new UserTypeItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['totalPages'] = this.totalPages;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserTypeItem {
  int? id;
  String? name;
  int? userCount;

  UserTypeItem({this.id, this.name, this.userCount});

  UserTypeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userCount = json['userCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['userCount'] = this.userCount;
    return data;
  }
}
