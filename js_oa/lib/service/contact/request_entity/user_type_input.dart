/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-11 09:51:25
 * @Description: 人员类别请求实体
 * @FilePath: \js_oa\lib\service\contact\request_entity\user_type_input.dart
 * @LastEditTime: 2021-11-23 15:32:53
 */

class UserTypeInput {
  String? name;
  int pageIndex;
  int pageSize;
  UserTypeInput({this.name, required this.pageIndex, required this.pageSize});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (name != null && "" != name) {
      data['Name'] = this.name;
    }
    data['PageIndex'] = this.pageIndex;
    data['PageSize'] = this.pageSize;
    return data;
  }
}
