import 'package:flutter/material.dart';
import 'package:js_oa/res/colors.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-18 15:07:05
/// Description  :
///

class ObscureTextSuffix extends StatefulWidget {
  ObscureTextSuffix({
    this.clear,
    this.obscureTextPressed,
    this.isShowClearButton = false,
  });

  final bool isShowClearButton;
  final void Function()? clear;
  final void Function(bool obscureText)? obscureTextPressed;

  @override
  State<ObscureTextSuffix> createState() => _ObscureTextSuffixState();
}

class _ObscureTextSuffixState extends State<ObscureTextSuffix> {
  late bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        widget.isShowClearButton
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: widget.clear,
                icon: Icon(Icons.cancel_rounded, color: Colours.bg_color),
              )
            : SizedBox(),
        IconButton(
          onPressed: () {
            _obscureText = !_obscureText;
            widget.obscureTextPressed?.call(_obscureText);
            setState(() {});
          },
          icon: _obscureText
              ? Icon(Icons.visibility_off, color: Colours.bg_color)
              : Icon(Icons.visibility, color: Colours.bg_color),
        ),
      ],
    );
  }
}
