import 'package:flutter/material.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-31 10:37:56
/// Description  :
///

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("错误页面"),
      ),
      body: Center(
        child: Text(
          "错误页面",
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      ),
    );
  }
}
