import 'package:get/get.dart';
import 'package:js_oa/entity/upload/upload_result_entity.dart';
import 'package:js_oa/service/upload/upload_api.dart';
import 'package:js_oa/service/upload/upload_file_type.dart';
import 'package:js_oa/service/upload/upload_signature_response.dart';
import 'package:js_oa/utils/http/dio_new.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-12-02 15:08:22
/// Description  :
///

typedef void SuccessCallBack<T>(T user);
typedef void FailureCallBack(dynamic error);

class UploadRequest {
  static HttpClient _dio = Get.find();
  static Future<void> uploadAssetEntity({
    required AssetEntity asset,
    required UploadFileType fileType,
    SuccessCallBack<UploadResultEntity>? success,
    FailureCallBack? failure,
  }) async {
    // 1. 获取签名
    UploadSignatureResponse? sign = await _getSignData(
      fileType: UploadFileType.avatar.value,
      filename: asset.title ?? "",
    );
    if (sign == null) return;

    // Options options = Options().copyWith(headers: {
    //   "x-oss-object-acl":
    //       fileType == UploadFileType.avatar ? "public-read" : "private"
    // });
    HttpResponse resp = await _dio.upload(
      sign.host!,
      filePath: (await asset.file)!.path,
      data: sign.toJson(),
    );
    if (resp.ok) {
      UploadResultEntity result = UploadResultEntity.fromJson(resp.data);
      success?.call(result);
    } else {
      failure?.call(resp.error);
    }
  }

  static Future<UploadSignatureResponse?> _getSignData({
    required String fileType,
    required String filename,
  }) async {
    Map<String, dynamic>? params = {'FileType': fileType, 'FileName': filename};
    HttpResponse resp =
        await _dio.get(UploadApi.getFileSignature, queryParameters: params);
    if (resp.ok) {
      return UploadSignatureResponse.fromJson(resp.data);
    } else {
      return null;
    }
  }
}
