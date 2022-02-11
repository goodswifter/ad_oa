import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:js_oa/core/constants/resource.dart';
import 'package:webview_flutter/webview_flutter.dart';

///
/// Author       : zhongaidong
/// Date         : 2022-01-11 15:08:38
/// Description  :
///

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("京师OA隐私权政策")),
      body: WebView(
        initialUrl: R.ASSETS_HTML_USER_AGREEMENT_HTML,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _controller.complete(webViewController);
          _loadHtmlFromAssets(webViewController, context);
        },
        onProgress: (int progress) {
          print('WebView is loading (progress : $progress%)');
        },
      ),
    );
  }

  Future<void> _loadHtmlFromAssets(
      WebViewController controller, BuildContext context) async {
    await controller.loadFlutterAsset(R.ASSETS_HTML_PRIVACY_POLICY_HTML);
  }
}
