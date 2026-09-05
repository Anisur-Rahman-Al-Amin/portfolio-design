import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({super.key, required this.child, this.padding = AppSizes.pagePadding});

  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.contentMaxWidth),
          child: child,
        ),
      ),
    );
  }
}
