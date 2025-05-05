import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/pie_data.dart';

/// Position of the legend relative to the pie chart
enum LegendPosition { top, bottom, left, right }

/// A customizable pie chart widget for displaying statistical data.
class PieSummary extends StatefulWidget {
  /// The list of data items to display in the pie chart.
  final List<PieData> data;
  
  /// The position of the legend.
  final LegendPosition legendPosition;
  
  /// Whether to show the legend.
  final bool showLegend;
  
  /// The style for the legend text.
  final TextStyle? legendStyle;
  
  /// The radius of the pie chart.
  final double radius;
  
  /// The width of the pie chart stroke.
  final double strokeWidth;
  
  /// Whether to animate the pie chart when first displayed.
  final bool animate;
  
  /// The duration of the animation.
  final Duration animationDuration;
  
  /// The label to display in the center of the pie chart.
  final String? centerLabel;
  
  /// The style for the center label.
  final TextStyle? centerLabelStyle;
  
  /// The spacing between the legend items.
  final double legendSpacing;
  
  /// The icon size for the legend items.
  final double legendIconSize;
  
  /// The padding inside the widget.
  final EdgeInsetsGeometry padding;
  
  /// The borderRadius for the widget container.
  final BorderRadius borderRadius;
  
  /// The background color for the widget.
  final Color backgroundColor;
  
  /// Optional: Function to build custom legend items.
  final Widget Function(PieData, int)? legendItemBuilder;
  
  /// Optional: Function to build the center content.
  final Widget Function()? centerContentBuilder;

  const PieSummary({
    Key? key,
    required this.data,
    this.legendPosition = LegendPosition.bottom,
    this.showLegend = true,
    this.legendStyle,
    this.radius = 100.0,
    this.strokeWidth = 20.0,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 800),
    this.centerLabel,
    this.centerLabelStyle,
    this.legendSpacing = 8.0,
    this.legendIconSize = 12.0,
    this.padding = const EdgeInsets.all(16.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.backgroundColor = Colors.white,
    this.legendItemBuilder,
    this.centerContentBuilder,
  }) : super(key: key);

  @override
  State<PieSummary> createState() => _PieSummaryState();
}

class _PieSummaryState extends State<PieSummary> {
  int touchedIndex = -1;

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
      child: _buildLayout(),
    );
  }

  Widget _buildLayout() {
    switch (widget.legendPosition) {
      case LegendPosition.top:
        return Column(
          children: [
            if (widget.showLegend) _buildLegend(),
            if (widget.showLegend) SizedBox(height: widget.legendSpacing),
            Expanded(child: _buildPieChart()),
          ],
        );
      case LegendPosition.bottom:
        return Column(
          children: [
            Expanded(child: _buildPieChart()),
            if (widget.showLegend) SizedBox(height: widget.legendSpacing),
            if (widget.showLegend) _buildLegend(),
          ],
        );
      case LegendPosition.left:
        return Row(
          children: [
            if (widget.showLegend) _buildLegend(),
            if (widget.showLegend) SizedBox(width: widget.legendSpacing),
            Expanded(child: _buildPieChart()),
          ],
        );
      case LegendPosition.right:
        return Row(
          children: [
            Expanded(child: _buildPieChart()),
            if (widget.showLegend) SizedBox(width: widget.legendSpacing),
            if (widget.showLegend) _buildLegend(),
          ],
        );
    }
  }

  Widget _buildPieChart() {
    return AspectRatio(
      aspectRatio: 1,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (FlTouchEvent event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse == null ||
                    pieTouchResponse.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          borderData: FlBorderData(show: false),
          sectionsSpace: 0,
          centerSpaceRadius: widget.radius - widget.strokeWidth,
          sections: _buildSections(),
        ),
        swapAnimationDuration: widget.animate ? widget.animationDuration : Duration.zero,
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    double total = widget.data.fold(0, (sum, item) => sum + item.value);
    
    return List.generate(widget.data.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? widget.radius * 1.1 : widget.radius;
      final widgetSize = isTouched ? 55.0 : 40.0;
      final percent = (widget.data[i].value / total * 100).toStringAsFixed(1);

      return PieChartSectionData(
        color: widget.data[i].color,
        value: widget.data[i].value,
        title: '$percent%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
        ),
        badgeWidget: _Badge(
          size: widgetSize,
          borderColor: widget.data[i].color,
        ),
        badgePositionPercentageOffset: .98,
        titlePositionPercentageOffset: 0.5,
      );
    });
  }

  Widget _buildLegend() {
    final isHorizontal = widget.legendPosition == LegendPosition.top || 
                         widget.legendPosition == LegendPosition.bottom;
    
    final theme = Theme.of(context);
    final defaultLegendStyle = theme.textTheme.bodyMedium;
    
    if (isHorizontal) {
      return Wrap(
        spacing: 16.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.center,
        children: List.generate(widget.data.length, (index) {
          return widget.legendItemBuilder != null
              ? widget.legendItemBuilder!(widget.data[index], index)
              : _buildLegendItem(index, defaultLegendStyle);
        }),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(widget.data.length, (index) {
            return widget.legendItemBuilder != null
                ? widget.legendItemBuilder!(widget.data[index], index)
                : _buildLegendItem(index, defaultLegendStyle);
          }),
        ),
      );
    }
  }

  Widget _buildLegendItem(int index, TextStyle? defaultStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: widget.legendIconSize,
            height: widget.legendIconSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.data[index].color,
            ),
          ),
          const SizedBox(width: 8.0),
          Flexible(
            child: Text(
              widget.data[index].label,
              style: widget.legendStyle ?? defaultStyle,
              overflow: TextOverflow.ellipsis,
            ),
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
}

class _Badge extends StatelessWidget {
  final double size;
  final Color borderColor;

  const _Badge({
    required this.size,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          )
        ],
      ),
    );
  }
}
