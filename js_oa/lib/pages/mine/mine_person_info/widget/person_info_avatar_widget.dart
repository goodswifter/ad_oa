import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/controller/upload/upload_image_controller.dart';
import 'package:js_oa/core/extension/string_extension.dart';
import 'package:js_oa/core/layout/int_extension.dart';
import 'package:js_oa/im/im_userinfo_manager.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/res/images.dart';
import 'package:js_oa/service/mine/user_request.dart';
import 'package:js_oa/service/upload/upload_file_type.dart';
import 'package:js_oa/utils/permission/camera_access_util.dart';
import 'package:js_oa/utils/permission/photos_access_util.dart';
import 'package:js_oa/widgets/alert_sheet/action_sheet_widget.dart';
import 'package:js_oa/widgets/load_image.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-10-22 17:06:25
/// Description  :
///

class PersonInfoAvatarWidget extends StatelessWidget {
  final personInfoCtrl = Get.put(UploadImageController());
  final LoginController loginCtrl = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 92.px,
      child: ListTile(
        contentPadding: EdgeInsets.only(
            top: 20.px, left: 20.px, right: 20.px, bottom: 21.px),
        onTap: () => showModalPopup01(context),
        tileColor: Colors.white,
        title: Text("头像"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GetBuilder<UploadImageController>(
              init: UploadImageController(),
              builder: (_) {
                return ClipOval(
                  child: _.assets.length == 0
                      ? Obx(() => LoadImage(
                            loginCtrl.userinfo().avatar.nullSafe,
                            height: 63,
                            width: 63,
                            fit: BoxFit.cover,
                          ))
                      : imageAssetWidget(_.assets.first, height: 63, width: 63),
                );
              },
            ),
            Gaps.hGap5,
            Images.arrowRight,
          ],
        ),
      ),
    );
  }

  Widget imageAssetWidget(
    AssetEntity entity, {
    double? width,
    double? height,
  }) {
    return Image(
      image: AssetEntityImageProvider(entity, isOriginal: false),
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }

  showModalPopup01(BuildContext ctx) {
    showCupertinoModalPopup(
      context: ctx,
      builder: (context) => ActionSheetWidget(
        actionTitles: ["拍照", "从手机相册选择"],
        onPressed: (context, index) async {
          Get.back();
          switch (index) {
            case 0:
              AssetEntity? entity =
                  await CameraAccessUtil.cameraImage(context: ctx);
              if (entity != null) {
                uploadAssets([entity]);
              }
              break;
            case 1:
              {
                List<AssetEntity>? assets =
                    await PhotosAccessUtil.pickerPhotoImage(context: ctx);
                if (assets != null && assets.isNotEmpty) {
                  uploadAssets(assets);
                }
              }
          }
        },
      ),
    );
  }

  uploadAssets(List<AssetEntity> assets) {
    personInfoCtrl.assets = assets;
    personInfoCtrl.uploadImage(
        assets: assets,
        fileType: UploadFileType.avatar,
        success: (resultEntity) async {
          String path = resultEntity.fileUrl;
          await UserRequest.modifyAvatar(avatar: path);
          loginCtrl.updateAvatar(path);
          IMUserInfoManager.setImUserInfo(faceUrl: path);
        });
  }
}
