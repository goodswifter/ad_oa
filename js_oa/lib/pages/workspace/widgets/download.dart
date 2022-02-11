import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Download {
  Dio dio = Dio();
  // Function(int, int)? callback;
  // 申请权限
  Future<bool> checkPermission() async {
    // 先对所在平台进行判断
    Permission permission = Permission.storage;
    final status = await permission.request();
    switch (status) {
      case PermissionStatus.denied:
      case PermissionStatus.limited:
        ToastUtil.showToast("没有文件读写权限");
        return false;
      case PermissionStatus.granted:
        return true;
      default:
        return false;
    }
  }

  // 获取存储路径
  Future<String> _findLocalPath() async {
    // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
    // 如果是android，使用getExternalStorageDirectory
    // 如果是iOS，使用getApplicationSupportDirectory
    final directory = GetPlatform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationSupportDirectory();
    return directory!.path;
  }

  // 执行下载文件的操作
  doDownloadOperation(downloadUrl, {Function(int, int)? callback}) async {
    /**
     * 下载文件的步骤：
     * 1. 获取权限：网络权限、存储权限
     * 2. 获取下载路径
     * 3. 设置下载回调
     */

    // 获取权限
    var isPermissionReady = await checkPermission();
    if (isPermissionReady) {
      String dirloc = "";
      if (Platform.isAndroid) {
        // dirloc = "/sdcard/download/";
        // 获取存储路径
        dirloc = (await _findLocalPath()) + '/Download';
        final savedDir = Directory(dirloc);
        // 判断下载路径是否存在
        bool hasExisted = await savedDir.exists();
        //不存在就新建路径
        if (!hasExisted) {
          savedDir.create();
        }
      } else {
        dirloc = (await getTemporaryDirectory()).path;
        dirloc = dirloc.replaceFirst("Library/Caches", "Documents/");
      }

      // 下载链接
      //http://barbra-coco.dyndns.org/student/learning_android_studio.pdf
      String downloadUrl =
          "https://downsc.chinaz.net/Files/DownLoad/pic9/202111/bpic24664.rar";
      // 下载
      // downloadFile(downloadUrl, dirloc);
      downloadFile(downloadUrl, dirloc, callback: callback);
    } else {
      // showToast("您还没有获取权限");
      print("您还没有获取权限");
    }
  }

  //根据 downloadUrl 和 savePath 下载文件
  void downloadFile(
    downloadUrl,
    savePath, {
    Function(int, int)? callback,
  }) async {
    await dio.download(downloadUrl, savePath + "/" + DateTime.now().toString(),
        onReceiveProgress: callback);
    // await dio.download(downloadUrl, savePath + "/" + DateTime.now().toString(),
    //     onReceiveProgress: (receivedBytes, totalBytes) {
    //   callback!(receivedBytes, totalBytes);
    //   print(((receivedBytes / totalBytes) * 100).toStringAsFixed(0));
    // });
  }
}
