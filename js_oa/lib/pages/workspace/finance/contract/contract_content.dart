import 'package:flutter/material.dart';
import 'package:js_oa/pages/workspace/finance/contract/contract_mine.dart';
import 'package:js_oa/pages/workspace/finance/invoice/invoice_record.dart';

class ContractContent extends StatefulWidget {
  final TabController? tabController;
  final String? financeType;
  ContractContent({Key? key, this.tabController, this.financeType})
      : super(key: key);

  @override
  _ContractState createState() => _ContractState();
}

class _ContractState extends State<ContractContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ContractSearchBar(
        //   onSubmitted: (searchText) {
        //     print(configSearchText(
        //         widget.tabController!.index, widget.financeType!, searchText));
        //   },
        // ),
        Expanded(
          child: TabBarView(
            controller: widget.tabController!,
            children: [
              ContractMine(financeType: widget.financeType),
              ContractInvoiceRecord(financeType: widget.financeType),
            ],
          ),
        ),
      ],
    );
  }

  String configSearchText(int index, String type, String searchText) {
    switch (widget.financeType) {
      case "Invoice":
        if (index == 0) {
          print("开票我的案件$searchText");
        } else {
          print("开票开票记录$searchText");
        }
        break;
      case "Payment":
        if (index == 0) {
          print("缴费我的案件$searchText");
        } else {
          print("缴费开票记录$searchText");
        }
        break;
      case "refund":
        if (index == 0) {
          print("退款我的案件$searchText");
        } else {
          print("退款开票记录$searchText");
        }
        break;
      default:
    }
    return "";
  }
}
