///
/// Author       : zhongaidong
/// Date         : 2021-08-18 14:10:51
/// Description  :
///

// To parse this JSON data, do
//
//     final basicModel = basicModelFromJson(jsonString);

import 'dart:convert';

BasicModel basicModelFromJson(String str) =>
    BasicModel.fromJson(json.decode(str));

String basicModelToJson(BasicModel data) => json.encode(data.toJson());

class BasicModel {
  BasicModel({
    this.extras,
    this.data,
    this.errors,
    this.timestamp,
    this.succeeded,
    this.statusCode,
  });

  String? extras;
  dynamic data;
  String? errors;
  int? timestamp;
  bool? succeeded;
  int? statusCode;

  factory BasicModel.fromJson(Map<String, dynamic> json) => BasicModel(
        extras: json["extras"],
        data: json["data"],
        errors: json["errors"],
        timestamp: json["timestamp"],
        succeeded: json["succeeded"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "extras": extras,
        "data": data,
        "errors": errors,
        "timestamp": timestamp,
        "succeeded": succeeded,
        "statusCode": statusCode,
      };
}
