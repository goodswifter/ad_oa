import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/controller/contract_controller.dart';
import 'package:js_oa/pages/workspace/finance/invoice/invoice_record_cell.dart';
import 'package:js_oa/pages/workspace/finance/payment/payment_record_cell.dart';
import 'package:js_oa/pages/workspace/finance/refund/refund_record_cell.dart';
import 'package:js_oa/pages/workspace/widgets/contract_search_bar.dart';
import 'package:js_oa/pages/workspace/widgets/empty_widget.dart';
import 'package:js_oa/pages/workspace/widgets/smart_refresher_footer.dart';
import 'package:js_oa/pages/workspace/widgets/smart_refresher_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContractInvoiceRecord extends StatefulWidget {
  final String? financeType;
  ContractInvoiceRecord({Key? key, this.financeType}) : super(key: key);

  @override
  _ContractInvoiceRecordState createState() => _ContractInvoiceRecordState();
}

class _ContractInvoiceRecordState extends State<ContractInvoiceRecord>
    with AutomaticKeepAliveClientMixin {
  ContractController controller = Get.put(ContractController());
  @override
  void initState() {
    // controller.invoiceLoad();
    searchRecord(financeType: widget.financeType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        ContractSearchBar(
          onSubmitted: (searchText) {
            searchRecord(
                financeType: widget.financeType, searchText: searchText);
          },
          clear: () {
            searchRecord(financeType: widget.financeType, searchText: "");
          },
        ),
        Expanded(
          child: GetBuilder<ContractController>(
            id: "record",
            builder: (model) {
              return SmartRefresher(
                controller: model.recordRefreshController,
                enablePullDown: true,
                enablePullUp: true,
                header: RefreshHeader(),
                footer: RefreshFooter(),
                onLoading: recordLoadMore(
                    financeType: widget.financeType, model: model),
                onRefresh:
                    recordLoad(financeType: widget.financeType, model: model),
                child: model.recordData.length != 0
                    ? ListView.builder(
                        itemCount: model.recordData.length,
                        itemBuilder: (BuildContext context, int index) {
                          switch (widget.financeType) {
                            case "Invoice": //开票
                              return ContractInvoiceRecordCell(
                                data: model.recordData[index],
                                index: index,
                              );

                            case "Payment": //缴费
                              print(widget.financeType);
                              return ContractPaymentRecordCell(
                                data: model.recordData[index],
                                index: index,
                              );

                            case "Refund": //退款
                              print(widget.financeType);
                              return ContractRefundRecordCell();
                            default:
                              print(widget.financeType);
                              return ContractInvoiceRecordCell(
                                  data: model.recordData[index]);
                          }
                        })
                    : EmptyWidget.noData(),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;

  Function() recordLoad({String? financeType, ContractController? model}) {
    switch (widget.financeType) {
      case "Invoice": //开票
        return model!.invoiceLoad;

      case "Payment": //缴费
        print(widget.financeType);
        return model!.paymentLoad;

      case "Refund": //退款
        print(widget.financeType);
        return model!.invoiceLoad;
      default:
        print(widget.financeType);
        return model!.invoiceLoad;
    }
  }

  Function() recordLoadMore({String? financeType, ContractController? model}) {
    switch (widget.financeType) {
      case "Invoice": //开票
        return model!.invoiceLoadMore;

      case "Payment": //缴费
        print(widget.financeType);
        return model!.paymentLoadMore;

      case "Refund": //退款
        print(widget.financeType);
        return model!.invoiceLoadMore;
      default:
        print(widget.financeType);
        return model!.invoiceLoadMore;
    }
  }

  void searchRecord({String? financeType, String? searchText}) {
    switch (widget.financeType) {
      case "Invoice": //开票
        controller.invoiceLoad(searchKey: searchText);
        break;
      case "Payment": //缴费
        print(widget.financeType);
        controller.paymentLoad(searchKey: searchText);
        break;

      case "Refund": //退款
        print(widget.financeType);
        controller.invoiceLoad(searchKey: searchText);
        break;
      default:
        print(widget.financeType);
        controller.invoiceLoad(searchKey: searchText);
        break;
    }
  }
}
