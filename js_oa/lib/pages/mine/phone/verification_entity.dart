///
/// Author       : zhongaidong
/// Date         : 2021-09-15 16:27:00
/// Description  :
///

class VerificationEntity {
  VerificationEntity({
    required this.inputType,
    required this.account,
  });

  InputType inputType;
  String account;
}

enum InputType {
  /// 手机号
  phone,

  /// 邮箱
  email,
}
