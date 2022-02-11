/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-31 16:26:06
 * @Description: 人员类别筛选 菜单widget
 * @FilePath: \js_oa\lib\pages\contacts\filter\user_type_filter_widget.dart
 * @LastEditTime: 2021-12-21 16:01:47
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/contact/contact_search_page_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';

class UserTypeFilterWidget extends StatelessWidget {
  UserTypeFilterWidget({Key? key}) : super(key: key);

  final ContactSearchPageController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _controller.getUserTypeListLength() == 0
            ? SizedBox()
            : Container(
                width: double.infinity,
                height: 45.0 * (_controller.getUserTypeListLength()),
                child: _buildUserTypeFilter(),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _controller.showOrHideFilterWidget(1);
            },
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        )
      ],
    );
  }

  _buildUserTypeFilter() {
    return GetBuilder<ContactSearchPageController>(
      id: "user_type_filter",
      builder: (controller) {
        return ListView.builder(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: controller.getUserTypeListLength(),
            itemBuilder: (BuildContext context, int index) {
              String name = controller.userTypeList[index].name!;
              int? userPositionId = controller.userTypeList[index].id;
              return _buildContainer(name, index, userPositionId);
            });
      },
    );
  }

  _buildContainer(String name, int index, int? userPositionId) {
    return InkWell(
        onTap: () {
          _controller.userTypeCheckPosition = index;
          _controller.update(["user_type_filter"]);
          _controller.userTypeText = name;
          _controller.showOrHideFilterWidget(1);
          _controller.requestSearchContactData(
              userPositionId: userPositionId, realName: "-1");
        },
        child: Container(
          height: 45.0,
          width: double.infinity,
          // margin: const EdgeInsets.only(top: 10, bottom: 10, left: 1),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  left: BorderSide(
                      color: index == _controller.userTypeCheckPosition
                          ? Colors.blue
                          : Colors.white,
                      width: 5))),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
          ),
          child: Text(
            name,
            style: TextStyle(
                color: index == _controller.userTypeCheckPosition
                    ? Colors.blue
                    : JSColors.black.withAlpha(200),
                fontSize: 16,
                fontWeight: index == _controller.userTypeCheckPosition
                    ? FontWeight.w500
                    : FontWeight.normal),
          ),
        ));
  }
}
