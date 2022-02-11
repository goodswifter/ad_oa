import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_indata.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_service.dart';
import 'package:js_oa/pages/workspace/entity/approve_list_entity.dart';
import 'package:js_oa/utils/other/toast_util.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ApproveController extends GetxController {
  List<ApproveItem> data = [];
  WorkSpaceApproveIndata indata = WorkSpaceApproveIndata();
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  WorkSpaceService workSpaceService = WorkSpaceService();

  void getWorkflowtPagedList({
    Function(List<ApproveItem> data)? successCallBack,
  }) {
    workSpaceService.getWorkflowtGetPagedList(
      query: indata,
      success: (ca) {
        successCallBack!((ca as ApproveListEntity).items!);
        indata.pageIndex++;
      },
      failure: (exception) {
        print(exception.message);
      },
    );
  }

  void revokeWorkFlow({
    String? flowId,
    Function(bool isSuccess)? successCallBack,
  }) {
    workSpaceService.postWorkflowRevokeWork(
        id: flowId,
        success: (value) {
          successCallBack!(value);
        },
        failure: (error) {
          ToastUtil.showToast(error.message);
        });
  }

  void load() {
    data.clear();
    indata.pageIndex = 1;
    configIndata();
    loadData();
  }

  void loadData() {
    getWorkflowtPagedList(
      successCallBack: (value) {
        refreshController.loadComplete();
        refreshController.refreshCompleted();
        if (value.length == 0) {
          refreshController.loadNoData();
        }
        indata.pageIndex++;
        data.addAll(value);
        update();
      },
    );
  }

  void configIndata() {
    switch (indata.approveStatus) {
      case "审批通过":
        indata.approveStatus = "1";
        break;
      case "审批拒绝":
        indata.approveStatus = "2";
        break;
      case "已撤销":
        indata.approveStatus = "3";
        break;
      default:
        indata.approveStatus = "";
    }
    switch (indata.code) {
      case "缴费":
        indata.code = "Payment";
        break;
      case "开票":
        indata.code = "Invoice";
        break;
      case "退款":
        indata.code = "";
        break;
      default:
        indata.code = "";
    }
  }
}
