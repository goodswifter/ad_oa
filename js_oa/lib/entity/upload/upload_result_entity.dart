/// 
/// Author       : zhongaidong
/// Date         : 2021-12-29 14:42:37
/// Description  : 
/// 

// To parse this JSON data, do
//
//     final uploadResultEntity = uploadResultEntityFromJson(jsonString);

import 'dart:convert';

UploadResultEntity uploadResultEntityFromJson(String str) => UploadResultEntity.fromJson(json.decode(str));

String uploadResultEntityToJson(UploadResultEntity data) => json.encode(data.toJson());

class UploadResultEntity {
    UploadResultEntity({
        this.fileName = '',
        this.filePath = '',
        this.fileUrl = '',
    });

    String fileName;
    String filePath;
    String fileUrl;

    factory UploadResultEntity.fromJson(Map<String, dynamic> json) => UploadResultEntity(
        fileName: json["fileName"],
        filePath: json["filePath"],
        fileUrl: json["fileUrl"],
    );

    Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "filePath": filePath,
        "fileUrl": fileUrl,
    };
}
