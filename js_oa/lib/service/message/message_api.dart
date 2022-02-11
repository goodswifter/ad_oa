/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-11-18 18:00:53
 * @Description: 消息模块接口 api
 * @FilePath: \js_oa\lib\service\message\message_api.dart
 * @LastEditTime: 2021-12-30 15:53:25
 */
class MessageApi {
  ///根据id获取联系人详情
  static const String getContactDetail = "/api/User/GetUserInfoForContact/";

  static const String getUserImSig = "/api/Account/GetUserSig";
}
