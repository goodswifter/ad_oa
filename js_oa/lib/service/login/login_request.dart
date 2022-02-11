import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/entity/login/user_entity.dart';
import 'package:js_oa/service/mine/user_request.dart';
import 'package:js_oa/utils/http/dio_new.dart';
import 'package:sp_util/sp_util.dart';

import '../../entity/login/token_entity.dart';
import 'account_login_param.dart';
import 'login_api.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-10-12 16:31:15
/// Description  :
///

const String kLoginToken = "loginToken";
const String kUserinfo = "userinfo";

typedef void SuccessCallBack(UserEntity user);
typedef void FailureCallBack(dynamic error);

class LoginRequest {
  static HttpClient dio = Get.find();
  static LoginController loginController = Get.find();

  static void getUserAuthToken({
    required String account,
    required String password,
    // 1: 密码登录
    LoginType loginType = LoginType.password,
    SuccessCallBack? success,
    FailureCallBack? failure,
  }) async {
    AccountLoginParam param = AccountLoginParam(
      account: account,
      passport: password,
      passportType: loginType,
    );
    HttpResponse appResponse =
        await dio.post(LoginAPI.accountLogin, data: param.toJson());
    if (appResponse.ok) {
      TokenEntity token = TokenEntity.fromJson(appResponse.data);
      bool? isSaveSuccess = await SpUtil.putObject(kLoginToken, token);

      if (isSaveSuccess != null && isSaveSuccess) {
        loginController.loadToken();
        UserRequest.getUserinfo(success: success);
      }
    } else {
      failure?.call(appResponse.error);
    }
  }
}
