/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 09:45:50
 * @Description: 图片类型 消息
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_widget\image_message.dart
 * @LastEditTime: 2022-01-04 18:01:54
 */
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_image.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

class ImageMessage extends StatelessWidget {
  final V2TimMessage message;
  final bool isSelf;
  ImageMessage(this.message, this.isSelf);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: message.imageElem!.imageList!.map((e) {
        if (e!.type == 1) {
          if (e.url != null) {
            return PhysicalModel(
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.all(Radius.circular(2)),
              child: Container(
                height: 175,
                padding: isSelf
                    ? EdgeInsets.only(right: 2)
                    : EdgeInsets.only(left: 2),
                alignment:
                    isSelf ? Alignment.centerRight : Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () {
                    _showFullScreenPic(context,
                        imageList: message.imageElem!.imageList!,
                        path: message.imageElem!.path!);
                  },
                  child: Hero(
                    tag: message.msgID!,
                    child: Material(
                      child: Image.network(
                        e.url!,
                        errorBuilder: (context, error, stack) {
                          return Icon(
                            Icons.error,
                            size: 30,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return GestureDetector(
              onTap: () {
                _showFullScreenPic(context,
                    path: message.imageElem!.path!,
                    imageList: message.imageElem!.imageList!);
              },
              child: Hero(
                tag: message.msgID!,
                child:
                    Material(child: Image.file(File(message.imageElem!.path!))),
              ),
            );
          }
        } else {
          return Container();
        }
      }).toList(),
    );
  }

  void _showFullScreenPic(BuildContext context,
      {List<V2TimImage?>? imageList, String? path}) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
      return GestureDetector(
        child: SizedBox.expand(
          child: Hero(
            tag: message.msgID!,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: Image.network(
                imageList![0]!.url!,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    child: child,
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeOut,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.maybePop(context);
        },
      );
    }));
  }
}
