import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:js_oa/pages/workspace/approve/approve_content_invoce_cell.dart';
import 'package:js_oa/pages/workspace/approve/approve_content_payment_cell.dart';
import 'package:js_oa/pages/workspace/controller/approve_controller.dart';
import 'package:js_oa/pages/workspace/widgets/approve_search_bar.dart';
import 'package:js_oa/pages/workspace/widgets/empty_widget.dart';
import 'package:js_oa/pages/workspace/widgets/screen_widget.dart';
import 'package:js_oa/pages/workspace/widgets/smart_refresher_footer.dart';
import 'package:js_oa/pages/workspace/widgets/smart_refresher_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ApproceContent extends StatefulWidget {
  final int? contentType;
  ApproceContent({Key? key, this.contentType = 1}) : super(key: key);

  @override
  _ApproceContentState createState() => _ApproceContentState();
}

class _ApproceContentState extends State<ApproceContent> {
  int idnex = 1;
  bool isShow = false;
  String searchState = "全部";
  String searchType = "全部";
  ApproveController controller = Get.put(ApproveController());
  // WorkSpaceApproveIndata indata = WorkSpaceApproveIndata();

  @override
  void initState() {
    controller.indata.tag = widget.contentType.toString();
    controller.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ApproveSearchBar(
          onSelectTap: () {
            setState(() {
              show();
            });
          },
          onFocus: () {
            setState(() {
              isShow = true;
              show();
            });
          },
          onSubmitted: (searchText) {
            controller.indata.realName = searchText;
            controller.load();
          },
          clear: () {
            controller.indata.realName = "";
            controller.load();
          },
        ),
        Expanded(
          child: IndexedStack(
            sizing: StackFit.expand,
            index: idnex,
            children: [
              ScreenWidget(
                screenCount: widget.contentType == 1 ? 1 : 2,
                selectState: searchState,
                selectType: searchType,
                trueCallBack: (value1, value2) {
                  setState(() {
                    searchState = value1;
                    controller.indata.approveStatus = value1;
                    searchType = value2;
                    controller.indata.code = value2;
                    controller.load();
                    print(value1 + value2);
                    show();
                  });
                },
              ),
              GetBuilder<ApproveController>(builder: (model) {
                return SmartRefresher(
                  controller: model.refreshController,
                  enablePullDown: true,
                  enablePullUp: true,
                  header: RefreshHeader(),
                  footer: RefreshFooter(),
                  onLoading: model.loadData,
                  onRefresh: model.load,
                  child: model.data.length > 0
                      ? ListView.builder(
                          // shrinkWrap: true,
                          itemCount: model.data.length,
                          itemBuilder: (BuildContext content, int index) {
                            if (model.data.length == 0) {
                              return Container();
                            }
                            //缴费
                            if (model.data[index].code == "Payment") {
                              return ApproveContentPaymentCell(
                                data: model.data[index],
                                index: index,
                              );
                            }
                            //开票
                            else if (model.data[index].code == "Invoice") {
                              return ApproceContentInvoiceCell(
                                data: model.data[index],
                                index: index,
                              );
                            } else {
                              return ApproveContentPaymentCell();
                            }
                          },
                        )
                      : EmptyWidget.noData(),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }

  bool show() {
    isShow = !isShow;
    idnex = isShow ? 0 : 1;
    return isShow;
  }
}
