import 'dart:ui';

class JSSizeFit {
  // 1.基本信息
  static double? physicalWidth;
  static double? physicalHeight;
  static double? screenWidth;
  static double? screenHeight;
  static double? dpr;
  static double? statusHeight; // 状态栏高度
  static double? bottomHeight; // 底部高度

  static double? rpx;
  static double? px;

  static void initialize({double standardSize = 750}) {
    // 1. 手机的物理分辨率
    physicalWidth = window.physicalSize.width;
    physicalHeight = window.physicalSize.height;

    print("physicalWidth: $physicalWidth");
    print("physicalHeight: $physicalHeight");

    // 2. 获取dpr 设备像素比: 物理像素/逻辑像素
    dpr = window.devicePixelRatio;
    print("dpr: $dpr");

    // 3. 屏幕的宽度和高度
    screenWidth = physicalWidth! / dpr!;
    screenHeight = physicalHeight! / dpr!;
    print("screenWidth: $screenWidth");

    // 4. 状态栏高度
    statusHeight = window.padding.top / dpr!;
    bottomHeight = window.padding.bottom / dpr!;
    print("statusHeight: $statusHeight");
    print("bottomHeight: $bottomHeight");

    // 5. 去除顶部和底部安全区域的高度

    // 6. 计算rpx的大小
    // rpx = 逻辑像素(点), px = 物理像素
    rpx = screenWidth! / standardSize;
    px = screenWidth! / standardSize * 2;
  }

  static double setRpx(double size) {
    return rpx! * size;
  }

  static double setPx(double size) {
    return px! * size;
  }
}
