import 'package:flutter/material.dart';

typedef void Success<T>(int data);
// typedef ValueChanged<T> = void Function(T value);

class CustomRadio<T> extends StatefulWidget {
  final T value;
  final T groupValue; //Function(T value)
  final void Function(int value) onChanged;
  final Widget? lable;

  CustomRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    int radioSize = 18,
    required this.lable,
  }) : super(key: key);

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onChanged.call(widget.value);
      },
      child: Container(
        width: double.infinity,
        // color: index % 2 == 0 ? Colors.red : Colors.green,
        height: 45,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              widget.value == widget.groupValue
                  ? Icons.radio_button_on
                  : Icons.radio_button_off,
              color: Colors.blue,
              size: 18,
            ),
            SizedBox(
              width: 8,
            ),
            widget.lable!,
          ],
        ),
      ),
    );
  }
}
