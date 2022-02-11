import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/core/extension/other_extension.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/entity/login/user_entity.dart';
import 'package:js_oa/pages/mine/mine_person_info/widget/person_info_avatar_widget.dart';
import 'package:js_oa/pages/mine/mine_person_info/widget/person_info_list_tile_item.dart';
import 'package:js_oa/res/gaps.dart';
import 'package:js_oa/service/mine/user_request.dart';
import 'package:js_oa/widgets/alert_sheet/action_sheet_widget.dart';
import 'package:js_oa/widgets/confirm_button.dart';
import 'package:js_oa/core/extension/string_extension.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-08-23 15:00:57
/// Description  :
///

class PersonInfoPage extends StatelessWidget {
  final LoginController _loginCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("个人信息")),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Obx(() {
            UserEntity user = _loginCtrl.userinfo();
            String? realName = user.realName;
            bool sex = user.sex;
            String sexStr = "女";
            sexStr = sex ? Sex.man.value : Sex.woman.value;
            return Column(
              children: [
                PersonInfoAvatarWidget(), // 头像
                PersonInfoListTileItem(
                  title: "姓名",
                  trailing: realName,
                  onTap: () async {
                    await Get.toNamed(
                      AppRoutes.changeName,
                      arguments: realName,
                    );
                  },
                ), // 姓名
                PersonInfoListTileItem(
                  title: "性别",
                  trailing: sexStr,
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (ctx) => ActionSheetWidget(
                        actionTitles: [Sex.man.value, Sex.woman.value],
                        onPressed: (ctx, index) {
                          Get.back();
                          if ((sex && index == 0) || (!sex && index == 1))
                            return;
                          UserRequest.modifySex(sex: index == 0);
                        },
                      ),
                    );
                  },
                ), // 性别
                PersonInfoListTileItem(
                  title: "执业证号",
                  trailing: user.licenseNumber.nullSafe,
                  isShowArrow: false,
                ), // 执业证号
                // PersonInfoListTileItem(
                //   title: "执业机构",
                //   trailing: "京师律师事务所",
                //   isShowArrow: false,
                // ), // 执业机构
                // PersonInfoListTileItem(
                //   title: "所在区域",
                //   trailing: "北京市-朝阳区",
                //   isShowArrow: false,
                // ), // 所在区域
                Gaps.vGap24,
                ConfirmButton(
                  title: "退出",
                  onPressed: () {
                    _loginCtrl.logout();
                  },
                ),
              ],
            );
          }),
        ));
  }
}
