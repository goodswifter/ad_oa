/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-30 15:47:09
 * @Description: 
 * @FilePath: \js_oa\lib\pages\contacts\search\search_page_filter_widget.dart
 * @LastEditTime: 2021-12-21 16:02:35
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/contact/contact_search_page_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';

typedef FilterSelectBuilder = void Function(int, String);

class SearchPageAppbarBottomFilterWidget extends StatefulWidget {
  final FilterSelectBuilder? selectBuilder;
  SearchPageAppbarBottomFilterWidget({Key? key, this.selectBuilder})
      : super(key: key);

  @override
  _SearchPageAppbarBottomFilterWidgetState createState() =>
      _SearchPageAppbarBottomFilterWidgetState();
}

class _SearchPageAppbarBottomFilterWidgetState
    extends State<SearchPageAppbarBottomFilterWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: MaterialButton(
              onPressed: () {
                widget.selectBuilder!(0, "OrganizationUnitId");
              },
              child: GetBuilder<ContactSearchPageController>(
                id: "firm_text",
                builder: (controller) {
                  return Flex(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          controller.firmText,
                          maxLines: 1,
                          style: TextStyle(
                            color: "分所" == controller.firmText
                                ? JSColors.black.withAlpha(180)
                                : JSColors.black,
                          ),
                        ),
                      ),
                      TweenAnimationBuilder(
                          tween: Tween<double>(
                              begin: 0, end: controller.isFirmShow ? 3.14 : 0),
                          duration: const Duration(milliseconds: 250),
                          builder: (BuildContext context, double value, child) {
                            return Transform.rotate(
                              angle: value,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                                color: "分所" == controller.firmText
                                    ? JSColors.black.withAlpha(200)
                                    : JSColors.black,
                              ),
                            );
                          }),
                    ],
                  );
                },
              ),
            ),
            flex: 1,
          ),
          Container(
            width: 1,
            height: 20,
            color: Colors.grey.withAlpha(60),
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () {
                widget.selectBuilder!(1, "UserTypeId");
              },
              child: GetBuilder<ContactSearchPageController>(
                id: "user_type_text",
                builder: (controller) {
                  return Flex(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    direction: Axis.horizontal,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          controller.userTypeText,
                          maxLines: 1,
                          style: TextStyle(
                            color: "人员类别" == controller.userTypeText
                                ? JSColors.black.withAlpha(180)
                                : JSColors.black,
                          ),
                        ),
                      ),
                      TweenAnimationBuilder(
                          tween: Tween<double>(
                              begin: 0,
                              end: controller.isUserTypeShow ? 3.14 : 0),
                          duration: const Duration(milliseconds: 250),
                          builder: (context, double value, child) {
                            return Transform.rotate(
                              angle: value,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                size: 20,
                                color: "人员类别" == controller.userTypeText
                                    ? JSColors.black.withAlpha(180)
                                    : JSColors.black,
                              ),
                            );
                          })
                    ],
                  );
                },
              ),
            ),
            flex: 1,
          )
        ],
      ),
    );
  }
}
