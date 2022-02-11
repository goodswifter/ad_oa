import 'size_fit.dart';

extension IntFit on int {
  double get px {
    return JSSizeFit.setPx(this.toDouble());
  }

  double get rpx {
    return JSSizeFit.setRpx(this.toDouble());
  }
}
