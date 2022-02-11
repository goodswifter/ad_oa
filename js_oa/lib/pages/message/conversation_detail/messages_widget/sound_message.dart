/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 09:52:14
 * @Description: 语音消息
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_widget\sound_message.dart
 * @LastEditTime: 2021-11-15 10:39:56
 */
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_sound_elem.dart';

class SoundMessage extends StatefulWidget {
  final V2TimMessage message;
  final TextAlign align;
  final bool isself;

  SoundMessage(this.message, this.align, this.isself);
  @override
  _SoundMessageState createState() => _SoundMessageState();
}

class _SoundMessageState extends State<SoundMessage>
    with SingleTickerProviderStateMixin {
  late final V2TimSoundElem _elem;
  String _text = "";

  ///根据语音时长动态设置 语音消息widget的宽度
  double _width = 20.0;

  ///语音播放波浪效果
  late final Animation<double> _animation;

  ///动画控制器
  late final AnimationController _animationController;
  FlutterSoundPlayer? player = FlutterSoundPlayer();
  final List<String> _images = [
    "assets/images/message/left_voice_1.png",
    "assets/images/message/left_voice_2.png",
    "assets/images/message/left_voice_3.png",
  ];
  final List<String> _imagesSelf = [
    "assets/images/message/right_voice_1.png",
    "assets/images/message/right_voice_2.png",
    "assets/images/message/right_voice_3.png",
  ];
  int _index = 2;
  @override
  void initState() {
    super.initState();
    _elem = widget.message.soundElem!;
    _text = """ ${_elem.duration}'' """;
    _width = 20.0 + (_elem.duration == null ? 0 : _elem.duration!) * 2;
    _width = min(_width, 160);
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    _animation = Tween<double>(begin: 0, end: 2.9).animate(_animationController)
      ..addListener(() {
        setState(() {
          _index = _animation.value.toInt();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _animationController.forward();
        _animationController.repeat();
        _playSound();
      },
      child: Row(
        textDirection: widget.isself ? TextDirection.rtl : TextDirection.ltr,
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.isself
              ? Image.asset(
                  _imagesSelf[_index],
                  width: 18,
                  height: 18,
                )
              : Image.asset(
                  _images[_index],
                  width: 18,
                  height: 18,
                ),
          Container(
            width: _width,
            alignment: Alignment.center,
            child: Text(
              _text,
              textAlign: widget.align,
              style:
                  TextStyle(fontSize: 16, color: JSColors.hexToColor('171538')),
            ),
          )
        ],
      ),
    );
  }

  _playSound() async {
    player!.openAudioSession();
    await player!.startPlayer(
        fromURI: _elem.url,
        whenFinished: () {
          _animationController.stop();
          _index = 2;
          setState(() {});
        });
  }

  @override
  void dispose() {
    _animationController.dispose();
    player!.closeAudioSession();
    player = null;
    super.dispose();
  }
}
