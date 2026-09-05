import 'package:flutter/widgets.dart';

abstract final class Responsive {
  static bool isMobile(BuildContext context) => MediaQuery.sizeOf(context).width < 600;
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 600 && width < 1000;
  }
  static bool isDesktop(BuildContext context) => MediaQuery.sizeOf(context).width >= 1000;
  static double contentWidth(BuildContext context) => MediaQuery.sizeOf(context).width.clamp(0, 1200);
}
