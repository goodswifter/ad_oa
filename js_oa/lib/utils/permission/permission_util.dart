import 'package:sp_util/sp_util.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-30 16:07:36
/// Description  :
///

class PermissionUtil {
  static bool isFirstAccessPhotos() {
    String isPhotosAccessKey = "is_photos_camera";
    var photoRusult = SpUtil.getBool(isPhotosAccessKey);
    if (photoRusult == null) {
      SpUtil.putBool(isPhotosAccessKey, true);
      return true;
    } else {
      return false;
    }
  }

  static bool isFirstAccessCamera() {
    String isCameraAccessKey = "is_access_camera";
    var cameraRusult = SpUtil.getBool(isCameraAccessKey);
    if (cameraRusult == null) {
      SpUtil.putBool(isCameraAccessKey, true);
      return true;
    } else {
      return false;
    }
  }
}
