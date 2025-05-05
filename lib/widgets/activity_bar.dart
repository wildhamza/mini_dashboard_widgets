import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/bar_data.dart';

/// The orientation of the bar chart.
enum BarChartOrientation { horizontal, vertical }

/// A customizable bar chart widget for displaying activity trends.
class ActivityBar extends StatefulWidget {
  /// List of data items to display in the bar chart.
  final List<BarData> data;
  
  /// The orientation of the bar chart.
  final BarChartOrientation orientation;
  
  /// Whether to show the axis labels.
  final bool showAxisLabels;
  
  /// Style for the x-axis labels.
  final TextStyle? xAxisLabelStyle;
  
  /// Style for the y-axis labels.
  final TextStyle? yAxisLabelStyle;
  
  /// Width of each bar.
  final double barWidth;
  
  /// Spacing between bars.
  final double barSpacing;
  
  /// Whether to have rounded corners on the bars.
  final bool roundedCorners;
  
  /// Radius for the rounded corners.
  final double cornerRadius;
  
  /// Whether to animate the chart when first displayed.
  final bool animate;
  
  /// The duration of the animation.
  final Duration animationDuration;
  
  /// The padding inside the widget.
  final EdgeInsetsGeometry padding;
  
  /// The background color of the widget.
  final Color backgroundColor;
  
  /// The border radius of the widget.
  final BorderRadius borderRadius;
  
  /// Optional: Maximum value for the y-axis, calculated from data if not provided.
  final double? maxY;
  
  /// Optional: Title for the chart.
  final String? title;
  
  /// Optional: Style for the title.
  final TextStyle? titleStyle;
  
  /// Optional: Title for the x-axis.
  final String? xAxisTitle;
  
  /// Optional: Title for the y-axis.
  final String? yAxisTitle;
  
  /// Optional: Style for the axis titles.
  final TextStyle? axisTitleStyle;
  
  /// Optional: Custom builder for the bar tooltip.
  final Widget Function(BarData)? tooltipBuilder;
  
  /// Optional: Whether to show grid lines.
  final bool showGridLines;
  
  /// Optional: Color for the grid lines.
  final Color gridLineColor;
  
  /// Optional: Whether to show the bottom border.
  final bool showBottomBorder;
  
  /// Optional: Color for the bottom border.
  final Color bottomBorderColor;

  const ActivityBar({
    Key? key,
    required this.data,
    this.orientation = BarChartOrientation.vertical,
    this.showAxisLabels = true,
    this.xAxisLabelStyle,
    this.yAxisLabelStyle,
    this.barWidth = 20.0,
    this.barSpacing = 16.0,
    this.roundedCorners = true,
    this.cornerRadius = 4.0,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 500),
    this.padding = const EdgeInsets.all(16.0),
    this.backgroundColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.maxY,
    this.title,
    this.titleStyle,
    this.xAxisTitle,
    this.yAxisTitle,
    this.axisTitleStyle,
    this.tooltipBuilder,
    this.showGridLines = true,
    this.gridLineColor = Colors.grey,
    this.showBottomBorder = true,
    this.bottomBorderColor = Colors.black,
  }) : super(key: key);

  @override
  State<ActivityBar> createState() => _ActivityBarState();
}

class _ActivityBarState extends State<ActivityBar> {
  late double _effectiveMaxY;
  int touchedIndex = -1;

  @override
  void initState() {
    super.initState();
    _calculateMaxY();
  }

  @override
  void didUpdateWidget(ActivityBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data || oldWidget.maxY != widget.maxY) {
      _calculateMaxY();
    }
  }

  void _calculateMaxY() {
    if (widget.maxY != null) {
      _effectiveMaxY = widget.maxY!;
    } else if (widget.data.isNotEmpty) {
      double maxValue = widget.data.map((e) => e.value).reduce((a, b) => a > b ? a : b);
      _effectiveMaxY = (maxValue * 1.2).ceilToDouble(); // Add 20% headroom
    } else {
      _effectiveMaxY = 100.0; // Default if no data
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return _buildEmptyState();
    }

    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null) ...[
            Text(
              widget.title!,
              style: widget.titleStyle ?? Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
          ],
          Expanded(
            child: widget.orientation == BarChartOrientation.vertical
                ? _buildVerticalBarChart()
                : _buildHorizontalBarChart(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
      ),
      child: const Center(
        child: Text(
          'No data available',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalBarChart() {
    return BarChart(
      BarChartData(
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.grey.shade800,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                '${widget.data[groupIndex].label}: ${widget.data[groupIndex].value.toStringAsFixed(1)}',
                const TextStyle(color: Colors.white),
              );
            },
            fitInsideHorizontally: true,
            fitInsideVertically: true,
          ),
          touchCallback: (FlTouchEvent event, barTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  barTouchResponse == null ||
                  barTouchResponse.spot == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            });
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: widget.showAxisLabels,
              reservedSize: 30,
              getTitlesWidget: (value, meta) {
                if (value.toInt() >= 0 && value.toInt() < widget.data.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.data[value.toInt()].label,
                      style: widget.xAxisLabelStyle ?? Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            axisNameWidget: widget.xAxisTitle != null
                ? Text(
                    widget.xAxisTitle!,
                    style: widget.axisTitleStyle ?? Theme.of(context).textTheme.bodyMedium,
                  )
                : null,
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: widget.showAxisLabels,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                if (value == 0) return const SizedBox();
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    value.toInt().toString(),
                    style: widget.yAxisLabelStyle ?? Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            ),
            axisNameWidget: widget.yAxisTitle != null
                ? Text(
                    widget.yAxisTitle!,
                    style: widget.axisTitleStyle ?? Theme.of(context).textTheme.bodyMedium,
                  )
                : null,
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: widget.showBottomBorder,
          border: Border(
            bottom: BorderSide(
              color: widget.bottomBorderColor.withOpacity(0.2),
              width: 1,
            ),
          ),
        ),
        gridData: FlGridData(
          show: widget.showGridLines,
          drawHorizontalLine: true,
          horizontalInterval: _effectiveMaxY / 5,
          getDrawingHorizontalLine: (value) => FlLine(
            color: widget.gridLineColor.withOpacity(0.2),
            strokeWidth: 1,
            dashArray: [5, 5],
          ),
          drawVerticalLine: false,
        ),
        alignment: BarChartAlignment.center,
        maxY: _effectiveMaxY,
        barGroups: _generateBarGroups(),
      ),
      swapAnimationDuration: widget.animate ? widget.animationDuration : Duration.zero,
    );
  }

  Widget _buildHorizontalBarChart() {
    return RotatedBox(
      quarterTurns: 1,
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Colors.grey.shade800,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                  '${widget.data[groupIndex].label}: ${widget.data[groupIndex].value.toStringAsFixed(1)}',
                  const TextStyle(color: Colors.white),
                );
              },
              fitInsideHorizontally: true,
              fitInsideVertically: true,
            ),
            touchCallback: (FlTouchEvent event, barTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    barTouchResponse == null ||
                    barTouchResponse.spot == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
              });
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: widget.showAxisLabels,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value.toInt() >= 0 && value.toInt() < widget.data.length) {
                    return RotatedBox(
                      quarterTurns: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          widget.data[value.toInt()].label,
                          style: widget.yAxisLabelStyle ?? Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: widget.showAxisLabels,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  if (value == 0) return const SizedBox();
                  return RotatedBox(
                    quarterTurns: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        value.toInt().toString(),
                        style: widget.xAxisLabelStyle ?? Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  );
                },
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(
            show: widget.showBottomBorder,
            border: Border(
              bottom: BorderSide(
                color: widget.bottomBorderColor.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          gridData: FlGridData(
            show: widget.showGridLines,
            drawHorizontalLine: true,
            horizontalInterval: _effectiveMaxY / 5,
            getDrawingHorizontalLine: (value) => FlLine(
              color: widget.gridLineColor.withOpacity(0.2),
              strokeWidth: 1,
              dashArray: [5, 5],
            ),
            drawVerticalLine: false,
          ),
          alignment: BarChartAlignment.center,
          maxY: _effectiveMaxY,
          barGroups: _generateBarGroups(),
        ),
        swapAnimationDuration: widget.animate ? widget.animationDuration : Duration.zero,
      ),
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return List.generate(widget.data.length, (index) {
      final isTouched = index == touchedIndex;
      final barColor = widget.data[index].color;
      final rodStackItems = [
        BarChartRodStackItem(0, widget.data[index].value, barColor),
      ];

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: widget.data[index].value,
            color: barColor,
            width: widget.barWidth,
            borderRadius: widget.roundedCorners 
                ? BorderRadius.only(
                    topLeft: Radius.circular(widget.cornerRadius),
                    topRight: Radius.circular(widget.cornerRadius),
                  )
                : BorderRadius.zero,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              toY: _effectiveMaxY,
              color: barColor.withOpacity(0.1),
            ),
            rodStackItems: rodStackItems,
          ),
        ],
      );
    });
  }
}
