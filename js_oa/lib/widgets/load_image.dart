import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:js_oa/core/constants/resource.dart';

/// 图片加载（支持本地与网络图片）
class LoadImage extends StatelessWidget {
  const LoadImage(
    this.imageName, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.holderImg = R.ASSETS_IMAGES_MINE_ME_DEFAULT_ICON_PNG,
    this.cacheWidth,
    this.cacheHeight,
    this.radius = 8,
  }) : super(key: key);

  final String imageName;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String holderImg;
  final int? cacheWidth;
  final int? cacheHeight;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (imageName.startsWith('http')) {
      final Widget _image =
          LoadAssetImage(holderImg, height: height, width: width, fit: fit);

      return CachedNetworkImage(
        imageUrl: imageName,
        // imageBuilder: (context, imageProvider) => Container(
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //       image: imageProvider,
        //     ),
        //   ),
        // ),
        placeholder: (_, __) => _image,
        errorWidget: (_, __, dynamic error) => _image,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: cacheWidth,
        memCacheHeight: cacheHeight,
      );
    } else if (imageName.isEmpty) {
      return LoadAssetImage(
        holderImg,
        height: height,
        width: width,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
    } else {
      return LoadAssetImage(
        imageName,
        height: height,
        width: width,
        fit: fit,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight,
      );
    }
  }
}

/// 加载本地资源图片
class LoadAssetImage extends StatelessWidget {
  const LoadAssetImage(this.imagePath,
      {Key? key,
      this.width,
      this.height,
      this.cacheWidth,
      this.cacheHeight,
      this.fit,
      this.color})
      : super(key: key);

  final String imagePath;
  final double? width;
  final double? height;
  final int? cacheWidth;
  final int? cacheHeight;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: height,
      width: width,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
      fit: fit,
      color: color,
      errorBuilder: (context, error, stackTrace) =>
          Image.asset(R.ASSETS_IMAGES_MINE_ME_DEFAULT_ICON_PNG),

      /// 忽略图片语义
      excludeFromSemantics: true,
    );
  }
}
