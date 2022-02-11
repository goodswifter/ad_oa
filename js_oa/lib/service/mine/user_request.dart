import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/entity/login/user_entity.dart';
import 'package:js_oa/service/mine/user_param.dart';
import 'package:js_oa/utils/http/dio_new.dart';
import 'package:sp_util/sp_util.dart';

import 'mine_api.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-11-09 15:18:13
/// Description  :
///

const String kUserinfo = "userinfo";

typedef void SuccessCallBack<T>(T user);
typedef void FailureCallBack(dynamic error);

class UserRequest {
  static HttpClient _dio = Get.find();
  static LoginController loginCtrl = Get.find();

  static Future<void> getUserinfo({
    SuccessCallBack<UserEntity>? success,
    FailureCallBack? failure,
  }) async {
    HttpResponse appResponse = await _dio.get(MineAPI.getUserinfo);
    if (appResponse.ok) {
      UserEntity user = UserEntity.fromJson(appResponse.data);
      bool? isSaveSuccess = await SpUtil.putObject(kUserinfo, user);

      if (isSaveSuccess != null && isSaveSuccess) {
        loginCtrl.loadUserinfo();
        success?.call(user);
      }
    } else {
      failure?.call(appResponse.error);
    }
  }

  /// 修改姓名
  static Future<void> modifyRealName({
    required String name,
    SuccessCallBack? success,
    FailureCallBack? failure,
  }) async {
    HttpResponse appResp = await _dio.post('${MineAPI.modifyRealName}$name');
    if (appResp.ok) {
      loginCtrl.updateRealName(name);
      success?.call(appResp.data);
    } else {
      failure?.call(appResp.error);
    }
  }

  /// 修改性别
  static Future<void> modifySex({
    required bool sex,
    SuccessCallBack? success,
    FailureCallBack? failure,
  }) async {
    HttpResponse appResp = await _dio.post('${MineAPI.modifySex}$sex');
    if (appResp.ok) {
      loginCtrl.updateSex(sex);
      success?.call(appResp.data);
    } else {
      failure?.call(appResp.error);
    }
  }

  /// 修改头像
  static Future<void> modifyAvatar({
    required String avatar,
    SuccessCallBack? success,
    FailureCallBack? failure,
  }) async {
    HttpResponse appResp =
        await _dio.post(MineAPI.modifyAvatar, data: {"avatar": avatar});
    if (appResp.ok) {
      loginCtrl.updateAvatar(avatar);
      success?.call(appResp.data);
    } else {
      failure?.call(appResp.error);
    }
  }

  /// 通过密码修改密码
  static Future<void> modifyPwdByPwd({
    required String oldPassword,
    required String newPassword,
    SuccessCallBack? success,
    FailureCallBack? failure,
  }) async {
    UserParam userParam =
        UserParam(oldPassword: oldPassword, newPassword: newPassword);
    HttpResponse appResp = await _dio.post(MineAPI.modifyPwdByPwd,
        data: userParam.toModifyPwdByPwdJson());
    if (appResp.ok) {
      success?.call(appResp.data);
    } else {
      failure?.call(appResp.error);
    }
  }

  /// 通过验证码修改密码或找回密码
  static Future<void> modifyPwdByCode({
    required String code,
    required String phoneNumber,
    required String password,
    SuccessCallBack? success,
    FailureCallBack? failure,
  }) async {
    String uri =
        loginCtrl.loginStatus() ? MineAPI.modifyPwdByCode : MineAPI.forgetPwd;
    UserParam userParam =
        UserParam(code: code, phoneNumber: phoneNumber, password: password);
    HttpResponse appResp =
        await _dio.post(uri, data: userParam.toModifyPwdByCodeJson());
    if (appResp.ok) {
      success?.call(appResp.data);
    } else {
      failure?.call(appResp.error);
    }
  }
}
