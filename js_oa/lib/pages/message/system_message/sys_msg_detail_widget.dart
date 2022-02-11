/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-12-15 15:56:19
 * @Description: 系统消息的详情列表
 * @FilePath: \js_oa\lib\pages\message\system_message\sys_msg_detail_widget.dart
 * @LastEditTime: 2021-12-22 17:42:01
 */
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/message_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';

import 'sys_msg_detail_body_widget.dart';

class SystemMessageDetailPage extends StatefulWidget {
  SystemMessageDetailPage({Key? key}) : super(key: key);

  @override
  _SystemMessageDetailPageState createState() =>
      _SystemMessageDetailPageState();
}

class _SystemMessageDetailPageState extends State<SystemMessageDetailPage> {
  final MessageController _messageController = Get.find();
  late String _conversationID;
  late String _userID;
  String _titleName = "审批";
  @override
  void initState() {
    super.initState();
    Map<String, dynamic> argumentMap = Get.arguments;
    _userID = argumentMap["userID"];
    _conversationID = argumentMap["conversationID"];
    //_titleName = argumentMap['conversationName'];
    int _unreadCount = argumentMap['unreadCount'];
    if (_unreadCount != 0) {
      _messageController.setMessageReaded(_userID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: JSColors.background_grey_light,
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 90,
        toolbarHeight: 48,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: JSColors.black,
                size: 20,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            Obx(() => Badge(
                  elevation: 0.3,
                  showBadge: _messageController.unreadTotalCount.value != 0,
                  badgeContent: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _messageController.unreadTotalCount.value.toString(),
                      style: TextStyle(color: JSColors.white, fontSize: 12),
                    ),
                  ),
                ))
          ],
        ),
        title: Text(
          _titleName,
          style: TextStyle(color: JSColors.black, fontSize: 18),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: SystemMessageDetailBodyWidget(
            conversationID: _conversationID,
            userID: _userID,
            userName: _titleName,
          )),
          Container(
            height: 55,
            color: JSColors.background_grey_light,
          ),
        ],
      )),
    );
  }
}
