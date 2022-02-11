import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_oa/widgets/text_field/verification_code_suffix.dart';
import 'package:js_oa/res/antd_icons.dart';
import 'package:js_oa/res/text_styles.dart';
import 'package:js_oa/widgets/verification_code_button.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-17 15:18:55
/// Description  :
///

class VerificationCodeTextField extends StatefulWidget {
  VerificationCodeTextField({
    this.onChanged,
    this.verificationCodePressed,
    this.isStartTimer = true,
    this.isShowError = false,
    this.errorTip = "1111",
    this.countDownChanged,
    this.startSecond = 0,
    this.autoOpen = false,
    this.isShowBorder = true,
  });

  /// 输入框值发生变化时触发
  final ValueChanged<String>? onChanged;

  /// 倒计时时间
  final ValueCallback? countDownChanged;

  /// 点击获取验证码
  final VoidCallback? verificationCodePressed;

  /// 开始倒计时秒数
  final int startSecond;

  /// 是否自动开启倒计时
  final bool autoOpen;

  /// 是否有边框
  final bool isShowBorder;

  /// 点击开始倒计时
  final bool isStartTimer;

  /// 是否错误
  final bool isShowError;

  /// 是否错误
  final String errorTip;

  @override
  State<VerificationCodeTextField> createState() =>
      _VerificationCodeTextFieldState();
}

class _VerificationCodeTextFieldState extends State<VerificationCodeTextField> {
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
        keyboardType: TextInputType.number,
        maxLength: 6,
        inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'\d+'))],
        decoration: InputDecoration(
          prefixIcon: Container(
            width: 30,
            alignment: Alignment.centerLeft,
            child: Icon(AntdIcons.verificationCode),
          ),
          hintText: "请输入验证码",
          counterText: "",
          errorText: widget.isShowError ? widget.errorTip : null,
          suffixIcon: VerificationCodeSuffix(
            isStartTimer: widget.isStartTimer,
            isShowClearButton: _isShowClearButton,
            countDownChanged: widget.countDownChanged,
            isShowBorder: widget.isShowBorder,
            startSecond: widget.startSecond,
            autoOpen: widget.autoOpen,
            clear: () {
              _controller.clear();
              widget.onChanged?.call("");
              _isShowClearButton = false;
              setState(() {});
            },
            onTap: () => widget.verificationCodePressed?.call(),
          ),
        ),
      ),
    );
  }
}
