/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-29 16:38:47
 * @Description: "相册" "拍摄" "文件" item布局
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_input\advance\advance_item_widget.dart
 * @LastEditTime: 2021-11-15 10:20:08
 */
import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';

import 'advance_item_model.dart';

class AdvanceItemWidget extends StatelessWidget {
  final AdvanceItemModel model;
  const AdvanceItemWidget({Key? key, required this.model}) : super(key: key);

  _onPressed() {
    model.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: IconButton(
                icon: model.icon,
                color: JSColors.black,
                onPressed: _onPressed,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              child: Text(
                model.name,
                style: TextStyle(
                  fontSize: 12,
                  color: JSColors.black,
                ),
              ),
            )
          ],
        ));
  }
}
