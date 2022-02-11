import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_oa/res/antd_icons.dart';
import 'package:js_oa/res/colors.dart';
import 'package:js_oa/res/text_styles.dart';
import 'package:js_oa/utils/other/text_util.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-18 14:25:18
/// Description  :
///

class AccountIconTextField extends StatefulWidget {
  AccountIconTextField({
    this.onChanged,
    this.isShowError = false,
    this.errorTip = "",
    this.defaultText,
    this.hintText = "请输入账号或手机号",
    this.inputFormatter,
    this.maxLength = 30,
    this.autofocus = false,
    this.height = 48,
  });

  /// 输入框值发生变化时触发
  final ValueChanged<String>? onChanged;

  /// 是否显示错误提示
  final bool isShowError;

  /// 是否错误
  final String errorTip;

  /// 输入框默认值
  final String? defaultText;

  /// 输入框占位符
  final String hintText;

  /// 最大长度
  final int maxLength;

  /// 高度
  final double height;

  final bool autofocus;

  /// 输入框格式
  final TextInputFormatter? inputFormatter;

  @override
  State<AccountIconTextField> createState() => _AccountIconTextFieldState();
}

class _AccountIconTextFieldState extends State<AccountIconTextField> {
  bool _isShowClearButton = false;
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  // 默认手机号是否正确
  bool isDefaultTextSuccess = false;
  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      _isShowClearButton = _focusNode.hasFocus && _controller.text.length > 0;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        autofocus: widget.autofocus,
        focusNode: _focusNode,
        controller: _controller,
        style: TextStyles.textSize18,
        onChanged: (text) {
          isDefaultTextSuccess = false;
          widget.onChanged?.call(TextUtil.allTrim(text));
          _isShowClearButton = text.length > 0;
          setState(() {});
        },
        inputFormatters:
            widget.inputFormatter == null ? [] : [widget.inputFormatter!],
        maxLength: widget.maxLength,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Container(
            width: 30,
            alignment: Alignment.centerLeft,
            child: Icon(AntdIcons.person),
          ),
          hintText: widget.hintText,
          counterText: "",
          suffixIcon: _isShowClearButton ? buildClearButton() : null,
          errorText: widget.isShowError && !isDefaultTextSuccess
              ? widget.errorTip
              : null,
        ),
      ),
    );
  }

  Widget buildClearButton() {
    return IconButton(
      onPressed: () {
        _controller.clear();
        widget.onChanged?.call("");
        _isShowClearButton = false;
        setState(() {});
      },
      icon: Icon(Icons.cancel_rounded, color: Colours.bg_color),
    );
  }
}
