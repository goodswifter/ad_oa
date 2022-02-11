/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-29 16:35:20
 * @Description: 添加文件消息的ui
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_input\advance\advance_icons_widget.dart
 * @LastEditTime: 2022-01-04 14:30:34
 */

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:js_oa/controller/message/c2c_conversation_controller.dart';
import 'package:js_oa/controller/message/input_control/input_controller.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_input/advance/advance_item_model.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_input/emoji_face/add_emoji_msg.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:js_oa/utils/permission/camera_access_util.dart';
import 'package:js_oa/utils/permission/photos_access_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_thumbnail/video_thumbnail.dart' as video_thumbnail;
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';
import 'advance_item_widget.dart';

class ThumbnailRequest {
  final String video;
  final String thumbnailPath;
  final video_thumbnail.ImageFormat imageFormat;
  final int maxHeight;
  final int maxWidth;
  final int timeMs;
  final int quality;

  const ThumbnailRequest(
      {required this.video,
      required this.thumbnailPath,
      required this.imageFormat,
      required this.maxHeight,
      required this.maxWidth,
      required this.timeMs,
      required this.quality});
}

class ThumbnailResult {
  final Image image;
  final int dataSize;
  final int height;
  final int width;
  final Uint8List byte;
  const ThumbnailResult(
      {required this.image,
      required this.dataSize,
      required this.height,
      required this.byte,
      required this.width});
}

class AdvanceIconsWidget extends StatefulWidget {
  final String toUser;
  static final String advanceId = "advanceId";
  AdvanceIconsWidget({Key? key, required this.toUser}) : super(key: key);

  @override
  _AdvanceIconsWidgetState createState() =>
      _AdvanceIconsWidgetState(advanceId: advanceId);
}

class _AdvanceIconsWidgetState extends State<AdvanceIconsWidget>
    with SingleTickerProviderStateMixin {
  _AdvanceIconsWidgetState({required this.advanceId});
  final String advanceId;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InputController>(
      id: advanceId,
      builder: (inputController) {
        double height = inputController.keyboardHeight;
        return AnimatedContainer(
          curve: Curves.linear,
          transformAlignment: Alignment.bottomCenter,
          height: height,
          decoration: const BoxDecoration(
              color: JSColors.background_grey_light,
              border:
                  Border(top: BorderSide(color: JSColors.grey, width: 0.15))),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          duration: Duration(milliseconds: 100),
          child: height == 0
              ? SizedBox.shrink()
              : height == 185
                  ? AddEmojiMessage(toUser: widget.toUser)
                  : height == 130
                      ? buildPhotoFileWidget(context)
                      : SizedBox.shrink(),
        );
      },
    );
  }

  /// 相册 拍摄 文件 控制台
  Widget buildPhotoFileWidget(BuildContext ctx) {
    return GridView(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2),
      children: [
        AdvanceItemModel(
            name: "照片",
            icon: const Icon(Icons.insert_photo),
            onPressed: () {
              _sendPhotoAlbumMsg(ctx);
            }),
        AdvanceItemModel(
            name: "相机",
            icon: const Icon(Icons.camera_enhance),
            onPressed: () {
              _sendCameraMsg();
            }),
        AdvanceItemModel(
            name: "视频",
            icon: const Icon(Icons.video_camera_back),
            onPressed: () {
              _sendVideoMsg(ctx);
            }),
        AdvanceItemModel(
            name: "语音通话",
            icon: const Icon(Icons.phone),
            onPressed: () {
              _sendRtcInvited();
            }),
      ].map((e) => AdvanceItemWidget(model: e)).toList(),
    );
  }

  ///发送相机消息（图片/视频）
  _sendCameraMsg() async {
    await Permission.storage.request().then((value) async {
      AssetEntity? entity = await CameraAccessUtil.cameraImage(
          context: context, enableRecording: false);
      if (entity == null) {
        return;
      } else {
        await _sendImageMessage((await entity.file)!.path);
      }
    });
  }

  ///发送视频消息
  _sendVideoMsg(BuildContext ctx) async {
    await Permission.storage.request().then((value) async {
      _sendVideoByCamera();
    });
  }

  ///camera拍摄视频
  _sendVideoByCamera() async {
    XFile? file = await _picker.pickVideo(
        source: ImageSource.camera, maxDuration: Duration(seconds: 15));
    if (file == null) {
      return;
    }
    int duration = await file.length();
    String? snapPath = await VideoThumbnail.thumbnailFile(
        video: file.path,
        imageFormat: video_thumbnail.ImageFormat.PNG,
        maxWidth: 128,
        quality: 25);
    C2cConversationController sationController = Get.find();
    await sationController.sendVideoMessage(
        duration: duration,
        toUser: widget.toUser,
        videoPath: file.path,
        snapshotPath: snapPath);
  }

  ///从相册里选择视频发送
  _chooseVideoByAlbum(AssetEntity entity) async {
    String videoPath = (await entity.file)!.path;
    int duration = entity.duration;
    String? snapPath = await VideoThumbnail.thumbnailFile(
        video: videoPath,
        imageFormat: video_thumbnail.ImageFormat.PNG,
        maxWidth: 128,
        quality: 25);
    C2cConversationController sationController = Get.find();
    await sationController.sendVideoMessage(
        duration: duration,
        toUser: widget.toUser,
        videoPath: videoPath,
        snapshotPath: snapPath);
  }

  ///相册
  _sendPhotoAlbumMsg(BuildContext ctx) async {
    try {
      List<AssetEntity>? assets =
          await PhotosAccessUtil.pickerPhoto(context: ctx);
      if (assets != null && assets.length > 0) {
        assets.forEach((element) async {
          if (element.typeInt == 1) {
            ///图片类型
            await _sendImageMessage((await element.file)!.path);
          } else {
            ///视频类型
            await _chooseVideoByAlbum(element);
          }
        });
      }
    } catch (e) {
      ToastUtil.showToast("调起相册出错");
    }
  }

  ///发送语音通话邀请
  _sendRtcInvited() async {
    await Permission.microphone.request().then((value) {
      if (value != PermissionStatus.granted) {
        throw RecordingPermissionException('Microphone permission not granted');
      } else {
        C2cConversationController controller = Get.find();
        String faceUrl = controller.faceUrl == null ? "" : controller.faceUrl!;
        String name =
            controller.showNickName == null ? "" : controller.showNickName!;
        Map<String, dynamic> map = Map();
        map['name'] = name;
        map['faceUrl'] = faceUrl;
        map['toUser'] = widget.toUser;
        map['isInviter'] = true;
        Get.toNamed(AppRoutes.calling, arguments: map);
      }
    });
  }

  ///controller发送一条图片消息
  _sendImageMessage(String? path) async {
    C2cConversationController sationController = Get.find();
    await sationController.sendOneImageMessage(path, widget.toUser);
  }
}
