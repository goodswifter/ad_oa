import 'package:flutter/material.dart';
import 'package:js_oa/res/colors.dart';
import 'package:js_oa/widgets/verification_code_button.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-17 18:36:01
/// Description  : 验证码后缀Widget
///

class VerificationCodeSuffix extends StatelessWidget {
  VerificationCodeSuffix({
    this.clear,
    this.onTap,
    this.isShowClearButton = false,
    this.isStartTimer = false,
    this.countDownChanged,
    this.startSecond = 0,
    this.autoOpen = false,
    this.isShowBorder = false,
  });

  final bool isShowClearButton;
  final VoidCallback? clear;
  final VoidCallback? onTap;

  /// 开始倒计时秒数
  final int startSecond;

  /// 是否自动开启倒计时
  final bool autoOpen;

  /// 是否有边框
  final bool isShowBorder;

  /// 倒计时时间
  final ValueCallback? countDownChanged;

  /// 是否开始倒计时
  final bool isStartTimer;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        isShowClearButton
            ? IconButton(
                onPressed: clear,
                icon: Icon(Icons.cancel_rounded, color: Colours.bg_color),
              )
            : SizedBox(),
        VerificationCodeButton(
          isStartTimer: isStartTimer,
          onTap: onTap,
          isShowBorder: isShowBorder,
          countDownChanged: countDownChanged,
          startSecond: startSecond,
          autoOpen: autoOpen,
        ),
      ],
    );
  }
}
