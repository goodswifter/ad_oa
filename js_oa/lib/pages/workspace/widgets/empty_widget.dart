import 'package:flutter/cupertino.dart';
import 'package:js_oa/core/constants/resource.dart';

class EmptyWidget {
  static Widget noData() {
    return Center(
      child: Image.asset(
        R.ASSETS_IMAGES_WORKSPACE_NO_DATA_PNG,
        width: 150,
        height: 150,
      ),
    );
  }
}
