import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'permission_util.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-26 08:16:14
/// Description  :
///

class PhotosAccessUtil {
  static Future<List<AssetEntity>?> pickerPhotoImage(
      {required BuildContext context, int maxAssetsCount = 1}) async {
    return pickerPhoto(
        context: context,
        maxAssetsCount: maxAssetsCount,
        requestType: RequestType.image);
  }

  static Future<List<AssetEntity>?> pickerPhoto(
      {required BuildContext context,
      int maxAssetsCount = 1,
      RequestType requestType = RequestType.all}) async {
    List<AssetEntity>? assets;

    PermissionStatus photosStatus = await Permission.photos.request();

    bool isFirstAccessPhotos = PermissionUtil.isFirstAccessPhotos();

    if (photosStatus == PermissionStatus.granted) {
      assets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: maxAssetsCount,
          requestType: requestType,
        ),
      );
    } else if (!isFirstAccessPhotos) {
      Get.toNamed(AppRoutes.noAccessPhotos);
    }
    return assets;
  }
}
