import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/theme/js_colors.dart';

typedef CheckboxOnChanged(bool value);

class UserProtocolWidget extends StatefulWidget {
  const UserProtocolWidget({Key? key, this.onChanged}) : super(key: key);
  final CheckboxOnChanged? onChanged;

  @override
  _UserProtocolWidgetState createState() => _UserProtocolWidgetState();
}

class _UserProtocolWidgetState extends State<UserProtocolWidget> {
  // 维护复选框状态
  bool _checkboxSelected = false;
  late TapGestureRecognizer _registProtocolRecognizer;
  late TapGestureRecognizer _privacyProtocolRecognizer;
  // 协议说明文案
  String userPrivateProtocol = "我已阅读并同意";

  /// 生命周期函数 页面创建时执行一次
  @override
  void initState() {
    super.initState();
    // 注册协议的手势
    _registProtocolRecognizer = TapGestureRecognizer();
    // 隐私协议的手势
    _privacyProtocolRecognizer = TapGestureRecognizer();
  }

  /// 生命周期函数 页面销毁时执行一次
  @override
  void dispose() {
    super.dispose();

    // 销毁
    _registProtocolRecognizer.dispose();
    _privacyProtocolRecognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          buildCheckbox(),
          buildRichText(),
        ],
      ),
    );
  }

  buildCheckbox() {
    return Checkbox(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4))),
      value: _checkboxSelected,
      activeColor: Colors.blue, // 选中时的颜色
      side: BorderSide(color: JSColors.grey),
      onChanged: (value) {
        widget.onChanged?.call(value!);
        setState(() {
          _checkboxSelected = value!;
        });
      },
    );
  }

  /// 构建富文本
  RichText buildRichText() {
    return RichText(
      textAlign: TextAlign.center, // 文字居中
      // 文字区域
      text: TextSpan(
        text: "我已阅读并同意",
        style: TextStyle(color: Colors.grey),
        children: [
          TextSpan(
            text: "《用户协议》",
            style: TextStyle(color: Colors.blue),
            // 点击事件
            recognizer: _registProtocolRecognizer
              ..onTap = () {
                // 打开用户协议
                // openUserProtocol();
                Get.toNamed(AppRoutes.userProtocol);
              },
          ),
          TextSpan(
            text: "《隐私权政策》",
            style: TextStyle(color: Colors.blue),
            // 点击事件
            recognizer: _privacyProtocolRecognizer
              ..onTap = () {
                // 打开隐私协议
                // openPrivateProtocol();
                print("隐私协议");
                Get.toNamed(AppRoutes.privacyPolicy);
              },
          ),
        ],
      ),
    );
  }
}
