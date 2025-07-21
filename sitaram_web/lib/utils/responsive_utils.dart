import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isSmallScreen(BuildContext context) =>
      MediaQuery.of(context).size.width < 400;
  static bool isMediumScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= 400 &&
      MediaQuery.of(context).size.width < 800;
  static bool isLargeScreen(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800;

  static double fontSize(BuildContext context,
      {double small = 16, double medium = 20, double large = 24}) {
    if (isSmallScreen(context)) return small;
    if (isMediumScreen(context)) return medium;
    return large;
  }

  static double cardHorizontalPadding(BuildContext context) {
    if (isSmallScreen(context)) return 4;
    if (isMediumScreen(context)) return 16;
    return 32;
  }

  static double cardMaxWidth(BuildContext context) {
    if (isSmallScreen(context)) return 320;
    if (isMediumScreen(context)) return 480;
    return 600;
  }

  static EdgeInsets cardPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: cardHorizontalPadding(context),
      vertical: isSmallScreen(context) ? 16 : 32,
    );
  }
}
