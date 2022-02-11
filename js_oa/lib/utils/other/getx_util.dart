import 'package:get/get.dart';
import 'package:js_oa/controller/login/login_controller.dart';
import 'package:js_oa/entity/login/token_entity.dart';
import 'package:js_oa/service/login/login_request.dart';
import 'package:js_oa/utils/easyloading/flutter_easyloading.dart';
import 'package:js_oa/utils/http/dio_new.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter/foundation.dart';

///
/// Author       : zhongaidong
/// Date         : 2021-09-22 09:39:21
/// Description  :
///

class GetXUtil {
  static void init() {
    final loginCtrl = Get.put(LoginController());

    // 全局拦截器
    Interceptor inters = InterceptorsWrapper(
      onRequest: (options, handler) async {
        Map headers = options.headers;
        dynamic loginResp = SpUtil.getObject(kLoginToken);
        if (loginResp != null) {
          headers["Authorization"] = "Bearer ${loginResp["accessToken"]}";
          headers["X-Authorization"] = "Bearer ${loginResp["refreshToken"]}";
        }
        handler.next(options);
      },
      onResponse: (response, handler) async {
        Headers headers = response.headers;
        String? accessToken = headers.value("access-token");
        String? refreshToken = headers.value("x-access-token");
        if (accessToken != null) {
          TokenEntity token = TokenEntity(
            accessToken: accessToken,
            refreshToken: refreshToken,
          );
          SpUtil.putObject(kLoginToken, token);
        }
        return handler.resolve(response);
      },
      onError: (err, handler) async {
        EasyLoading.showError(err.error.toString());
        // await EasyLoading.dismiss();
        if (err.response != null && err.response!.statusCode == 401)
          loginCtrl.logout();
        return handler.reject(err);
      },
    );
    // String devUrl = "http://192.168.52.56:18080";
    String devUrl = "http://api.oa.dev.jingshonline.net";
    String releaseUrl = "http://api.oa.dev.jingshonline.net";
    String baseUrl = kDebugMode ? devUrl : releaseUrl;
    HttpConfig dioConfig = HttpConfig(
      baseUrl: baseUrl,
      // proxy: "192.168.27.2:8888",
      // proxy: "192.168.16.181:8888",
      // proxy: "192.168.28.59:8888",
      interceptors: [inters],
    );
    HttpClient client = HttpClient(dioConfig: dioConfig);
    Get.put<HttpClient>(client);
  }
}
