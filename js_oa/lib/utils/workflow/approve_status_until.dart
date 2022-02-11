import 'package:flutter/material.dart';

class ApproveStatusUntil {
  static StatusUntil getApproveStatusStr(dynamic status) {
    StatusUntil statusUntil = StatusUntil();
    switch (status) {
      case 0:
        statusUntil.color = Colors.amber;
        statusUntil.ststusStr = "审核中";
        break;
      case 1:
        statusUntil.color = Colors.green;
        statusUntil.ststusStr = "审核通过";
        break;
      case 2:
        statusUntil.color = Colors.red;
        statusUntil.ststusStr = "审核未通过";
        break;
      case 3:
        statusUntil.color = Colors.grey;
        statusUntil.ststusStr = "已撤销";
        break;
      case 4:
        statusUntil.color = Colors.amber;
        statusUntil.ststusStr = "等待审核";
        break;
      default:
        statusUntil.color = Colors.grey;
        statusUntil.ststusStr = "未知状态";
    }
    return statusUntil;
  }
}

class StatusUntil {
  Color? color;
  String? ststusStr;
  StatusUntil({this.color, this.ststusStr});
}
