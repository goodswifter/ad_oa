/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-25 10:07:25
 * @Description: 字母索引 listivew 主入口
 * @FilePath: \js_oa\lib\pages\contacts\letter_list\letter_list_widget.dart
 * @LastEditTime: 2021-11-15 09:52:50
 */
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/pages/message/top_search_widget.dart';

import '../../../controller/contact/index_bar_detail_controller.dart';
import 'index_bar_options.dart';
import 'letter_index_bar.dart';
import 'letter_list_content_widget.dart';

class LetterListView extends StatefulWidget {
  final IndexBarOption? option;
  LetterListView({Key? key, this.option}) : super(key: key);

  @override
  _LetterListViewState createState() => _LetterListViewState();
}

class _LetterListViewState extends State<LetterListView> {
  @override
  void initState() {
    super.initState();
    Get.put(IndexBarDetailController(option: widget.option));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<IndexBarDetailController>(
      id: "letterListView",
      builder: (controller) {
        return controller.letters.length == 0
            ? Container()
            : Stack(
                children: [
                  LetterListContentView(
                    contentTitleItemWithBuilderHeight: 42,
                    data: controller.letters,
                    topSearchWidget: MessageTopSearchWidget(intentBuilder: () {
                      Get.toNamed(AppRoutes.contactsSearch);
                    }),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: LetterIndexBar(
                        data: controller.letters, option: widget.option),
                  )
                ],
              );
      },
    );
  }
}
