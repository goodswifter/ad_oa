import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/contact/contact_search_page_controller.dart';
import 'package:js_oa/core/theme/js_colors.dart';
import 'package:js_oa/utils/keyboard/keyboard_utils.dart';

import 'search_page_body_widget.dart';
import 'search_page_filter_widget.dart';
/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-24 16:51:53
 * @Description: 联系人搜索页
 * @FilePath: \js_oa\lib\pages\contacts\search\search_page.dart
 * @LastEditTime: 2022-01-04 16:38:30
 */

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with WidgetsBindingObserver {
  final TextEditingController _editingController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode(); //触发头部搜索框 焦点控制

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this); //注册监听器
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _showKeyBoard();
    });
  }

  @override
  void dispose() {
    _editingController.dispose();
    _searchFocusNode.dispose();
    WidgetsBinding.instance!.removeObserver(this); //移除监听器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactSearchPageController>(
        init: ContactSearchPageController(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0.5,
              automaticallyImplyLeading: false,
              title: _buildTitleSearchWidget(controller),
              actions: [
                TextButton(
                  onPressed: () {
                    _hideKeyBoard();
                  },
                  child: Text(
                    '取消  ',
                    style: TextStyle(color: JSColors.black, fontSize: 17),
                  ),
                )
              ],
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, 40),
                child: _buildBottomFilter(controller),
              ),
            ),
            body: SearchPageBodyWidget(),
          );
        });
  }

  ///构建搜索页 顶部搜索栏
  _buildTitleSearchWidget(ContactSearchPageController searchPageController) {
    _editingController.addListener(() {
      if (_editingController.text.isNotEmpty) {
        searchPageController.showCancelIcon.value = true;
      } else {
        searchPageController.showCancelIcon.value = false;
      }
      if (searchPageController.data.length > 0 ||
          _editingController.text.isNotEmpty) {
        searchPageController.requestSearchContactData(
            realName: _editingController.text);
      }
    });
    return Container(
      height: 36,
      margin: const EdgeInsets.only(top: 4),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey.withAlpha(40),
          borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(padding: const EdgeInsets.only(left: 4)),
          Icon(
            Icons.search,
            color: Colors.black45,
          ),
          Padding(padding: const EdgeInsets.only(left: 3)),
          Expanded(child: _buildTextFieldInput()),
          buildSearchClearIconWidget(searchPageController),
        ],
      ),
    );
  }

  ///构建textfield
  _buildTextFieldInput() {
    return TextField(
      onTap: () {},
      controller: _editingController,
      focusNode: _searchFocusNode,
      onSubmitted: (value) {
        if ("" == value) return;
      },
      decoration: InputDecoration(
        isCollapsed: true,
        border: InputBorder.none,
        labelStyle: TextStyle(color: JSColors.black, fontSize: 14),
        hintText: '搜索',
        hintStyle: TextStyle(color: Colors.black45, fontSize: 14),
      ),
    );
  }

  ///构建搜索页appbar底部筛选菜单
  _buildBottomFilter(ContactSearchPageController controller) {
    return SearchPageAppbarBottomFilterWidget(
      selectBuilder: (va, tag) {
        if (_searchFocusNode.hasFocus) {
          KeyBoardUtils.hideKeyBoard();
          _searchFocusNode.unfocus();
          return;
        }
        controller.showOrHideFilterWidget(va);
      },
    );
  }

  buildSearchClearIconWidget(ContactSearchPageController searchPageController) {
    return Obx(() => InkWell(
          onTap: () {
            _searchFocusNode.requestFocus();
            _editingController.clear();
          },
          child: searchPageController.showCancelIcon.value
              ? Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  child: Icon(
                    Icons.cancel,
                    size: 20,
                    color: Colors.black45,
                  ),
                )
              : SizedBox(),
        ));
  }

  _showKeyBoard() async {
    await Future.delayed(Duration(milliseconds: 175), () {
      _searchFocusNode.requestFocus();
    });
  }

  _hideKeyBoard() {
    if (!_searchFocusNode.hasFocus) {
      Get.back();
    } else {
      _searchFocusNode.unfocus();
      Future.delayed(Duration(milliseconds: 100), () {
        Get.back();
      });
    }
  }
}
