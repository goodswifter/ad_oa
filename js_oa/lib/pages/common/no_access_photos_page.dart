import 'package:flutter/material.dart';
import 'package:js_oa/res/text_styles.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-25 16:03:24
/// Description  :
///

class NoAccessPhotosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(primary: Colors.green);
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 200,
            child: Column(
              children: [
                Text("无法访问相册中图片", style: TextStyles.textBold26),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  width: double.infinity,
                  child: Text(
                    "你已关闭京师OA照片访问权限，建议允许访问「所有照片」",
                    textAlign: TextAlign.center,
                    style: TextStyles.textBold18,
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            child: Container(
              width: 150,
              child: ElevatedButton(
                style: style,
                child: Text("前往系统设置", style: TextStyles.textBold18),
                onPressed: () => PhotoManager.openSetting(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
