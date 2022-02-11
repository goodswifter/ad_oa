/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-30 17:21:39
 * @Description: 通讯录搜索页body主体数据页
 * @FilePath: \js_oa\lib\pages\contacts\search\search_page_body_widget.dart
 * @LastEditTime: 2021-12-14 15:45:21
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/contact/contact_search_page_controller.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/entity/contact/contact_list_model.dart';
import 'package:js_oa/pages/contacts/filter/firm_filter_widget.dart';
import 'package:js_oa/pages/contacts/filter/user_type_filter_widget.dart';
import 'package:js_oa/pages/workspace/widgets/smart_refresher_footer.dart';
import 'package:js_oa/pages/workspace/widgets/smart_refresher_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'search_result_item_widget.dart';

class SearchPageBodyWidget extends StatefulWidget {
  SearchPageBodyWidget({Key? key}) : super(key: key);

  @override
  _SearchPageBodyWidgetState createState() => _SearchPageBodyWidgetState();
}

class _SearchPageBodyWidgetState extends State<SearchPageBodyWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GetBuilder<ContactSearchPageController>(
            id: "contact_search_body",
            builder: (controller) {
              return controller.isFirstTimeInit
                  ? Container(
                      width: double.infinity,
                      height: 350,
                      alignment: Alignment.center,
                      child: const Text(
                        "关键字、分所、人员类别",
                        style: TextStyle(fontSize: 16, color: JSColors.grey),
                      ),
                    )
                  : controller.data.length == 0
                      ? _buildEmptyWidget()
                      : SmartRefresher(
                          controller: controller.refreshController,
                          enablePullDown: false,
                          enablePullUp: true,
                          header: RefreshHeader(),
                          footer: RefreshFooter(),
                          onRefresh: null,
                          onLoading: controller.onLoadMoreData,
                          child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(
                                  parent: BouncingScrollPhysics()),
                              itemCount: controller.data.length,
                              controller: controller.scrollController,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              itemBuilder: (context, index) {
                                Items item = controller.data[index];
                                String name = item.realName ?? " ";
                                String? avatar = item.avatar;
                                String phoneNumber = item.phoneNumber ?? "";
                                return ContactSearchResultItemWidget(
                                  avatar: avatar,
                                  name: name,
                                  phoneNumber: phoneNumber,
                                  routeBuilder: () {
                                    _routeIntent(item);
                                  },
                                );
                              }),
                        );
            }),
        _buildFilterWindow(),
      ],
    );
  }

  ///路由跳转 联系人详情
  _routeIntent(Items item) {
    String name = item.realName ?? " ";
    String? avatar = item.avatar;
    String phoneNumber = item.phoneNumber ?? "";
    String imId = item.imId ?? "";
    String email = item.email ?? "";
    bool? sex = item.sex;
    String organizationUnitName = item.organizationUnitName ?? "";
    String organizationUnitFullName = item.organizationUnitFullName ?? "";
    Map<String, dynamic> map = Map();
    map['faceUrl'] = avatar;
    map['name'] = name;
    map['phoneNumber'] = phoneNumber;
    map['im_Id'] = imId;
    map['email'] = email;
    map['sex'] = sex;
    map['organizationUnitFullName'] = organizationUnitFullName;
    map['organizationUnitName'] = organizationUnitName;
    Get.offNamed(AppRoutes.contactsDetail, arguments: map);
  }

  _buildFilterWindow() {
    return GetBuilder<ContactSearchPageController>(
        id: "showFilter",
        builder: (controller) {
          return AnimatedSwitcher(
            transitionBuilder: (child, animations) {
              return SlideTransition(
                position: animations.drive(
                    Tween(begin: Offset(0, -1), end: Offset(0, 0))
                        .chain(CurveTween(curve: Curves.elasticInOut))),
                child: child,
              );
            },
            duration: Duration(milliseconds: 250),
            child: controller.isShow
                ? IndexedStack(
                    index: controller.currentFilterPosition,
                    children: [FirmFilterWidget(), UserTypeFilterWidget()],
                  )
                : SizedBox(),
          );
        });
  }

  ///无搜索结果显示widget
  _buildEmptyWidget() {
    return Container(
      width: double.infinity,
      height: 350,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 43,
            color: JSColors.grey,
          ),
          SizedBox(
            height: 14,
          ),
          const Text(
            "搜索无结果",
            style: TextStyle(fontSize: 16, color: JSColors.grey),
          )
        ],
      ),
    );
  }
}
