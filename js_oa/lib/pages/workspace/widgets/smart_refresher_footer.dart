import 'package:pull_to_refresh/pull_to_refresh.dart';

// ignore: must_be_immutable
class RefreshFooter extends ClassicFooter {
  String idleText, canLoadingText, loadingText, failedText, noDataText;

  RefreshFooter({
    this.canLoadingText = '可以加载更多',
    this.loadingText = '加载中...',
    this.noDataText = '没有数据',
    this.failedText = '加载失败',
    this.idleText = '上拉加载更多',
  }) : super();
}
