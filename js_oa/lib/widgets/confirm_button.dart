import 'package:flutter/material.dart';
import 'package:js_oa/res/colors.dart';
import 'package:js_oa/res/dimens.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-31 16:27:38
/// Description  :
///

class ConfirmButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  ConfirmButton({this.title = "确定", this.onPressed});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return Theme.of(context).colorScheme.primary.withOpacity(0.5);
          else if (states.contains(MaterialState.disabled))
            return Colours.button_normal.withOpacity(0.5);
          return Theme.of(context)
              .colorScheme
              .primary; // Use the component's default.
        },
      ),
    );
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: 42,
      child: ElevatedButton(
          onPressed: onPressed,
          style: buttonStyle,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp18),
          )),
    );
  }
}
