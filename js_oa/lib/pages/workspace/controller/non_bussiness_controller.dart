import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_indata.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_service.dart';
import 'package:js_oa/utils/other/toast_util.dart';

class NonBusinessController extends GetxController {
  var chooseImages = [].obs;
  List<NonBusinessContractImages> chooseImagesUrl = [];

  WorkSpaceService workSpaceService = WorkSpaceService();
  CreateNonBusinessContractIndata indata = CreateNonBusinessContractIndata();
  TextEditingController usesController = TextEditingController();
  TextEditingController recipientsController = TextEditingController();

  void createNonBusiness({
    Function(bool)? successCallBack,
  }) {
    workSpaceService.postNonBusinessContractCreate(
        nonBusines: indata,
        success: (value) {
          successCallBack!(value);
        },
        failure: (error) {
          ToastUtil.showToast(error.message);
        });
  }

  bool checkInfo() {
    if (usesController.text.isEmpty) {
      ToastUtil.showToast("请选填写用途");
      return false;
    } else {
      indata.purpose = usesController.text;
    }

    if (recipientsController.text.isEmpty) {
      ToastUtil.showToast("请选填写接收方");
      return false;
    } else {
      indata.receiver = recipientsController.text;
    }

    if (chooseImagesUrl.length == 0) {
      ToastUtil.showToast("请上传附件");
      return false;
    } else {
      indata.files = chooseImagesUrl;
    }
    return true;
  }
}
