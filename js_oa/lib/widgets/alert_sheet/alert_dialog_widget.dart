import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:js_oa/res/text_styles.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-05-07 09:59:35
/// Description  : 苹果风格
///

class AlertDialogWidget extends StatelessWidget {
  final String? title;
  final String? content;
  final String confirmTitle;
  final VoidCallback? confirmPressed;

  AlertDialogWidget({
    this.title,
    this.content,
    this.confirmTitle = "确定",
    this.confirmPressed,
  });

  @override
  Widget build(BuildContext context) {
    CupertinoDialogAction cancelAction = CupertinoDialogAction(
      child: Text("取消"),
      textStyle: TextStyles.textGray14,
      onPressed: () => Get.back(),
    );

    CupertinoDialogAction confirmAction = CupertinoDialogAction(
      child: Text(confirmTitle),
      onPressed: () {
        Get.back();
        confirmPressed?.call();
      },
    );
    return CupertinoAlertDialog(
      title: title != null ? Text(title!) : null,
      content: content != null ? Text(content!) : null,
      actions: [cancelAction, confirmAction],
    );
  }
}
