import 'package:flutter/material.dart';

/// Model class for pie chart data used in [PieSummary] widget
class PieData {
  /// Label for the pie section (displayed in legend)
  final String label;
  
  /// Value for the pie section size
  final double value;
  
  /// Color for the pie section
  final Color color;
  
  /// Optional custom tooltip text
  final String? tooltipText;

  /// Creates a PieData object for use in PieSummary widget
  const PieData({
    required this.label,
    required this.value,
    required this.color,
    this.tooltipText,
  });
}
