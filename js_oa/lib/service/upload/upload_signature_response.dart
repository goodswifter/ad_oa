// To parse this JSON data, do
//
//     final uploadSignatureResponse = uploadSignatureResponseFromJson(jsonString);

import 'dart:convert';

UploadSignatureResponse uploadSignatureResponseFromJson(String str) => UploadSignatureResponse.fromJson(json.decode(str));

String uploadSignatureResponseToJson(UploadSignatureResponse data) => json.encode(data.toJson());

class UploadSignatureResponse {
    UploadSignatureResponse({
        this.successActionStatus,
        this.ossAccessKeyId,
        this.policy,
        this.signature,
        this.host,
        this.key,
        this.expire,
        this.callback,
    });

    int? successActionStatus;
    String? ossAccessKeyId;
    String? policy;
    String? signature;
    String? host;
    String? key;
    int? expire;
    String? callback;

    factory UploadSignatureResponse.fromJson(Map<String, dynamic> json) => UploadSignatureResponse(
        successActionStatus: json["success_Action_Status"],
        ossAccessKeyId: json["ossAccessKeyId"],
        policy: json["policy"],
        signature: json["signature"],
        host: json["host"],
        key: json["key"],
        expire: json["expire"],
        callback: json["callback"],
    );

    Map<String, dynamic> toJson() => {
        "success_Action_Status": successActionStatus,
        "ossAccessKeyId": ossAccessKeyId,
        "policy": policy,
        "signature": signature,
        "host": host,
        "key": key,
        "expire": expire,
        "callback": callback,
    };
}
