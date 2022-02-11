import 'package:flutter/material.dart';
import 'package:flutter_bugly/flutter_bugly.dart';
import 'package:get/get.dart';
import 'package:js_oa/core/layout/size_fit.dart';
import 'package:js_oa/core/router/app_pages.dart';
import 'package:js_oa/core/router/unknown_page.dart';
import 'package:js_oa/core/theme/app_theme.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:sp_util/sp_util.dart';

import 'im/im_init.dart';
import 'service/login/login_request.dart';
import 'utils/other/getx_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  JSSizeFit.initialize();
  await SpUtil.getInstance();

  FlutterBugly.postCatchedException(() {
    runApp(MyApp());
    FlutterBugly.init(
      androidAppId: "c878522d8d",
      iOSAppId: "f2861d1e25",
    );
  }, debugUpload: true);
  // runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.dark
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 初始化GetX
    GetXUtil.init();
    Map? tokenMap = SpUtil.getObject(kLoginToken);
    String initialRoute = tokenMap != null ? AppRoutes.main : AppRoutes.initial;
    return GetMaterialApp(
      onInit: () => TencentIMInitSdk(),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      theme: appThemeData,
      initialRoute: initialRoute,
      getPages: AppPages.pages,
      unknownRoute: GetPage(name: AppRoutes.unknown, page: () => UnknownPage()),
      builder: EasyLoading.init(builder: (context, child) {
        child = GestureDetector(
          onTap: () => hideKeyboard(context),
          child: MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaleFactor: 1.0), // 设置文字大小不随系统设置改变
            child: child!,
          ),
        );
        return child;
      }),
    );
  }

  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus!.unfocus();
    }
  }
}
