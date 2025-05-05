import 'package:flutter/material.dart';

/// Theme data for mini_dashboard_widgets
class MiniDashboardTheme {
  /// Default card padding
  static const EdgeInsets defaultCardPadding = EdgeInsets.all(16.0);
  
  /// Default chart radius
  static const double defaultChartRadius = 100.0;
  
  /// Default animation duration for charts
  static const Duration defaultAnimationDuration = Duration(milliseconds: 500);
  
  /// Default bar chart radius
  static const double defaultBarRadius = 6.0;
  
  /// Default bar chart width
  static const double defaultBarWidth = 16.0;
  
  /// Default pie chart section space
  static const double defaultPieSectionSpace = 2.0;
  
  /// Default card border radius
  static const double defaultCardBorderRadius = 12.0;
  
  /// Default card elevation
  static const double defaultCardElevation = 2.0;
  
  /// Default title style for light theme
  static TextStyle defaultLightTitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.black87,
    );
  }
  
  /// Default title style for dark theme
  static TextStyle defaultDarkTitleStyle(BuildContext context) {
    return Theme.of(context).textTheme.titleMedium!.copyWith(
      fontWeight: FontWeight.w500,
      color: Colors.white70,
    );
  }
  
  /// Default value style for light theme
  static TextStyle defaultLightValueStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }
  
  /// Default value style for dark theme
  static TextStyle defaultDarkValueStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
  }
  
  /// Default colors for charts in light mode
  static final List<Color> defaultLightColors = [
    Colors.blue.shade500,
    Colors.green.shade500,
    Colors.orange.shade500,
    Colors.purple.shade500,
    Colors.red.shade500,
    Colors.teal.shade500,
    Colors.amber.shade500,
    Colors.indigo.shade500,
  ];
  
  /// Default colors for charts in dark mode
  static final List<Color> defaultDarkColors = [
    Colors.blue.shade300,
    Colors.green.shade300,
    Colors.orange.shade300,
    Colors.purple.shade300,
    Colors.red.shade300,
    Colors.teal.shade300,
    Colors.amber.shade300,
    Colors.indigo.shade300,
  ];
  
  /// Returns the appropriate color based on theme brightness
  static Color adaptiveColor(BuildContext context, Color lightColor, Color darkColor) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? lightColor : darkColor;
  }
  
  /// Returns the appropriate text style based on theme brightness
  static TextStyle adaptiveTextStyle(BuildContext context, TextStyle lightStyle, TextStyle darkStyle) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.light ? lightStyle : darkStyle;
  }
}
