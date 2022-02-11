/// 
/// Author       : zhongaidong
/// Date         : 2021-10-12 16:38:25
/// Description  : 
/// 

import 'dart:convert';

String accountLoginParamToJson(AccountLoginParam data) => json.encode(data.toJson());

class AccountLoginParam {
    AccountLoginParam({
        required this.account,
        required this.passport, // 密码或验证码
        this.passportType = LoginType.password, // 默认是密码登录
    });

    String account;
    String passport;
    LoginType passportType;

    Map<String, dynamic> toJson() => {
        "account": account,
        "passport": passport,
        "passportType": passportType.value,
    };
}

enum LoginType {
  password,
  verificationCode,
}

extension LoginTypeExtension on LoginType {
  int get value => this.index + 1;
}