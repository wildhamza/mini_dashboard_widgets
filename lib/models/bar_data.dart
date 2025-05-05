import 'package:flutter/material.dart';

/// Data model for bar chart data points.
class BarData {
  /// The label for this data point.
  final String label;
  
  /// The numerical value of this data point.
  final double value;
  
  /// The color for this bar in the chart.
  final Color color;
  
  /// Optional: Additional data to be associated with this bar.
  final dynamic extraData;

  /// Constructor for creating a BarData instance.
  const BarData({
    required this.label,
    required this.value,
    required this.color,
    this.extraData,
  });

  /// Creates a copy of this BarData with specific fields replaced.
  BarData copyWith({
    String? label,
    double? value,
    Color? color,
    dynamic extraData,
  }) {
    return BarData(
      label: label ?? this.label,
      value: value ?? this.value,
      color: color ?? this.color,
      extraData: extraData ?? this.extraData,
    );
  }

  @override
  String toString() {
    return 'BarData(label: $label, value: $value, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BarData &&
        other.label == label &&
        other.value == value &&
        other.color == color;
  }

  @override
  int get hashCode => label.hashCode ^ value.hashCode ^ color.hashCode;
}
