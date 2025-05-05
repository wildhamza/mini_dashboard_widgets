import 'package:flutter/material.dart';

/// Model class for bar chart data used in [ActivityBar] widget
class BarData {
  /// Label for the bar (displayed on x-axis)
  final String label;
  
  /// Value for the bar height
  final double value;
  
  /// Color for the bar (optional, will use theme default if not specified)
  final Color? color;
  
  /// Optional custom tooltip text
  final String? tooltipText;

  /// Creates a BarData object for use in ActivityBar widget
  const BarData({
    required this.label,
    required this.value,
    this.color,
    this.tooltipText,
  });
}
