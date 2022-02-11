// To parse this JSON data, do
//
//     final userParam = userParamFromJson(jsonString);

import 'dart:convert';

UserParam userParamFromJson(String str) => UserParam.fromJson(json.decode(str));

// String userParamToJson(UserParam data) => json.encode(data.toJson());

class UserParam {
    UserParam({
        this.oldPassword,
        this.newPassword,
        this.code,
        this.phoneNumber,
        this.password,
    });

    String? oldPassword;
    String? newPassword;
    String? code;
    String? phoneNumber;
    String? password;

    factory UserParam.fromJson(Map<String, dynamic> json) => UserParam(
        oldPassword: json["oldPassword"],
        newPassword: json["newPassword"],
        code: json["code"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
    );

    Map<String, dynamic> toModifyPwdByPwdJson() => {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
    };

    Map<String, dynamic> toModifyPwdByCodeJson() => {
        "code": code,
        "phoneNumber": phoneNumber,
        "password": password,
    };
}
