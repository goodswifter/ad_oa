import 'dart:async';

import 'package:flutter/material.dart';
import 'package:js_oa/res/text_styles.dart';

// typedef void StartTimer({bool isStartTimer});
typedef ValueCallback = void Function(int second);

class VerificationCodeButton extends StatefulWidget {
  VerificationCodeButton({
    this.totalSeconds = 60,
    this.startSecond = 0,
    this.autoOpen = false,
    this.isShowBorder = true,
    this.onTap,
    this.isStartTimer = false,
    this.countDownChanged,
  });

  /// 倒计时总秒数
  final int totalSeconds;

  /// 开始倒计时秒数
  final int startSecond;

  /// 是否自动开启倒计时
  final bool autoOpen;

  /// 是否有边框
  final bool isShowBorder;

  /// 点击获取验证码按钮
  final VoidCallback? onTap;

  /// 倒计时时间
  final ValueCallback? countDownChanged;

  /// 是否开始倒计时
  final bool isStartTimer;

  @override
  _VerificationCodeButtonState createState() => _VerificationCodeButtonState();
}

class _VerificationCodeButtonState extends State<VerificationCodeButton> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.autoOpen ||
        (widget.startSecond > 0 && widget.startSecond < widget.totalSeconds))
      startTimer();
  }

  String btnTitle = "获取验证码";
  bool btnEnable = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      child: OutlinedButton(
        child: Text(btnTitle),
        onPressed: btnEnable
            ? () {
                widget.onTap?.call();
                if (widget.isStartTimer) startTimer();
              }
            : null,
        style: OutlinedButton.styleFrom(
          textStyle: TextStyles.textSize14,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          side: BorderSide(
              color: widget.isShowBorder ? Colors.blue : Colors.transparent,
              width: .5),
        ),
      ),
    );
  }

  void startTimer() {
    int timerNum = widget.totalSeconds;
    if (widget.startSecond > 0 && widget.startSecond < widget.totalSeconds) {
      timerNum = widget.startSecond;
    }
    btnEnable = false;
    btnTitle = "$timerNum\s后重新发送";
    setState(() {});

    // 间隔1秒执行时间
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // 间隔1秒执行一次 每次减1
      btnTitle = "${--timerNum}s后重新发送";
      widget.countDownChanged?.call(timerNum);
      // 如果计完成取消定时
      if (timerNum <= 0) {
        timer.cancel();
        btnEnable = true;
        btnTitle = "重发验证码";
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
