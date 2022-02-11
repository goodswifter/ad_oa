/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 09:51:37
 * @Description: 视频消息
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_widget\video_message.dart
 * @LastEditTime: 2022-01-17 14:36:21
 */

import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_video_elem.dart';

import 'video_full_screen_widget.dart';

class VideoMessage extends StatefulWidget {
  final V2TimMessage message;
  final bool isSelf;
  VideoMessage(this.message, this.isSelf);

  @override
  _VideoMessageState createState() => _VideoMessageState();
}

class _VideoMessageState extends State<VideoMessage> {
  late final V2TimVideoElem elem;
  @override
  void initState() {
    super.initState();
    elem = widget.message.videoElem!;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int duration = elem.duration == null
        ? 0
        : elem.duration! > 1000
            ? elem.duration! ~/ 1000000
            : elem.duration!;
    return PhysicalModel(
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        height: (elem.snapshotHeight ?? 200) * 1.2.toDouble(),
        width: (elem.snapshotWidth ?? 185) * 1.2.toDouble(),
        alignment: widget.isSelf ? Alignment.centerRight : Alignment.centerLeft,
        child: Stack(
          children: [
            Container(
              alignment:
                  widget.isSelf ? Alignment.centerRight : Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  _showFullScreenVideoPlay();
                },
                child: Hero(
                  tag: widget.message.msgID!,
                  child: Material(
                    child: Image.network(
                      elem.snapshotUrl ?? "",
                      fit: BoxFit.fill,
                      height: (elem.snapshotHeight ?? 200) * 1.2.toDouble(),
                      width: (elem.snapshotWidth ?? 185) * 1.2.toDouble(),
                    ),
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle,
                    size: 34,
                    color: Colors.white,
                  ),
                )),
                Container(
                  height: 15,
                  padding: const EdgeInsets.only(right: 4, top: 1, bottom: 1),
                  color: JSColors.black.withAlpha(170),
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${duration}s",
                    style: TextStyle(fontSize: 11, color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  ///全屏播放视频
  _showFullScreenVideoPlay() {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return VideoFullScreenWidget(
        elem: elem,
        messageId: widget.message.msgID!,
        snapshotUrl: elem.snapshotUrl ?? "",
      );
    }));
  }
}
