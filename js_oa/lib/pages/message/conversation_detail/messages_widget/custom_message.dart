/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 09:53:11
 * @Description: 自定义消息
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\messages_widget\custom_message.dart
 * @LastEditTime: 2021-12-22 09:22:41
 */
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/input_control/input_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/entity/login/user_entity.dart';
import 'package:js_oa/im/entity/notifycation_message_entity.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_input/advance/advance_icons_widget.dart';
import 'package:sp_util/sp_util.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_custom_elem.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_message.dart';

class CustomMessage extends StatefulWidget {
  CustomMessage(this.message, this.isSelf);
  final bool isSelf;
  final V2TimMessage message;

  @override
  _CustomMessageState createState() => _CustomMessageState();
}

class _CustomMessageState extends State<CustomMessage> {
  late final V2TimMessage _customMessage;
  late String desc = "desc";
  late String extendtion = "extendtion";
  late String approvalTitle = "approvalTitle";
  late String title = "title";
  late String content1 = "content1";
  late String content2 = "content2";
  late String workflowId = "workflowId";
  late String routeString = "";
  late String userId = "";
  late String myId = "";
  late String createrUserId = "";
  @override
  void initState() {
    super.initState();
    _customMessage = widget.message;
    V2TimCustomElem elem = _customMessage.customElem!;
    if (elem.data != null) {
      Map<String, dynamic> result = json.decode(elem.data!.toString());
      desc = elem.desc ?? "";
      extendtion = elem.extension ?? "";
      CustomMessageData bean = CustomMessageData.fromJson(result);
      approvalTitle = bean.approvalTitle ?? "";
      title = bean.title ?? "";
      workflowId = bean.workflowId ?? "";
      routeString = bean.routePath ?? "";
      dynamic user = SpUtil.getObject("userinfo");
      UserEntity userInfo = UserEntity.fromJson(user);
      myId = userInfo.id!.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        InputController controller = Get.find();
        controller.update([AdvanceIconsWidget.advanceId]);
        FocusScope.of(context).requestFocus(FocusNode());
        Map<String, dynamic> arguments = Map();
        arguments['workflowId'] = workflowId;
        Get.toNamed(routeString, arguments: arguments);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 18, top: 3, right: 15, bottom: 8),
            child: Text(
              approvalTitle,
              style: TextStyle(
                color: Colors.orange,
                fontSize: 18,
              ),
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 18, right: 15, top: 3, bottom: 3),
            width: 210,
            child: Text(
              title,
              style: TextStyle(fontSize: 16, color: JSColors.black),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 18, right: 15, top: 6, bottom: 3),
            child: Text(
              content1,
              style: TextStyle(fontSize: 14, color: JSColors.textWeakColor),
            ),
          ),
          Container(
            width: 210,
            margin:
                const EdgeInsets.only(left: 18, right: 15, top: 6, bottom: 3),
            height: 0.1,
            color: JSColors.textWeakColor,
          ),
          Container(
            width: 230,
            padding: const EdgeInsets.only(left: 18, top: 1, bottom: 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(
                  "查看详情",
                  style: TextStyle(fontSize: 12, color: JSColors.textWeakColor),
                )),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: JSColors.textWeakColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
