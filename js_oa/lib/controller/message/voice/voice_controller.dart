/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-26 17:23:57
 * @Description: 语音发送 状态管理
 * @FilePath: \js_oa\lib\controller\message\voice\voice_controller.dart
 * @LastEditTime: 2021-12-10 17:55:50
 */

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_msg_create_info_result.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_value_callback.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

import '../c2c_conversation_controller.dart';

class VoiceController extends GetxController {
  late FlutterSoundPlayer? mPlayer;
  late FlutterSoundRecorder? recorder;
  Codec _codec = Codec.aacMP4;
  String filePath = "";
  @override
  void onInit() {
    super.onInit();
    mPlayer = FlutterSoundPlayer();
    recorder = FlutterSoundRecorder();
  }

  beginRecord() async {
    String fileName = Uuid().v4().toString();
    String fileType = "";
    if (Platform.isIOS) {
      fileType = '.m4a';
    } else {
      fileType = '.mp4';
    }
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    filePath = p.join(appDocPath, fileName + fileType);
    await recorder!.startRecorder(toFile: filePath, codec: _codec);
    update();
  }

  stopRecord() async {
    await recorder!.stopRecorder();
  }

  Future<void> openSession() async {
    await recorder!.openAudioSession();
    if (!await recorder!.isEncoderSupported(_codec) && kIsWeb) {
      _codec = Codec.opusWebM;
    }
  }

  sendVoiceMessage(String receiver) async {
    double _duration = 0.00;
    await flutterSoundHelper.duration(filePath).then((value) {
      _duration = value != null ? value.inMilliseconds / 1000.0 : 0.00;
    });
    V2TimValueCallback<V2TimMsgCreateInfoResult> result =
        await TencentImSDKPlugin.v2TIMManager
            .getMessageManager()
            .createSoundMessage(
                soundPath: filePath, duration: _duration.ceil());
    if (result.code == 0) {
      TencentImSDKPlugin.v2TIMManager
          .getMessageManager()
          .sendMessage(id: result.data!.id!, receiver: receiver, groupID: "")
          .then((sendRes) {
        C2cConversationController sationController = Get.find();
        sationController.addMessage(sendRes.data!);
      });
    }
  }
}
