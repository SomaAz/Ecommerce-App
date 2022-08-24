import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    Key? key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);
  final double? width;
  final double? height;
  final double? borderRadius;

  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[200]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius == null
              ? null
              : BorderRadius.circular(borderRadius!),
          shape: shape,
        ),
      ),
    );
  }
}
