import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/controller/contract_controller.dart';
import 'package:js_oa/pages/workspace/finance/contract/contract_mine_cell.dart';
import 'package:js_oa/pages/workspace/widgets/contract_search_bar.dart';
import 'package:js_oa/pages/workspace/widgets/empty_widget.dart';
import 'package:js_oa/pages/workspace/widgets/smart_refresher_footer.dart';
import 'package:js_oa/pages/workspace/widgets/smart_refresher_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ContractMine extends StatefulWidget {
  final String? financeType;
  ContractMine({Key? key, this.financeType}) : super(key: key);

  @override
  _ContractMineState createState() => _ContractMineState();
}

class _ContractMineState extends State<ContractMine>
    with AutomaticKeepAliveClientMixin {
  // ContractEntity? data;
  ContractController controller = Get.put(ContractController());
  @override
  void initState() {
    controller.contractLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        ContractSearchBar(
          onSubmitted: (searchText) {
            controller.contractLoad(searchKey: searchText);
          },
          clear: () {
            controller.contractLoad(searchKey: "");
          },
        ),
        Expanded(
          child: GetBuilder<ContractController>(
            id: "contract",
            builder: (model) {
              return SmartRefresher(
                controller: model.contractRefreshController,
                enablePullDown: true,
                enablePullUp: true,
                header: RefreshHeader(),
                footer: RefreshFooter(),
                onLoading: controller.contractLoadMore,
                onRefresh: controller.contractLoad,
                child: model.contractData.length != 0
                    ? ListView.builder(
                        itemCount: model.contractData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ContractMineCell(
                            detail: model.contractData[index],
                            financeType: widget.financeType,
                          );
                        })
                    : EmptyWidget.noData(),
              );
            },
          ),
        ),
      ],
    );
    // return ListView.builder(
    //     itemCount: 15,
    //     itemBuilder: (BuildContext context, int index) {
    //       return Text("data");
    //     });
  }

  @override
  bool get wantKeepAlive => true;
}
