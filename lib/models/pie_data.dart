import 'package:flutter/material.dart';

/// Data model for pie chart segments.
class PieData {
  /// The label for this data point.
  final String label;
  
  /// The numerical value of this data point.
  final double value;
  
  /// The color for this segment of the pie chart.
  final Color color;
  
  /// Optional: Additional data to be associated with this segment.
  final dynamic extraData;

  /// Constructor for creating a PieData instance.
  const PieData({
    required this.label,
    required this.value,
    required this.color,
    this.extraData,
  });

  /// Creates a copy of this PieData with specific fields replaced.
  PieData copyWith({
    String? label,
    double? value,
    Color? color,
    dynamic extraData,
  }) {
    return PieData(
      label: label ?? this.label,
      value: value ?? this.value,
      color: color ?? this.color,
      extraData: extraData ?? this.extraData,
    );
  }

  @override
  String toString() {
    return 'PieData(label: $label, value: $value, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PieData &&
        other.label == label &&
        other.value == value &&
        other.color == color;
  }

  @override
  int get hashCode => label.hashCode ^ value.hashCode ^ color.hashCode;
}
