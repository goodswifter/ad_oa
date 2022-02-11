///
/// Author       : zhongaidong
/// Date         : 2021-11-09 16:43:37
/// Description  :
///

// To parse this JSON data, do
//
//     final verificationCodeParam = verificationCodeParamFromJson(jsonString);

import 'dart:convert';

VerificationCodeParam verificationCodeParamFromJson(String str) =>
    VerificationCodeParam.fromJson(json.decode(str));

String verificationCodeParamToJson(VerificationCodeParam data) =>
    json.encode(data.toGetJson());

class VerificationCodeParam {
  VerificationCodeParam({
    required this.phoneNumber,
    required this.smsCode,
    this.code,
  });

  String phoneNumber;
  String smsCode;
  String? code;

  factory VerificationCodeParam.fromJson(Map<String, dynamic> json) =>
      VerificationCodeParam(
        phoneNumber: json["PhoneNumber"],
        smsCode: json["SmsCode"],
        code: json["code"],
      );

  Map<String, dynamic> toGetJson() => {
        "PhoneNumber": phoneNumber,
        "SmsCode": smsCode,
      };

  Map<String, dynamic> toVerifyJson() => {
        "PhoneNumber": phoneNumber,
        "SmsCode": smsCode,
        "code": code,
      };
}
