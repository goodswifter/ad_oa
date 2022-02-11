import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshHeader extends ClassicHeader {
  final String releaseText, refreshingText, completeText, failedText, idleText;
  final Widget releaseIcon;
  RefreshHeader({
    this.releaseText = '释放更新',
    this.refreshingText = '加载中...',
    this.completeText = '刷新完成',
    this.failedText = '刷新失败',
    this.idleText = '下拉刷新',
    this.releaseIcon = const Icon(Icons.arrow_upward, color: Colors.grey),
  }) : super(releaseIcon: releaseIcon);
}
