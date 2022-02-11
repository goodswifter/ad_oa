import 'package:flutter/material.dart';
import 'package:js_oa/utils/other/text_util.dart';
import 'package:js_oa/widgets/text_field/obscure_text_suffix.dart';
import 'package:js_oa/res/text_styles.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-17 15:18:55
/// Description  :
///

class TitlePwdTextField extends StatefulWidget {
  TitlePwdTextField({
    this.onChanged,
    this.hintText = "请输入密码",
    this.title,
  });

  /// 输入框值发生变化时触发
  final ValueChanged<String>? onChanged;

  /// 占位符
  final String hintText;

  /// 标题
  final String? title;

  @override
  State<TitlePwdTextField> createState() => _TitlePwdTextFieldState();
}

class _TitlePwdTextFieldState extends State<TitlePwdTextField> {
  bool _obscureText = true;
  bool _isShowClearButton = false;
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
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
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        focusNode: _focusNode,
        controller: _controller,
        style: TextStyles.textSize18,
        onChanged: (value) {
          widget.onChanged?.call(value);
          _isShowClearButton = value.length > 0;
          setState(() {});
        },
        keyboardType: TextInputType.emailAddress,
        maxLength: 20,
        obscureText: _obscureText,
        obscuringCharacter: "*",
        decoration: InputDecoration(
          prefixIcon: TextUtil.isNotEmpty(widget.title)
              ? Container(
                  width: 80,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title!,
                    textAlign: TextAlign.center,
                  ),
                )
              : null,
          hintText: widget.hintText,
          counterText: "",
          suffixIcon: ObscureTextSuffix(
            isShowClearButton: _isShowClearButton,
            clear: () {
              _controller.clear();
              widget.onChanged?.call("");
              _isShowClearButton = false;
              setState(() {});
            },
            obscureTextPressed: (obscureText) {
              _obscureText = obscureText;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
