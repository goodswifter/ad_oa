/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-31 16:19:54
 * @Description: 分所筛选条件 菜单widget
 * @FilePath: \js_oa\lib\pages\contacts\filter\firm_filter_widget.dart
 * @LastEditTime: 2021-12-21 16:01:36
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/contact/contact_search_page_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/entity/contact/office_list_entity.dart';

class FirmFilterWidget extends StatefulWidget {
  FirmFilterWidget({Key? key}) : super(key: key);

  @override
  _FirmFilterWidgetState createState() => _FirmFilterWidgetState();
}

class _FirmFilterWidgetState extends State<FirmFilterWidget>
    with SingleTickerProviderStateMixin {
  final ContactSearchPageController _controller = Get.find();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: _controller.getCityListLength() >= 7
              ? screenHeight * (1 / 2)
              : 60.0 * _controller.getCityListLength(),
          color: Colors.white,
          child: _buildOfficeListFilter(),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _controller.showOrHideFilterWidget(0);
            },
            child: Container(
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        ),
      ],
    );
  }

  _buildOfficeListFilter() {
    return GetBuilder<ContactSearchPageController>(
        id: "firm_filter",
        builder: (controller) {
          return ListView.builder(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              itemCount: controller.getCityListLength(),
              itemBuilder: (context, index) {
                OfficeListEntity entity = controller.cityList[index];
                String name = entity.name ?? "";
                String code = entity.code ?? "";
                return _buildContainer(name, code, index);
              });
        });
  }

  _buildContainer(String name, String code, int index) {
    return InkWell(
      onTap: () {
        _controller.firmCheckPosition = index;
        _controller.update(["firm_filter"]);
        _controller.firmText = name;
        _controller.showOrHideFilterWidget(0);
        _controller.requestSearchContactData(
            organizationUnitCode: code, realName: "-1");
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 1),
        decoration: BoxDecoration(
            color: _controller.firmCheckPosition == index
                ? JSColors.background_grey
                : JSColors.white,
            border: Border(
                left: BorderSide(
                    color: index == _controller.firmCheckPosition
                        ? Colors.blue
                        : JSColors.white,
                    width: 5))),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(
          left: 15,
          top: 10,
          bottom: 10,
          right: 15,
        ),
        child: Text(
          name,
          style: TextStyle(
              color: index == _controller.firmCheckPosition
                  ? Colors.blue
                  : JSColors.black.withAlpha(200),
              fontSize: 16,
              fontWeight: index == _controller.firmCheckPosition
                  ? FontWeight.w500
                  : FontWeight.normal),
        ),
      ),
    );
  }
}
