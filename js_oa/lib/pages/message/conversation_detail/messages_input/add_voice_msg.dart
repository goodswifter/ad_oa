/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-24 16:18:25
 * @Description: 按住 说话 widget
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_input\add_voice_msg.dart
 * @LastEditTime: 2021-11-15 10:30:03
 */
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/voice/voice_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class AddVoiceMessage extends StatefulWidget {
  final String toUser;
  AddVoiceMessage({Key? key, required this.toUser}) : super(key: key);

  @override
  _AddVoiceMessageState createState() => _AddVoiceMessageState();
}

class _AddVoiceMessageState extends State<AddVoiceMessage>
    with SingleTickerProviderStateMixin {
  static OverlayEntry? _overlayEntry;
  //帧动画
  late Animation<double> _animation;
  late AnimationController _animationController;
  late Color _color;
  late String _text;
  bool _isCanshow = false;
  bool _isVoiceCanSend = false;
  final VoiceController _voiceController = Get.put(VoiceController());
  final List<String> _images = [
    "assets/images/message/voice_volume_1.png",
    "assets/images/message/voice_volume_2.png",
    "assets/images/message/voice_volume_3.png",
    "assets/images/message/voice_volume_4.png",
    "assets/images/message/voice_volume_5.png",
    "assets/images/message/voice_volume_6.png",
    "assets/images/message/voice_volume_7.png"
  ];
  @override
  void initState() {
    super.initState();
    _open();
    _color = Colors.white;
    _text = "按住 说话";
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animation = Tween<double>(begin: 0, end: 6.9).animate(_animationController)
      ..addListener(() {
        if (!_isCanshow) return;
        _addVoiceOverlay(context);
      });
    _animationController.forward();
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.forward(from: 0);
      } //循环执行动画
    });
  }

  Future<void> _open() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    await _voiceController.mPlayer!.openAudioSession(
      device: AudioDevice.blueToothA2DP,
      audioFlags: allowHeadset | allowEarPiece | allowBlueToothA2DP,
      category: SessionCategory.playAndRecord,
    );
    _voiceController.openSession();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _voiceController.mPlayer!.closeAudioSession();
    _voiceController.mPlayer = null;
    _voiceController.recorder!.closeAudioSession();
    _voiceController.recorder = null;
    super.dispose();
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry!.dispose();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (e) {
        _isCanshow = true;
        _color = JSColors.grey;
        _text = "松开 发送";
        setState(() {});
        _addVoiceOverlay(context);
        _voiceController.beginRecord();
      },
      onLongPressMoveUpdate: (e) {
        if (e.localPosition.dy < 0) {
          _color = Colors.orange.withAlpha(50);
          _text = "松开手指 取消发送";
          _isVoiceCanSend = false;
        } else {
          _isCanshow = true;
          _color = JSColors.grey;
          _text = "松开 发送";
          _isVoiceCanSend = true;
        }
        setState(() {});
      },
      onTapCancel: () {
        _voiceController.stopRecord();
        _isCanshow = false;
        _removeVoiceOverlay();
      },
      onVerticalDragEnd: (e) {
        _voiceController.stopRecord();
        _removeVoiceOverlay();
      },
      onVerticalDragCancel: () {
        _voiceController.stopRecord();
        _isCanshow = false;
        _removeVoiceOverlay();
      },
      onLongPressEnd: (e) {
        _voiceController.stopRecord();
        _isCanshow = false;
        _removeVoiceOverlay();
        if (_isVoiceCanSend) {
          _voiceController.sendVoiceMessage(widget.toUser);
        }
      },
      child: Container(
        height: 38,
        padding: const EdgeInsets.only(left: 7, right: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                width: 0.8,
                style: BorderStyle.solid,
                color: JSColors.background_grey),
            color: _color),
        alignment: Alignment.center,
        child: Text(
          _text,
          style: TextStyle(color: JSColors.black, fontSize: 14),
        ),
      ),
    );
  }

  _addVoiceOverlay(BuildContext context) {
    OverlayState? overlayState = Overlay.of(context);
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(builder: (BuildContext context) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: JSColors.black,
                  image: DecorationImage(
                      image: AssetImage(_images[_animation.value.toInt()]),
                      fit: BoxFit.contain)),
            ),
          ),
        );
      });
      overlayState!.insert(_overlayEntry!);
    } else {
      //重新绘制UI
      _overlayEntry!.markNeedsBuild();
    }
  }

  _removeVoiceOverlay() {
    _color = JSColors.white;
    _text = "按住 说话";
    setState(() {});
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }
}
