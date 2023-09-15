import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/core.dart';

class BaseShimmer extends StatelessWidget {
  const BaseShimmer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kTheme.colorScheme.onBackground.withOpacity(0.6),
      highlightColor: kTheme.colorScheme.onBackground.withOpacity(0.4),
      period: const Duration(milliseconds: 1000),
      direction: ShimmerDirection.ltr,
      child: child,
    );
  }
}
