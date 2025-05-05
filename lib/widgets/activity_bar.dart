import 'package:flutter/material.dart';
import '../models/bar_data.dart';
import '../theme/theme_data.dart';

/// Orientation for ActivityBar widget
enum BarOrientation { horizontal, vertical }

/// A customizable bar chart for displaying activity or trends
class ActivityBar extends StatefulWidget {
  /// The data to be displayed in the bar chart
  final List<BarData> data;
  
  /// The orientation of the bars
  final BarOrientation orientation;
  
  /// The width of each bar
  final double barWidth;
  
  /// The border radius of each bar
  final double barRadius;
  
  /// The text style for the axis labels
  final TextStyle? axisLabelStyle;
  
  /// Whether to show grid lines
  final bool showGridLines;
  
  /// The color of the grid lines
  final Color? gridLineColor;
  
  /// The animation duration for the bars
  final Duration animationDuration;
  
  /// The decoration for the container
  final BoxDecoration? decoration;
  
  /// The padding for the container
  final EdgeInsetsGeometry padding;
  
  /// The space between the bars
  final double barSpacing;
  
  /// Maximum value for the Y axis. If null, it's calculated from the data
  final double? maxY;
  
  /// Custom tooltip builder for bar sections
  final Widget Function(BuildContext context, BarData data, int index)? tooltipBuilder;
  
  /// Custom label builder for X axis
  final Widget Function(BuildContext context, String label, int index)? xAxisLabelBuilder;

  /// Creates an ActivityBar widget
  const ActivityBar({
    Key? key,
    required this.data,
    this.orientation = BarOrientation.vertical,
    this.barWidth = 16.0,
    this.barRadius = 6.0,
    this.axisLabelStyle,
    this.showGridLines = true,
    this.gridLineColor,
    this.animationDuration = const Duration(milliseconds: 500),
    this.decoration,
    this.padding = const EdgeInsets.all(16.0),
    this.barSpacing = 16.0,
    this.maxY,
    this.tooltipBuilder,
    this.xAxisLabelBuilder,
  }) : super(key: key);

  @override
  State<ActivityBar> createState() => _ActivityBarState();
}

class _ActivityBarState extends State<ActivityBar> with SingleTickerProviderStateMixin {
  int? hoveredIndex;
  late AnimationController _animationController;
  late Animation<double> _animation;
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      padding: widget.padding,
      child: widget.orientation == BarOrientation.vertical
          ? _buildVerticalBarChart()
          : _buildHorizontalBarChart(),
    );
  }

  Widget _buildVerticalBarChart() {
    final effectiveAxisLabelStyle = widget.axisLabelStyle ?? 
        MiniDashboardTheme.adaptiveTextStyle(
          context,
          Theme.of(context).textTheme.bodySmall!,
          Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white70),
        );
    
    final effectiveGridLineColor = widget.gridLineColor ?? 
        MiniDashboardTheme.adaptiveColor(
          context,
          Colors.grey.shade200,
          Colors.grey.shade800,
        );
    
    final calculatedMaxY = widget.maxY ?? 
        widget.data.fold(0.0, (max, data) => data.value > max ? data.value : max) * 1.2;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Y-axis labels
                  SizedBox(
                    width: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(6, (index) {
                        final value = (calculatedMaxY / 5 * (5 - index)).toInt();
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            value.toString(),
                            style: effectiveAxisLabelStyle,
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Chart area
                  Expanded(
                    child: Stack(
                      children: [
                        // Grid lines
                        if (widget.showGridLines)
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(6, (index) {
                              return Container(
                                height: 1,
                                color: effectiveGridLineColor,
                              );
                            }),
                          ),
                        // Bars
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: widget.data.asMap().entries.map((entry) {
                                final index = entry.key;
                                final data = entry.value;
                                final isHovered = index == hoveredIndex;
                                
                                // Calculate bar height based on animation
                                final normalizedValue = data.value / calculatedMaxY;
                                final barHeight = normalizedValue * constraints.maxHeight * _animation.value;
                                
                                final barColor = data.color ?? 
                                  MiniDashboardTheme.adaptiveColor(
                                    context,
                                    MiniDashboardTheme.defaultLightColors[index % MiniDashboardTheme.defaultLightColors.length],
                                    MiniDashboardTheme.defaultDarkColors[index % MiniDashboardTheme.defaultDarkColors.length],
                                  );
                                
                                return MouseRegion(
                                  onEnter: (_) => setState(() => hoveredIndex = index),
                                  onExit: (_) => setState(() => hoveredIndex = null),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      if (isHovered && widget.tooltipBuilder != null)
                                        widget.tooltipBuilder!(context, data, index),
                                      Container(
                                        width: widget.barWidth,
                                        height: barHeight,
                                        decoration: BoxDecoration(
                                          color: barColor,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(widget.barRadius),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // X-axis labels
            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: widget.data.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  
                  if (widget.xAxisLabelBuilder != null) {
                    return widget.xAxisLabelBuilder!(context, data.label, index);
                  }
                  
                  return Text(
                    data.label,
                    style: effectiveAxisLabelStyle,
                    textAlign: TextAlign.center,
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Builds a horizontal bar chart by rotating the vertical chart
  /// 
  /// Instead of duplicating the complex layout logic, this method simply
  /// rotates the vertical chart by 90 degrees. This approach ensures
  /// consistent behavior and appearance between both orientations while
  /// minimizing code duplication.
  /// 
  /// Returns a widget containing the horizontal bar chart.
  Widget _buildHorizontalBarChart() {
    // For simplicity, we'll just rotate the vertical chart
    return RotatedBox(
      quarterTurns: 1,
      child: _buildVerticalBarChart(),
    );
  }
}
