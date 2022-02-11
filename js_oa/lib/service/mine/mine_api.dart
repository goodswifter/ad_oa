///
/// Author       : zhongaidong
/// Date         : 2021-11-09 15:17:45
/// Description  :
///

class MineAPI {
  /// 获取用户信息
  static const String getUserinfo = "/api/Account/GetCurrentUser";

  /// 修改用户名
  static const String modifyRealName = "/api/User/ChangeRealName/";

  /// 修改性别
  static const String modifySex = "/api/User/ChangeSex/";

  /// 修改头像
  static const String modifyAvatar = "/api/User/ChangeAvatar";

  /// 登录之前获取验证码
  static const String getVerificationCodeBeforeLogin =
      "/api/Account/GetCheckCode";

  /// 登录之后获取验证码
  static const String getVerificationCodeAfterLogin = "/api/Sms/GetCheckCode";

  /// 登录之前验证验证码
  static const String verifyVerificationCodeBeforeLogin =
      "/api/Account/ValidateCheckCode";

  /// 登录之后验证验证码
  static const String verifyVerificationCodeAfterLogin =
      "/api/Sms/ValidateCheckCode";

  /// 通过密码修改密码
  static const String modifyPwdByPwd = "/api/User/ChangePassword";

  /// 通过验证码修改密码
  static const String modifyPwdByCode = "/api/User/ChangePasswordByCode";

  /// 忘记密码
  static const String forgetPwd = "/api/Account/ChangePasswordByCode";
}
