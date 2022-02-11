import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';

class ContractSearchBar extends StatefulWidget {
  final Function(String searchText)? onSubmitted;
  final Function()? clear;
  ContractSearchBar({Key? key, this.onSubmitted, this.clear}) : super(key: key);

  @override
  _ContractSearchBarState createState() => _ContractSearchBarState();
}

class _ContractSearchBarState extends State<ContractSearchBar> {
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
      width: double.infinity,
      child: Container(
        margin: EdgeInsets.fromLTRB(12, 7, 12, 7),
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
              color: Colors.black45,
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
          ),
          textInputAction: TextInputAction.search,
          focusNode: searchNode,
          controller: searchTextEditController,
          onTap: () {
            setState(() {});
          },
          onSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }
}
