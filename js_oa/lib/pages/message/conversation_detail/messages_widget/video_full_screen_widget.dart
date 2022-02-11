/*
 * @Author: 京师在线-杨昆
 * @Date: 2022-01-04 15:12:01
 * @Description: 全屏播放视频消息
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_widget\video_full_screen_widget.dart
 * @LastEditTime: 2022-01-04 17:51:03
 */
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:js_oa/utils/message/delay_tween.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_video_elem.dart';
import 'package:video_player/video_player.dart';

class VideoFullScreenWidget extends StatefulWidget {
  final V2TimVideoElem elem;
  final String messageId;
  final String snapshotUrl;
  VideoFullScreenWidget(
      {Key? key,
      required this.elem,
      required this.messageId,
      required this.snapshotUrl})
      : super(key: key);

  @override
  _VideoFullScreenWidgetState createState() => _VideoFullScreenWidgetState();
}

class _VideoFullScreenWidgetState extends State<VideoFullScreenWidget>
    with SingleTickerProviderStateMixin {
  late final VideoPlayerController _controller;
  final List<double> delays = [
    .0,
    -1.1,
    -1.0,
    -0.9,
    -0.8,
    -0.7,
    -0.6,
    -0.5,
    -0.4,
    -0.3,
    -0.2,
    -0.1
  ];
  late AnimationController _animationController;
  late Image image;
  @override
  void initState() {
    super.initState();
    image = Image.network(
      widget.snapshotUrl,
      fit: BoxFit.fitWidth,
    );
    _animationController =
        (AnimationController(vsync: this, duration: Duration(seconds: 5)))
          ..repeat();
    try {
      if (widget.elem.videoUrl == null) {
        _controller = VideoPlayerController.file(File(widget.elem.videoPath!))
          ..initialize().then((value) {
            _controller.play();
            _controller.setLooping(true);
            setState(() {});
          });
      } else {
        _controller = VideoPlayerController.network(widget.elem.videoUrl!)
          ..initialize().then((value) {
            _controller.play();
            _controller.setLooping(true);
            setState(() {});
          });
      }
    } catch (e) {
      print("视频初始化发生异常");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _animationController.dispose();
        _controller.dispose();
        Navigator.maybePop(context);
      },
      child: SizedBox.expand(
        child: Hero(
          tag: widget.messageId,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: _controller.value.isInitialized
                ? Stack(
                    children: [
                      Center(
                        child: AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (_controller.value.isPlaying) {
                                          _controller.pause();
                                        } else {
                                          _controller.play();
                                        }
                                      });
                                    },
                                    child: _controller.value.isPlaying
                                        ? Container()
                                        : Icon(
                                            Icons.play_circle,
                                            size: 70,
                                            color: Colors.white.withAlpha(200),
                                          ),
                                  )))
                        ],
                      )
                    ],
                  )
                : Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: image,
                      ),
                      Center(
                        child: SizedBox.fromSize(
                          size: Size.square(50),
                          child: Stack(
                            children: List.generate(delays.length, (index) {
                              final _position = 50 * .5;
                              return Positioned.fill(
                                left: _position,
                                top: _position,
                                child: Transform(
                                  transform: Matrix4.rotationZ(
                                      30.0 * index * 0.0174533),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ScaleTransition(
                                      scale: DelayTween(
                                              begin: 0.0,
                                              end: 1.0,
                                              delay: delays[index])
                                          .animate(_animationController),
                                      child: SizedBox.fromSize(
                                          size: Size.square(50 * 0.15),
                                          child: _itemBuilder(index)),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(int index) => DecoratedBox(
      decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle));
}
