/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-15 16:32:44
 * @Description: 分所列表数据实体
 * @FilePath: \js_oa\lib\entity\contact\office_list_entity.dart
 * @LastEditTime: 2021-11-16 18:03:17
 */
class OfficeListEntity {
  int? id;
  String? name;
  String? code;
  OfficeListEntity({this.code, this.id, this.name});

  OfficeListEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}
