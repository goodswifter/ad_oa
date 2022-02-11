/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-24 10:13:43
 * @Description: 
 * @FilePath: \js_oa\lib\pages\workspace\approve\approve_search_bar.dart
 * @LastEditTime: 2021-09-01 16:19:40
 */
import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';

class ApproveSearchBar extends StatefulWidget {
  final Function()? onSelectTap;
  final Function()? onFocus;
  final Function(String searchText)? onSubmitted;
  final Function()? clear;
  ApproveSearchBar(
      {Key? key, this.onSelectTap, this.onFocus, this.onSubmitted, this.clear})
      : super(key: key);

  @override
  _ApproveSearchBarState createState() => _ApproveSearchBarState();
}

class _ApproveSearchBarState extends State<ApproveSearchBar> {
  bool ishow = false;
  final FocusNode searchNode = FocusNode();
  final TextEditingController searchTextEditController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    searchNode.addListener(() {
      setState(() {});
    });
    return Container(
      height: 50,
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(width: 12),
          Expanded(
            child: Container(
              // color: Colors.yellow,
              margin: EdgeInsets.fromLTRB(0, 7, 0, 7),
              // height: 40,
              decoration: BoxDecoration(
                //背景
                color: Colors.grey.withAlpha(40),
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(18.0)),
                //设置四周边框
                // border: new Border.all(width: 1, color: Colors.red),
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: JSColors.black, fontSize: 14),
                  hintText: '搜索',
                  hintStyle: TextStyle(color: Colors.black45, fontSize: 14),
                  border: InputBorder.none,
                  prefixIcon: Icon(
                    Icons.search,
                    size: 20,
                  ),
                  suffixIcon: searchNode.hasFocus
                      ? IconButton(
                          onPressed: () {
                            // SystemChannels.textInput.invokeMethod("TextInput.hide");
                            searchNode.unfocus();
                            searchTextEditController.clear();
                            widget.clear!();
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: Colors.black45,
                            size: 20,
                          ))
                      : null,
                  // contentPadding: const EdgeInsets.fromLTRB(20, 2, 0, 0),
                  // hintStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                ),
                textInputAction: TextInputAction.search,
                focusNode: searchNode,
                controller: searchTextEditController,
                onTap: widget.onFocus,
                onSubmitted: widget.onSubmitted,
              ),
            ),
          ),
          SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              searchNode.unfocus();
              widget.onSelectTap!();
            },
            child: Container(
              width: 92,
              height: 34,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(45)),
                  border: Border.all(color: Colors.grey.shade300)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.subject),
                  SizedBox(width: 8),
                  Text("筛选"),
                ],
              ),
            ),
          ),
          SizedBox(width: 12),
        ],
      ),
    );
  }
}
