/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-02 17:55:04
 * @Description: 会话详情 聊天页面：body部分
 * @FilePath: \js_oa\lib\pages\message\conversation_detail\conversation_inner_widget.dart
 * @LastEditTime: 2021-12-29 16:54:28
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/c2c_conversation_controller.dart';
import 'package:js_oa/controller/message/input_control/input_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/entity/login/user_entity.dart';
import 'package:js_oa/pages/message/conversation_detail/component/message_widget.dart';
import 'package:js_oa/widgets/keyboard/keyboard_dismiss.dart';
import 'package:sp_util/sp_util.dart';

class ConversationInnerWidget extends StatefulWidget {
  final String conversationID;
  final String userID;
  final String userName;
  ConversationInnerWidget(
      {required this.conversationID,
      required this.userID,
      required this.userName});

  @override
  _ConversationInnerWidgetState createState() =>
      _ConversationInnerWidgetState();
}

class _ConversationInnerWidgetState extends State<ConversationInnerWidget> {
  final ScrollController _scrollController =
      new ScrollController(initialScrollOffset: 0.0);
  final InputController _inputController = Get.find();
  late final String myAvatar;
  late final String myName;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      double maxDy = _scrollController.position.maxScrollExtent;
      if (_scrollController.offset == maxDy) {
        C2cConversationController controller = Get.find();
        controller.loadMoreHistoryData();
      }
    });
    dynamic user = SpUtil.getObject("userinfo");
    UserEntity userInfo = UserEntity.fromJson(user);
    myAvatar = userInfo.avatar ?? userInfo.userName!;
    myName = userInfo.realName ?? userInfo.userName!;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      onTap: () => _inputController.chatInnerBackgroundClickEvent(),
      child: Container(
        alignment: Alignment
            .topCenter, //解决 Column嵌套list或ScrollView 布局正序或倒序排列问题 reverse:true
        width: double.infinity,
        color: JSColors.hexToColor('F2F2F2'),
        child: GetBuilder<C2cConversationController>(
          id: "conversation_message_list",
          init: C2cConversationController(
              conversationId: widget.conversationID, userId: widget.userID),
          builder: (controller) {
            return SingleChildScrollView(
              controller: _scrollController,
              reverse: true,
              padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
              child: Column(children: _buildMessageListWidgets(controller)),
            );
          },
        ),
      ),
    );
  }

  List<MessageWidget> _buildMessageListWidgets(
      C2cConversationController controller) {
    List<MessageWidget> list = [];
    list.clear();
    int length = controller.messageList.length;
    for (int i = 0; i < length; i++) {
      list.add(MessageWidget(
        toUser: widget.userID,
        message: controller.messageList[i],
        conversationID: widget.conversationID,
        userName: widget.userName,
        myAvatar: myAvatar,
        myName: myName,
      ));
    }
    return list;
  }
}
