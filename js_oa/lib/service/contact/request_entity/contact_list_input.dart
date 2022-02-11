/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-09 15:40:48
 * @Description: 获取联系人列表Get请求参数实体
 * @FilePath: \js_oa\lib\service\contact\request_entity\contact_list_input.dart
 * @LastEditTime: 2021-11-23 15:32:42
 */
class GetContactListInput {
  String? organizationUnitCode;
  int? positionId;
  String? realName;
  int pageIndex;
  int pageSize;
  GetContactListInput(
      {this.organizationUnitCode,
      required this.pageIndex,
      required this.pageSize,
      this.realName,
      this.positionId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (organizationUnitCode != null) {
      data['OrganizationUnitCode'] = this.organizationUnitCode;
    }
    if (positionId != null) {
      data['PositionId'] = this.positionId;
    }
    if (realName != null) {
      data['RealName'] = this.realName;
    }
    data['PageIndex'] = this.pageIndex;
    data['PageSize'] = this.pageSize;
    return data;
  }
}
