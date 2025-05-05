import 'package:flutter/material.dart';

/// Default theme data for the mini dashboard widgets.
class MiniDashboardTheme {
  /// Default colors for charts and graphs when specific colors are not provided.
  static const List<Color> defaultColors = [
    Color(0xFF4285F4), // Blue
    Color(0xFF34A853), // Green
    Color(0xFFFBBC05), // Yellow
    Color(0xFFEA4335), // Red
    Color(0xFF673AB7), // Purple
    Color(0xFF00BCD4), // Cyan
    Color(0xFFFF9800), // Orange
    Color(0xFF795548), // Brown
  ];

  /// Returns a color from the default color palette based on index.
  /// The index will wrap around if it exceeds the length of the color list.
  static Color getColor(int index) {
    return defaultColors[index % defaultColors.length];
  }

  /// Creates a gradient based on a base color.
  static LinearGradient createGradient(Color baseColor, [Color? secondaryColor]) {
    final secondColor = secondaryColor ?? baseColor.withOpacity(0.7);
    
    return LinearGradient(
      colors: [baseColor, secondColor],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  /// Default text style for card titles.
  static TextStyle titleTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
    );
  }

  /// Default text style for card values.
  static TextStyle valueTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).textTheme.bodyLarge?.color,
    );
  }

  /// Default box decoration for cards.
  static BoxDecoration cardDecoration(BuildContext context, {Color? backgroundColor}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return BoxDecoration(
      color: backgroundColor ?? (isDark ? Colors.grey[800] : Colors.white),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }

  /// Default icon container decoration.
  static BoxDecoration iconContainerDecoration(Color color) {
    return BoxDecoration(
      color: color.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12),
    );
  }

  /// Helper function to adjust colors based on dark/light theme.
  static Color adaptiveColor(BuildContext context, Color lightColor, Color darkColor) {
    return Theme.of(context).brightness == Brightness.dark ? darkColor : lightColor;
  }

  /// Helper function to generate a semi-transparent version of a color.
  static Color withOpacity(Color color, double opacity) {
    return color.withOpacity(opacity);
  }
}
