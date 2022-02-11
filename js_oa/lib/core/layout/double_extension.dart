import 'size_fit.dart';

extension DoubleFit on double {
  double get px {
    return JSSizeFit.setPx(this);
  }

  double get rpx {
    return JSSizeFit.setRpx(this);
  }
}
