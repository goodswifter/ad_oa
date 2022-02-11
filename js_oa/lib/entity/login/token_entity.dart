/// 
/// Author       : zhongaidong
/// Date         : 2021-10-12 17:48:44
/// Description  : 
/// 
/// To parse this JSON data, do
/// 
/// final accountLoginResponse = accountLoginResponseFromJson(jsonString);

import 'dart:convert';

TokenEntity accountLoginResponseFromJson(String str) => TokenEntity.fromJson(json.decode(str));

String accountLoginResponseToJson(TokenEntity data) => json.encode(data.toJson());

class TokenEntity {
    TokenEntity({
        this.accessToken,
        this.refreshToken,
    });

    String? accessToken;
    String? refreshToken;

    factory TokenEntity.fromJson(Map<String, dynamic> json) => TokenEntity(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
    };
}
