import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppDefaultShimmer extends StatelessWidget {
  final Widget child;

  const AppDefaultShimmer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: child,
    );
  }
}
