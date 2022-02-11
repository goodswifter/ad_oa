/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-12-30 15:54:28
 * @Description: 登录IM 参数实体
 * @FilePath: \js_oa\lib\entity\message\im_login_entity.dart
 * @LastEditTime: 2021-12-30 16:35:13
 */
class IMLoginInputResponse {
  int? userId;
  String? userSig;

  IMLoginInputResponse({this.userId, this.userSig});

  IMLoginInputResponse.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userSig = json['userSig'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['userSig'] = this.userSig;
    return data;
  }
}
