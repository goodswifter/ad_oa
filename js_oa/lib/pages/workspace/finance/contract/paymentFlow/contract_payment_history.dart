import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/api/service/request/workspace_service.dart';
import 'package:js_oa/pages/workspace/entity/payment_history_list_entity.dart';
import 'package:js_oa/pages/workspace/widgets/empty_widget.dart';
import 'package:js_oa/pages/workspace/widgets/smart_refresher_footer.dart';
import 'package:js_oa/pages/workspace/widgets/smart_refresher_header.dart';
import 'package:js_oa/utils/workflow/approve_status_until.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContractPaymentHistory extends StatefulWidget {
  ContractPaymentHistory({Key? key}) : super(key: key);

  @override
  _ContractPaymentHistoryState createState() => _ContractPaymentHistoryState();
}

class _ContractPaymentHistoryState extends State<ContractPaymentHistory> {
  List<PaymentHistoryItems> data = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  int? contractId = Get.arguments;
  int pageIndex = 1;
  @override
  void initState() {
    load();
    super.initState();
  }

  void load() {
    pageIndex = 1;
    data.clear();
    loadMore();
  }

  void loadMore() {
    WorkSpaceService().getPaymentGetPagedListForContract(
      contractId: contractId,
      pageIndex: pageIndex,
      success: (value) {
        setState(() {
          refreshController.loadComplete();
          refreshController.refreshCompleted();
          if (value.items!.length == 0) {
            refreshController.loadNoData();
          }
          pageIndex++;
          data.addAll(value.items!);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("历史记录"),
      ),
      body: bodyContent(context),
    );
  }

  Widget bodyContent(BuildContext context) {
    return SmartRefresher(
      controller: refreshController,
      enablePullDown: true,
      enablePullUp: true,
      header: RefreshHeader(),
      footer: RefreshFooter(),
      onLoading: loadMore,
      onRefresh: load,
      child: data.length > 0
          ? ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext content, int index) {
                return listItem(model: data[index]);
              },
            )
          : EmptyWidget.noData(),
    );
  }

  Widget listItem({PaymentHistoryItems? model}) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(left: 12, top: 12, right: 12),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("缴费人：${model!.clientName ?? "暂无"}"),
                Text(
                  ApproveStatusUntil.getApproveStatusStr(model.approveStatus)
                          .ststusStr ??
                      "暂无",
                  style: TextStyle(
                      color: ApproveStatusUntil.getApproveStatusStr(
                              model.approveStatus)
                          .color),
                )
              ],
            ),
            SizedBox(height: 6),            
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(text: "缴费金额："),
                  TextSpan(
                      text: "${model.money ?? "暂无"}",
                      style: TextStyle(color: Colors.red))
                ],
              ),
            ),
            SizedBox(height: 6),
            Text("缴费时间：${model.paymentTime ?? "暂无"}"),
            SizedBox(height: 6),
            Text("缴费方式：${model.paymentChannelName ?? "暂无"}"),
            SizedBox(height: 6),
            Text("备注：${model.remarks ?? "暂无"}"),
          ],
        ),
      ),
    );
  }
}
