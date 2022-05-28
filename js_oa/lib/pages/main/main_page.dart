import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/message/message_controller.dart';
import 'package:js_oa/core/constants/resource.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/pages/contacts/contact_page.dart';
import 'package:js_oa/pages/message/message_page.dart';
import 'package:js_oa/pages/mine/mine_page.dart';
import 'package:js_oa/pages/workspace/workspace_page.dart';
import 'package:js_oa/widgets/message/badge_widget.dart';
import 'bottom_bar_item.dart';
import 'lazy_index_stack.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  final List<BottomBarItem> mainItems = [];
  final MessageController controller = Get.find();
  late String messageIcon;
  late String workspaceIcon;
  late String contactIcon;
  late String mineIcon;
  @override
  void initState() {
    super.initState();
    controller.getConversationListData();
    setDefaultImageResource(currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    print(1111);
    return Scaffold(
      backgroundColor: Colors.white,
      // body: IndexedStack(
      //   index: currentIndex,
      //   children: [
      //     WorkspacePage(),
      //     ContactPage(),
      //     MessagePage(),
      //     MinePage(),
      //   ],
      // ),
      body: LazyIndexStack(
        index: currentIndex,
        children: [
          LazyStackChild(child: MessagePage()),
          LazyStackChild(child: WorkspacePage()),
          LazyStackChild(child: ContactPage()),
          LazyStackChild(child: MinePage()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: JSColors.background_grey_light,
        selectedFontSize: 14,
        unselectedFontSize: 13,
        iconSize: 23,
        unselectedItemColor: JSColors.black_grey,
        //导航栏icon默认大小24
        items: [
          BottomBarItem(
              "消息",
              Obx(() => JsBadge(
                  readCounts: controller.unreadTotalCount.value,
                  child: Image.asset(messageIcon)))),
          BottomBarItem("工作台", Image.asset(workspaceIcon)),
          BottomBarItem("通讯录", Image.asset(contactIcon)),
          BottomBarItem("我的", Image.asset(mineIcon)),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (value) {
          _changePage(value);
        },
      ),
    );
  }

  void _changePage(index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
        setDefaultImageResource(index);
      });
    }
  }

  void setDefaultImageResource(int index) {
    switch (index) {
      case 0:
        messageIcon = R.ASSETS_IMAGES_TAB_TAB_MESSAGE_HL_PNG;
        workspaceIcon = R.ASSETS_IMAGES_TAB_TAB_WORKSPACE_PNG;
        contactIcon = R.ASSETS_IMAGES_TAB_TAB_CONTACTS_PNG;
        mineIcon = R.ASSETS_IMAGES_TAB_TAB_MINE_PNG;
        break;
      case 1:
        messageIcon = R.ASSETS_IMAGES_TAB_TAB_MESSAGE_PNG;
        workspaceIcon = R.ASSETS_IMAGES_TAB_TAB_WORKSPACE_HL_PNG;
        contactIcon = R.ASSETS_IMAGES_TAB_TAB_CONTACTS_PNG;
        mineIcon = R.ASSETS_IMAGES_TAB_TAB_MINE_PNG;
        break;
      case 2:
        messageIcon = R.ASSETS_IMAGES_TAB_TAB_MESSAGE_PNG;
        workspaceIcon = R.ASSETS_IMAGES_TAB_TAB_WORKSPACE_PNG;
        contactIcon = R.ASSETS_IMAGES_TAB_TAB_CONTACTS_HL_PNG;
        mineIcon = R.ASSETS_IMAGES_TAB_TAB_MINE_PNG;
        break;
      case 3:
        messageIcon = R.ASSETS_IMAGES_TAB_TAB_MESSAGE_PNG;
        workspaceIcon = R.ASSETS_IMAGES_TAB_TAB_WORKSPACE_PNG;
        contactIcon = R.ASSETS_IMAGES_TAB_TAB_CONTACTS_PNG;
        mineIcon = R.ASSETS_IMAGES_TAB_TAB_MINE_HL_PNG;
        break;
      default:
    }
  }
}
