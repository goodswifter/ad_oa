/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-26 14:29:51
 * @Description: 通讯录/消息 头像布局
 * @FilePath: \js_oa\lib\widgets\contact\avatar_widget.dart
 * @LastEditTime: 2021-12-16 14:05:11
 */
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final String avatar;
  final double width;
  final double height;
  final double radius;
  final String userName;
  const Avatar(
      {required this.avatar,
      this.height = 45,
      required this.userName,
      this.radius = 0.0,
      this.width = 45});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.antiAlias,
      child: Container(
          height: height,
          width: width,
          child: avatar.startsWith("assets")
              ? Image(
                  image: AssetImage(avatar),
                  fit: BoxFit.fill,
                  width: width,
                  height: height,
                )
              : (avatar.length > 12 && avatar.contains("http"))
                  ? Image.network(
                      avatar,
                      fit: BoxFit.fill,
                      width: width,
                      height: height,
                      errorBuilder: (context, error, s) {
                        return Container(
                          color: Colors.blue,
                          alignment: Alignment.center,
                          child: Text(
                            userName.trim().length > 4
                                ? userName.substring(0, 4)
                                : userName.trim(),
                            maxLines: 1,
                            style: TextStyle(color: Colors.white, fontSize: 9),
                          ),
                        );
                      },
                    )
                  : Container(
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: Text(
                        userName.trim().length > 4
                            ? userName.substring(0, 4)
                            : userName.trim(),
                        maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 9),
                      ),
                    )),
    );
  }
}
