// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:js_oa/res/gaps.dart';

class ScreenWidget extends StatefulWidget {
  ///value1:状态 value2:类型
  Function(String value1, String value2)? trueCallBack;
  String selectState;
  String selectType;
  int screenCount;
  int screenType;
  ScreenWidget({
    this.screenCount = 1,
    this.screenType = 1,
    this.selectState = "全部",
    this.selectType = "全部",
    this.trueCallBack,
  });

  @override
  _ScreenWidgetState createState() => _ScreenWidgetState();
}

class _ScreenWidgetState extends State<ScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Gaps.line,
            Container(
              height: 45,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Icon(Icons.list),
                    SizedBox(width: 4),
                    Text("筛选", style: TextStyle(fontSize: 17))
                  ],
                ),
              ),
            ),
            Container(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: widget.screenCount,
                itemBuilder: (BuildContext context, int index) {
                  if (widget.screenCount == 1) {
                    return TypeCell(
                        selectTitle: widget.selectType,
                        callBack: (value) {
                          widget.selectType = value;
                          // stateCallBack!(value);
                        });
                  }
                  if (index == 0) {
                    return StateCell(
                      selectTitle: widget.selectState,
                      callBack: (value) {
                        widget.selectState = value;
                        // stateCallBack!(value);
                      },
                    );
                  } else {
                    return TypeCell(
                        selectTitle: widget.selectType,
                        callBack: (value) {
                          widget.selectType = value;
                          // stateCallBack!(value);
                        });
                  }
                },
              ),
            ),
            bottomWidget(context),
          ],
        ),
      ),
    );
  }

  Widget bottomWidget(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 54) / 2;
    return Container(
      // color: Colors.white,
      height: 95,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: width,
            height: 50,
            decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: TextButton(
              onPressed: () {
                setState(() {
                  widget.selectState = "全部";
                  widget.selectType = "全部";
                });
              },
              child: Text(
                "重置",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
          Container(
            height: 50,
            width: width,
            decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(5)),
            child: TextButton(
              onPressed: () {
                widget.trueCallBack!(widget.selectState, widget.selectType);
              },
              child: Text(
                "确定",
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class StateCell extends StatefulWidget {
  // StateCell({Key? key}) : super(key: key);
  final List<String> stateDataTitle = ["全部", "审批通过", "审批拒绝", "已撤销"];
  String selectTitle;
  Function(dynamic value)? callBack;
  StateCell({this.selectTitle = "全部", this.callBack});

  @override
  _StateCellState createState() => _StateCellState();
}

class _StateCellState extends State<StateCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 172,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 38,
            alignment: Alignment.centerLeft,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "状态",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: widget.stateDataTitle.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, //交叉轴 子Widget的个数
                crossAxisSpacing: 20, //交叉轴  分割线宽度
                mainAxisSpacing: 16, //主轴 分割线宽度
                childAspectRatio: 2.8 //item的宽高比
                ),
            itemBuilder: (BuildContext context, int index) {
              return SelectButton(
                type: 1,
                title: widget.stateDataTitle[index],
                isSelect: (widget.stateDataTitle[index] == widget.selectTitle),
                callBack: (value) {
                  setState(() {
                    widget.selectTitle = value;
                    widget.callBack!(value);
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class TypeCell extends StatefulWidget {
  final List<String> typeDataTitle = ["全部", "开票", "缴费", "退款"];
  String selectTitle;
  final Function(dynamic value)? callBack;
  TypeCell({this.selectTitle = "全部", this.callBack});

  @override
  _TypeCellState createState() => _TypeCellState();
}

class _TypeCellState extends State<TypeCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 172,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 38,
            alignment: Alignment.centerLeft,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text(
                "类型",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          GridView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //交叉轴 子Widget的个数
                crossAxisSpacing: 20, //交叉轴  分割线宽度
                mainAxisSpacing: 16, //主轴 分割线宽度
                childAspectRatio: 4.44 //item的宽高比
                ),
            itemBuilder: (BuildContext context, int index) {
              return SelectButton(
                type: 2,
                title: widget.typeDataTitle[index],
                isSelect: (widget.typeDataTitle[index] == widget.selectTitle),
                callBack: (value) {
                  setState(() {
                    widget.selectTitle = value;
                    widget.callBack!(value);
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }
}

class SelectButton extends StatelessWidget {
  final int? type;
  final String? title;
  final bool? isSelect;
  String selectState = "全部";
  String selectType = "全部";
  final Function(dynamic value)? callBack;
  SelectButton({this.type, this.title, this.isSelect, this.callBack});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        ///1：状态 2:类型
        if (type == 1) {
          selectState = title!;
          // print(selectState);
          callBack!(selectState);
        } else {
          selectType = title!;
          callBack!(selectType);
          // print(selectType);
        }
      },
      child: Text(title!, style: TextStyle(color: Colors.black)),
      style: ButtonStyle(
          side: MaterialStateProperty.all(
            BorderSide(color: Colors.grey.shade400, width: 0.5),
          ),
          backgroundColor:
              isSelect! ? MaterialStateProperty.all(Colors.blue) : null),
    );
  }
}
