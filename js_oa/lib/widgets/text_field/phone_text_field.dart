import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:js_oa/pages/workspace/widgets/mask_text_input_formatter.dart';
import 'package:js_oa/res/antd_icons.dart';
import 'package:js_oa/res/colors.dart';
import 'package:js_oa/res/text_styles.dart';
import 'package:js_oa/utils/other/regex_util.dart';
import 'package:js_oa/utils/other/text_util.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-17 15:18:55
/// Description  :
///

class PhoneTextField extends StatefulWidget {
  PhoneTextField({
    this.onChanged,
    this.isShowError = false,
    this.errorTip = "",
    this.defaultText,
    this.hintText = "请输入手机号",
    this.autofocus = false,
  });

  /// 输入框值发生变化时触发
  final ValueChanged<String>? onChanged;

  /// 是否显示错误提示
  final bool isShowError;

  /// 是否错误
  final String errorTip;

  /// 输入框默认值
  final String? defaultText;

  /// 占位符
  final String hintText;

  /// 是否自动获取焦点
  final bool autofocus;

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  TextInputFormatter _textInputFormatter =
      MaskTextInputFormatter(mask: "### #### ####");
  bool _isShowClearButton = false;
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  // 默认手机号是否正确
  bool isDefaultTextSuccess = false;
  @override
  void initState() {
    super.initState();

    isDefaultTextSuccess = RegexUtil.isPhone(widget.defaultText);

    if (TextUtil.isNotEmpty(widget.defaultText)) {
      String defaultText = widget.defaultText!;
      defaultText = defaultText.substring(0, 11);
      defaultText = TextUtil.formatPhone(defaultText);
      _controller.text = defaultText;
    }

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
        autofocus: widget.autofocus,
        onChanged: (text) {
          isDefaultTextSuccess = false;
          widget.onChanged?.call(TextUtil.allTrim(text));
          _isShowClearButton = text.length > 0;
          setState(() {});
        },
        inputFormatters: [_textInputFormatter],
        keyboardType: TextInputType.number,
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
