/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-12-15 16:01:17
 * @Description: 系统消息详情列表
 * @FilePath: \js_oa\lib\pages\message\system_message\sys_msg_detail_body_widget.dart
 * @LastEditTime: 2021-12-15 16:12:00
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/c2c_conversation_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';

import 'sys_msg_detail_body_item.dart';

class SystemMessageDetailBodyWidget extends StatefulWidget {
  final String conversationID;
  final String userID;
  final String userName;
  SystemMessageDetailBodyWidget(
      {Key? key,
      required this.conversationID,
      required this.userID,
      required this.userName})
      : super(key: key);

  @override
  _SystemMessageDetailBodyWidgetState createState() =>
      _SystemMessageDetailBodyWidgetState();
}

class _SystemMessageDetailBodyWidgetState
    extends State<SystemMessageDetailBodyWidget> {
  final ScrollController _scrollController =
      new ScrollController(initialScrollOffset: 0.0);

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
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }

  _buildMessageListWidgets(C2cConversationController controller) {
    List<SysMessageBodyItemWidget> list = [];
    list.clear();
    int length = controller.messageList.length;
    for (int i = 0; i < length; i++) {
      list.add(SysMessageBodyItemWidget(
        message: controller.messageList[i],
      ));
    }
    return list;
  }
}
