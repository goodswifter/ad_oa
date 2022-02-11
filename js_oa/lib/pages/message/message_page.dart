import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/message_controller.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:tencent_im_sdk_plugin/models/v2_tim_conversation.dart';
import 'package:tencent_im_sdk_plugin/tencent_im_sdk_plugin.dart';
import 'message_item/conversation_item_widget.dart';
import 'system_message/sys_msg_item_widget.dart';
import 'top_search_widget.dart';

/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-09-01 21:52:13
 * @Description: 首页消息列表页面
 * @FilePath: \js_oa\lib\pages\messages\message_page.dart
 * @LastEditTime: 2021-09-22 16:31:29
 */
class MessagePage extends StatefulWidget {
  MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> with WidgetsBindingObserver {
  final MessageController _messageController = Get.find();
  final double _height = 2500;
  @override
  void initState() {
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停。
        _messageController.state = AppLifecycleState.inactive;
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
        _messageController.getConversationListData();
        _messageController.state = AppLifecycleState.resumed;
        _setForegroundRunning();
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        _messageController.state = AppLifecycleState.paused;
        _setBackgroundRunning();
        break;
      case AppLifecycleState.detached: // APP结束时调用
        _messageController.state = AppLifecycleState.detached;
        break;
    }
  }

  ///进入后台运行
  _setBackgroundRunning() async {
    try {
      await TencentImSDKPlugin.v2TIMManager
          .getOfflinePushManager()
          .doBackground(unreadCount: _messageController.unreadTotalCount.value)
          .then((value) {
        print("后台回调  " + value.desc);
      });
    } catch (e) {
      print("后台报错  ");
    }
  }

  ///进入前台运行
  _setForegroundRunning() async {
    try {
      await TencentImSDKPlugin.v2TIMManager
          .getOfflinePushManager()
          .doForeground();
    } catch (e) {}
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.2,
        title: Text("京师OA"),
      ),
      body: Container(
        color: JSColors.white,
        height: _height,
        child: CustomScrollView(
          physics:
              AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
          slivers: [
            SliverToBoxAdapter(child: MessageTopSearchWidget(intentBuilder: () {
              Get.toNamed(AppRoutes.contactsSearch);
            })),
            GetBuilder<MessageController>(
              id: "message_conversationlist",
              builder: (controller) {
                return controller.getConversionList.length == 0
                    ? SliverToBoxAdapter(
                        child: Container(
                        child: Image.asset(
                          "assets/images/message/2.0x/no_message.png",
                        ),
                      ))
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                        V2TimConversation conversation =
                            controller.getConversionList[index];
                        String conversationID = conversation.conversationID;
                        String showName = conversation.showName ?? "";
                        String userOrGroupID = conversation.type == 1
                            ? conversation.userID ?? ""
                            : conversation.groupID ?? "";
                        int unreadCount = conversation.unreadCount ?? 0;
                        String faceUrl = conversation.faceUrl ?? "";
                        int type = conversation.type ?? 0;
                        if ("approve" == userOrGroupID) {
                          return SystemMessageItemWidget(
                            lastMessage: conversation.lastMessage!,
                            unreadCount: unreadCount,
                            conversationID: conversationID,
                            userID: userOrGroupID,
                          );
                        } else {
                          return ConversationItemWidget(
                            conversationID: conversationID,
                            showName: showName,
                            lastMessage: conversation.lastMessage!,
                            userID: userOrGroupID,
                            unreadCount: unreadCount,
                            faceUrl: faceUrl,
                            type: type,
                            key: Key(conversationID),
                          );
                        }
                      }, childCount: controller.getConversionList.length));
              },
            )
          ],
        ),
      ),
    );
  }
}
