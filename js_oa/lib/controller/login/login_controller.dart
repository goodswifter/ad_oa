import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/entity/login/token_entity.dart';
import 'package:js_oa/entity/login/user_entity.dart';
import 'package:js_oa/im/im_login_manager.dart';
import 'package:js_oa/service/login/account_login_param.dart';
import 'package:js_oa/service/login/login_request.dart';
import 'package:sp_util/sp_util.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-11-02 18:33:53
/// Description  :
///

class LoginController extends GetxController {
  var tokenEntity = TokenEntity().obs;
  var userinfo = UserEntity().obs;
  var loginStatus = false.obs;

  @override
  void onInit() {
    super.onInit();

    /// 加载Token
    loadToken();
    loadUserinfo();
  }

  void updateRealName(String realName) {
    userinfo.update((val) => val!.realName = realName);
    dynamic user = SpUtil.getObject(kUserinfo);
    user["realName"] = realName;
    SpUtil.putObject(kUserinfo, user);
  }

  void updateSex(bool sex) {
    userinfo.update((val) => val!.sex = sex);
    dynamic user = SpUtil.getObject(kUserinfo);
    user["sex"] = sex;
    SpUtil.putObject(kUserinfo, user);
  }

  void updateAvatar(String avatar) {
    userinfo.update((val) => val!.avatar = avatar);
    dynamic user = SpUtil.getObject(kUserinfo);
    user["avatar"] = avatar;
    SpUtil.putObject(kUserinfo, user);
  }

  Future<TokenEntity> loadToken() async {
    dynamic token = SpUtil.getObject(kLoginToken);
    if (token != null) {
      tokenEntity(TokenEntity.fromJson(token));
    }
    return tokenEntity.value;
  }

  Future<UserEntity> loadUserinfo() async {
    dynamic user = SpUtil.getObject(kUserinfo);
    if (user != null) {
      loginStatus.value = true;
      userinfo(UserEntity.fromJson(user));
    } else {
      loginStatus.value = false;
    }
    return userinfo.value;
  }

  Future<bool> clearToken() async {
    bool? isRemove = await SpUtil.remove(kLoginToken);
    if (isRemove != null && isRemove) {
      tokenEntity(TokenEntity());
    }
    return isRemove ?? false;
  }

  Future<bool> clearUserinfo() async {
    bool? isRemove = await SpUtil.remove(kUserinfo);
    if (isRemove != null && isRemove) {
      // userinfo(UserEntity());
    }
    return isRemove ?? false;
  }

  void logout() {
    loginStatus.value = false;
    clearToken();
    clearUserinfo();

    IMLoginManager.logout().then((value) => Get.offAllNamed(AppRoutes.initial));
  }

  void login({
    required String account,
    required String passwort,
    // 1 密码登录, 2 验证码登录
    LoginType passwordType = LoginType.password,
    SuccessCallBack? success,
    FailureCallBack? failure,
  }) {
    LoginRequest.getUserAuthToken(
      account: account,
      password: passwort,
      loginType: passwordType,
      success: (data) {
        loginStatus.value = true;
      },
      failure: failure,
    );
  }
}
