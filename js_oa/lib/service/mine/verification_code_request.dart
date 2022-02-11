import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/service/mine/verification_code_param.dart';
import 'package:js_oa/utils/http/dio_new.dart';

import 'mine_api.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-11-09 16:22:44
/// Description  :
///

typedef void SuccessCallBack<T>(T user);
typedef void FailureCallBack(dynamic error);

class VerificationCodeRequest {
  static HttpClient dio = Get.find();
  static LoginController loginCtrl = Get.find();

  static Future<void> getVerificationCode({
    required String phoneNumber,
    CodeType codeType = CodeType.password,
    SuccessCallBack? success,
    FailureCallBack? failure,
  }) async {
    String uri = loginCtrl.loginStatus()
        ? MineAPI.getVerificationCodeAfterLogin
        : MineAPI.getVerificationCodeBeforeLogin;
    VerificationCodeParam param = VerificationCodeParam(
        phoneNumber: phoneNumber, smsCode: codeType.value);
    HttpResponse appResp = await dio.get(uri,
        queryParameters: param.toGetJson(), isShowEasyLoading: false);
    print(appResp);
    if (appResp.ok) {
      success?.call(appResp.data);
    } else {
      failure?.call(appResp.error!.message);
    }
  }

  static Future<void> verifyVerificationCode({
    required String phoneNumber,
    CodeType codeType = CodeType.password,
    required String verificationCode,
    SuccessCallBack? success,
    FailureCallBack? failure,
  }) async {
    String uri = loginCtrl.loginStatus()
        ? MineAPI.verifyVerificationCodeAfterLogin
        : MineAPI.verifyVerificationCodeBeforeLogin;
    VerificationCodeParam param = VerificationCodeParam(
      phoneNumber: phoneNumber,
      smsCode: codeType.value,
      code: verificationCode,
    );
    HttpResponse appResp = await dio.post(uri, data: param.toVerifyJson());
    if (appResp.ok) {
      success?.call(appResp.data);
    } else {
      failure?.call(appResp.error);
    }
  }
}

enum CodeType {
  /// 修改密码和忘记密码
  password,

  /// 修改手机号码
  modifyPhoneNumber,

  /// 手机号登录
  login,
}

extension CodeTypeExtension on CodeType {
  String get value => ['Password', 'ChangePhoneNumber', 'Login'][index];
}
