import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/core/constants/resource.dart';
import 'package:js_oa/core/extension/string_extension.dart';
import 'package:js_oa/core/layout/layout_extension.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/entity/login/user_entity.dart';
import 'package:js_oa/pages/mine/mine_list_item.dart';
import 'package:js_oa/res/images.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/utils/other/text_util.dart';
import 'package:js_oa/widgets/alert_sheet/alert_dialog_widget.dart';
import 'package:js_oa/widgets/load_image.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-07-23 15:19:58
/// Description  :
///

class MinePage extends StatelessWidget {
  final LoginController _loginCtrl = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      UserEntity user = _loginCtrl.userinfo();
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: personInfoWidget(user),
          // title: ListTile(
          //   leading: ClipRRect(
          //       borderRadius: BorderRadius.all(Radius.circular(4)),
          //       child: LoadImage(
          //         user.avatar.nullSafe,
          //         width: 67,
          //         height: 67,
          //         fit: BoxFit.cover,
          //       )),
          //   title: Padding(
          //     padding: EdgeInsets.only(bottom: 5.px),
          //     child: Text(
          //       user.realName ?? user.phoneNumber ?? user.userName!,
          //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          //     ),
          //   ),
          //   subtitle: Text(
          //     user.organName,
          //     style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          //   ),
          //   trailing: Images.arrowRight,
          //   onTap: () => Get.toNamed(AppRoutes.personInfo),
          // ),
          toolbarHeight: 141,
          titleSpacing: 0,
        ),
        body: listWidget(context, user),
      );
    });
  }

  // final List<String> titles = ["修改密码", "修改手机", "修改邮箱"];
  final List<String> titles = ["修改密码", "修改手机"];
  final List<String> routes = [
    AppRoutes.pwdChange,
    AppRoutes.phoneChange,
    AppRoutes.pwdChange,
  ];

  final List<IconData> leadIcons = [
    Icons.lock_outline,
    Icons.phone_iphone_sharp,
    Icons.mail_outline
  ];

  Widget listWidget(BuildContext context, UserEntity user) {
    // bool isBindMail = false;
    final List<String> subtitles = [
      "",
      user.phoneNumber.isEmptyOrNull
          ? "未绑定"
          : TextUtil.hideNumber(user.phoneNumber!),
      user.email.isEmptyOrNull ? "未绑定" : user.email!,
    ];
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: titles.length,
        itemBuilder: (_, int index) {
          MineListItem? listItem;
          switch (index) {
            case 0: // 修改密码
              listItem = MineListItem(
                title: titles[index],
                leadIcon: leadIcons[index],
                route: routes[index],
              );
              break;
            case 1: // 修改手机
              listItem = MineListItem(
                title: titles[index],
                leadIcon: leadIcons[index],
                route: routes[index],
                subTitle: subtitles[index],
              );
              break;
            case 2: // 修改邮箱
              listItem = MineListItem(
                title: titles[index],
                leadIcon: leadIcons[index],
                route: routes[index],
                subTitle: subtitles[index],
                onTap: () async {
                  EasyLoading.showInfo("该功能正在开发中...");
                  // Get.toNamed(AppRoutes.bindMail);
                  // if (isBindMail) {
                  // showCupertinoModalPopup(
                  //   context: context,
                  //   builder: (ctx) => ActionSheetWidget(
                  //     title: "邮箱",
                  //     actionTitles: ["替换", "解绑"],
                  //     onPressed: (ctx, index) {
                  //       Get.back();
                  //       print(index);
                  //       if (index == 1) isUnbindMail(context);
                  //     },
                  //   ),
                  // );
                  // } else {
                  //   Get.toNamed(AppRoutes.mail);
                  // }
                },
              );
              break;
          }
          return listItem!;
        },
      ),
    );
  }

  /// 是否解绑邮箱
  Future<void> isUnbindMail(BuildContext context) async {
    await showCupertinoDialog(
      context: context,
      builder: (ctx) => AlertDialogWidget(
        title: "是否解绑该账号?",
        confirmTitle: "解绑",
        confirmPressed: () => print("解绑成功"),
      ),
    );
  }

  Widget personInfoWidget(UserEntity user) {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      // height: 141.px,
      child: ListTile(
        leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: LoadImage(
              user.avatar.nullSafe,
              width: 67,
              height: 67,
              fit: BoxFit.cover,
            )),
        title: Padding(
          padding: EdgeInsets.only(bottom: 5.px),
          child: Text(
            user.realName ?? user.phoneNumber ?? user.userName!,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Text(
          user.organName,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        trailing: Images.arrowRight,
        onTap: () => Get.toNamed(AppRoutes.personInfo),
      ),
    );
  }

  loadImage1(String imageName) {
    final Widget _image = LoadAssetImage(
        R.ASSETS_IMAGES_MINE_ME_DEFAULT_ICON_PNG,
        height: 67,
        width: 67,
        fit: BoxFit.cover);

    return CachedNetworkImage(
      imageUrl: imageName,
      // imageBuilder: (context, imageProvider) => Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //       image: imageProvider,
      //     ),
      //   ),
      // ),
      placeholder: (_, __) => _image,
      errorWidget: (_, __, dynamic error) => _image,
      width: 67,
      height: 67,
      fit: BoxFit.cover,
    );
  }
}
