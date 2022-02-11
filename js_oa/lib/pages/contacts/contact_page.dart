import 'package:flutter/material.dart';
import 'package:js_oa/core/theme/js_colors.dart';

import 'letter_list/index_bar_options.dart';
import 'letter_list/letter_list_widget.dart';
/*
 * @Author: 京师在线-杨昆
 * @Date: 2021-08-24 14:53:12
 * @Description: 通讯录模块
 * @FilePath: \js_oa\lib\pages\contacts\contact_page.dart
 * @LastEditTime: 2021-12-08 18:07:40
 */

class ContactPage extends StatefulWidget {
  ContactPage({Key? key}) : super(key: key);

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        title: const Text("通讯录",
            style: TextStyle(fontSize: 18, color: JSColors.black)),
        elevation: 0.1,
        centerTitle: true,
      ),
      body: LetterListView(option: IndexBarOption()),
    );
  }
}
