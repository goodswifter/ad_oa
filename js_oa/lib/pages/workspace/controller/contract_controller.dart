import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_indata.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_service.dart';
import 'package:js_oa/pages/workspace/entity/contract_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContractController extends GetxController {
  List<ContractItem> contractData = [];
  List<dynamic> recordData = [];

  RefreshController contractRefreshController =
      RefreshController(initialRefresh: false);
  RefreshController recordRefreshController =
      RefreshController(initialRefresh: false);
  WorkSpaceService workSpaceService = WorkSpaceService();

  ContractListIndata contractIndata = ContractListIndata();
  InvoiceListIndata invoiceIndata = InvoiceListIndata();
  PaymentListIndata paymentIndata = PaymentListIndata();

  @override
  void onInit() {
    super.onInit();
  }

  void contractLoad({String? searchKey}) {
    contractData.clear();
    contractIndata.pageIndex = 1;
    // configIndata();
    contractLoadMore(searchKey: searchKey);
  }

  void contractLoadMore({String? searchKey}) {
    contractIndata.clientName = searchKey ?? "";
    workSpaceService.getOldContractGetPagedList(
      indata: contractIndata,
      success: (value) {
        contractRefreshController.loadComplete();
        contractRefreshController.refreshCompleted();
        if (value.items!.length == 0) {
          contractRefreshController.loadNoData();
        }
        contractData.addAll(value.items!);
        contractIndata.pageIndex++;
        update(["contract"]);
      },
    );
  }

  void invoiceLoad({String? searchKey}) {
    recordData.clear();
    invoiceIndata.pageIndex = 1;
    invoiceLoadMore(searchKey: searchKey);
  }

  void invoiceLoadMore({String? searchKey}) {
    invoiceIndata.clientName = searchKey ?? "";
    workSpaceService.getInvoiceGetPagedList(
      query: invoiceIndata,
      success: (value) {
        recordRefreshController.loadComplete();
        recordRefreshController.refreshCompleted();
        if (value.items!.length == 0) {
          recordRefreshController.loadNoData();
        }
        recordData.addAll(value.items!);
        invoiceIndata.pageIndex++;
        update(["record"]);
      },
    );
  }

  void paymentLoad({String? searchKey}) {
    recordData.clear();
    paymentIndata.pageIndex = 1;
    paymentLoadMore(searchKey: searchKey);
  }

  void paymentLoadMore({String? searchKey}) {
    paymentIndata.clientName = searchKey ?? "";
    workSpaceService.getPaymentGetPagedList(
      query: paymentIndata,
      success: (value) {
        recordRefreshController.loadComplete();
        recordRefreshController.refreshCompleted();
        if (value.items!.length == 0) {
          recordRefreshController.loadNoData();
        }
        recordData.addAll(value.items!);
        paymentIndata.pageIndex++;
        update(["record"]);
      },
    );
  }
}
