/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-09 15:35:34
 * @Description: 联系人接口 api
 * @FilePath: \js_oa\lib\service\contact\contact_api.dart
 * @LastEditTime: 2021-11-23 15:33:35
 */
class ContactApi {
  ///联系人列表
  static const String getContactPageList = "/api/User/GetContactPagedList";

  ///人员类别类型 筛选联系人
  static const String userTypeList = "/api/Position/GetPagedList";

  ///分所列表 筛选联系人
  static const String officeList = "/api/OrganizationUnit/GetOfficeList";

  ///根据id获取联系人详情
  static const String getUserInfoForContact = "/api/User/GetUserInfoForContact";
}
