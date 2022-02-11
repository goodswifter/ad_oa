import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/entity/upload/upload_result_entity.dart';
import 'package:js_oa/service/upload/upload_file_type.dart';
import 'package:js_oa/service/upload/upload_request.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-24 16:39:23
/// Description  :
///

typedef void SuccessCallBack<T>(T parh);
typedef void FailureCallBack(dynamic error);

class UploadImageController extends GetxController {
  final LoginController loginCtrl = Get.find();
  List<AssetEntity> _assets = [];
  List<AssetEntity> get assets => _assets;
  set assets(assets) {
    _assets = assets;
    update();
  }

  void uploadImage({
    required List<AssetEntity> assets,
    required UploadFileType fileType,
    SuccessCallBack<UploadResultEntity>? success,
  }) {
    UploadRequest.uploadAssetEntity(
      asset: assets.first,
      fileType: fileType,
      success: success,
      failure: (error) {
        print(error);
      },
    );
  }
}
