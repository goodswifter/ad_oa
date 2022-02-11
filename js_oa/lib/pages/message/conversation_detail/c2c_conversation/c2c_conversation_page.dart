/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-03 14:20:06
 * @Description: 会话详情 聊天页面 ：C2C主页面
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\c2c_conversation\c2c_conversation_page.dart
 * @LastEditTime: 2021-12-31 16:29:16
 */
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/input_control/input_controller.dart';
import 'package:js_oa/controller/message/message_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/pages/message/conversation_detail/messages_input/advance/advance_icons_widget.dart';
import 'package:js_oa/utils/keyboard/keyboard_utils.dart';
import '../conversation_inner_widget.dart';
import '../msg_input.dart';

class C2cConversationPage extends StatefulWidget {
  C2cConversationPage({Key? key}) : super(key: key);

  @override
  _C2cConversationPageState createState() => _C2cConversationPageState();
}

class _C2cConversationPageState extends State<C2cConversationPage> {
  final MessageController _messageController = Get.find();
  late String _conversationID;
  late String _userID;
  String _titleName = "";
  @override
  void initState() {
    super.initState();
    Get.lazyPut<InputController>(() => InputController());
    Map<String, dynamic> argumentMap = Get.arguments;
    _userID = argumentMap["userID"];
    _conversationID = argumentMap["conversationID"];
    _titleName = argumentMap['conversationName'];
    int _unreadCount = argumentMap['unreadCount'];
    if (_unreadCount != 0) {
      _messageController.setMessageReaded(_userID);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                KeyBoardUtils.hideKeyBoard();
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
                      style: TextStyle(color: JSColors.white),
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
        child: Column(children: [
          //对话内容部分
          Expanded(
              child: ConversationInnerWidget(
            conversationID: _conversationID,
            userID: _userID,
            userName: _titleName,
          )),
          SizedBox(height: 55)
        ]),
      ),
      bottomSheet: MsgInput(toUser: _userID), //输入框部分
      bottomNavigationBar:
          SafeArea(child: AdvanceIconsWidget(toUser: _userID)), //表情、更多消息部分
    );
  }
}
