import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/upload/upload_image_controller.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_indata.dart';
import 'package:js_oa/pages/workspace/controller/non_bussiness_controller.dart';
import 'package:js_oa/service/upload/upload_file_type.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/utils/permission/camera_access_util.dart';
import 'package:js_oa/utils/permission/photos_access_util.dart';
import 'package:js_oa/widgets/alert_sheet/action_sheet_widget.dart';
import 'package:js_oa/widgets/alert_sheet/alert_dialog_widget.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class NonBusinessRecordContent extends StatefulWidget {
  NonBusinessRecordContent({Key? key}) : super(key: key);

  @override
  _NonBusinessRecordContentState createState() =>
      _NonBusinessRecordContentState();
}

class _NonBusinessRecordContentState extends State<NonBusinessRecordContent> {
  final personInfoCtrl = Get.put(UploadImageController());
  final noBusinessCtrl = Get.put(NonBusinessController());
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text("新增备案"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(Icons.star_rate, size: 12, color: Colors.red),
                        SizedBox(width: 4),
                        Text("用途："),
                        Expanded(
                            child: TextField(
                          controller: noBusinessCtrl.usesController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 50,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Icon(Icons.star_rate, size: 12, color: Colors.red),
                        SizedBox(width: 4),
                        Text("接受方："),
                        Expanded(
                            child: TextField(
                          controller: noBusinessCtrl.recipientsController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text("附件"),
                    ],
                  ),
                ),
                Obx(() {
                  return noBusinessCtrl.chooseImages.length > 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: ListView.builder(
                              itemCount: noBusinessCtrl.chooseImages.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return photos(
                                    asset: noBusinessCtrl.chooseImages[index],
                                    index: index);
                              }),
                        )
                      : Container();
                }),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: explain(),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 55,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  // border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextButton(
                onPressed: () {
                  print(noBusinessCtrl.chooseImagesUrl.toString());
                  if (noBusinessCtrl.checkInfo()) {
                    showCupertinoDialog(
                      context: context,
                      builder: (ctx) => AlertDialogWidget(
                        title: "确认提交",
                        confirmTitle: "提交",
                        confirmPressed: () {
                          noBusinessCtrl.createNonBusiness(
                              successCallBack: (value) {
                            if (value) {
                              EasyLoading.showSuccess("提交成功");
                              Get.back();
                            }
                          });
                        },
                      ),
                    );
                  }
                },
                child: Text(
                  "提交",
                  // style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget photos({AssetEntity? asset, int? index}) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
      height: 85,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              imageAssetWidget(asset!, height: 50, width: 50),
              SizedBox(width: 8),
              Expanded(child: Text("情况说明")),
              IconButton(
                  onPressed: () {
                    noBusinessCtrl.chooseImages.removeAt(index!);
                    noBusinessCtrl.chooseImagesUrl.removeAt(index);
                  },
                  icon: Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.grey.shade400,
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget explain() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      height: 85,
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _takePhoto(context);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.add_box_outlined,
                    color: Colors.grey.shade400,
                  ),
                ),
              ),
            ],
          )
        ],
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

  /*拍照*/
  _takePhoto(BuildContext ctx) {
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
                personInfoCtrl.assets = [entity];
                personInfoCtrl.uploadImage(
                    assets: [entity],
                    fileType: UploadFileType.payment,
                    success: (resultEntity) {
                      noBusinessCtrl.chooseImages.add(entity);
                      noBusinessCtrl.chooseImagesUrl.add(
                        NonBusinessContractImages(
                          url: resultEntity.fileUrl,
                          path: resultEntity.filePath,
                          name: resultEntity.fileName,
                        ),
                      );
                    });
              }

              break;
            case 1:
              {
                List<AssetEntity>? assets =
                    await PhotosAccessUtil.pickerPhotoImage(context: ctx);
                if (assets != null && assets.isNotEmpty) {
                  personInfoCtrl.assets = assets;
                  personInfoCtrl.uploadImage(
                      assets: assets,
                      fileType: UploadFileType.payment,
                      success: (resultEntity) {
                        noBusinessCtrl.chooseImages.addAll(assets);
                        noBusinessCtrl.chooseImagesUrl.add(
                          NonBusinessContractImages(
                            url: resultEntity.fileUrl,
                            path: resultEntity.filePath,
                            name: resultEntity.fileName,
                          ),
                        );
                      });
                }
              }
          }
        },
      ),
    );
  }
}
