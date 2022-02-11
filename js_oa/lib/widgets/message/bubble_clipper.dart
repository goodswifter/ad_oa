/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-10 11:01:00
 * @Description: 自定义 聊天气泡裁剪
 * @FilePath: \js_oa\lib\widgets\message\bubble_clipper.dart
 * @LastEditTime: 2021-10-12 15:31:13
 */
import 'package:flutter/cupertino.dart';

class BubbleClipper extends CustomClipper<Path> {
  final bool isSelf;
  final double roundRadius;

  BubbleClipper({required this.isSelf, this.roundRadius = 6.5});
  @override
  getClip(Size size) {
    Path path = Path();
    double height = size.height;
    double width = size.width;
    double tempWithSelf = (width - 5.5);
    double tempWithOther = 5.5;
    final double pointHeight1 = 14.9;
    final double pointHeight2 = 19.2;
    final double pointHeight3 = 23.5;
    if (isSelf) {
      path.moveTo(0, roundRadius);
      path.lineTo(0, height - roundRadius);
      path.quadraticBezierTo(0, height, roundRadius,
          height); // 贝塞尔曲线 1.从上一个位置 2.以控制点位置x1，y1为标准点 3.绘制到目标位置x2，y2
      path.lineTo(tempWithSelf - roundRadius, height);
      path.quadraticBezierTo(
          tempWithSelf, height, tempWithSelf, height - roundRadius);
      path.lineTo(tempWithSelf, pointHeight3);
      path.lineTo(width, pointHeight2);
      path.lineTo(tempWithSelf, pointHeight1);
      path.lineTo(tempWithSelf, roundRadius);
      path.quadraticBezierTo(tempWithSelf, 0, tempWithSelf - roundRadius, 0);
      path.lineTo(roundRadius, 0);
      path.quadraticBezierTo(0, 0, 0, roundRadius);
      path.close();
    } else {
      path.moveTo(tempWithOther + roundRadius, 0);
      path.lineTo(width - roundRadius, 0);
      path.quadraticBezierTo(width, 0, width, roundRadius);
      path.lineTo(width, height - roundRadius);
      path.quadraticBezierTo(width, height, width - roundRadius, height);
      path.lineTo(tempWithOther + roundRadius, height);
      path.quadraticBezierTo(
          tempWithOther, height, tempWithOther, height - roundRadius);
      path.lineTo(tempWithOther, pointHeight1);
      path.lineTo(0, pointHeight2);
      path.lineTo(tempWithOther, pointHeight3);
      path.lineTo(tempWithOther, roundRadius);
      path.quadraticBezierTo(tempWithOther, 0, tempWithOther + roundRadius, 0);
      path.close();
    }
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
