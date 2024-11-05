import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sizer/sizer.dart';

class CustomImage extends StatelessWidget {
  final String? image;
  final Widget? errorWidget;
  final double? borderRadius;
  final double? width, height;
  final String? errorImage;
  const CustomImage({
    super.key,
    this.width,
    this.height,
    this.errorImage,
    this.errorWidget,
    this.borderRadius,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 3.w),
      child: CachedNetworkImage(
        imageUrl: image ?? "",
        // width: width ?? 20.w,
        height: height ?? 20.h,
        fit: BoxFit.cover,
        placeholder: (_, url) => SizedBox(
          width: width ?? 20.w,
          height: height ?? 20.h,
          // width: double.infinity,
        ),
        errorListener: null,
        errorWidget: (_, url, error) => Icon(Iconsax.danger, size: 32.sp),
      ),
    );
  }
}
