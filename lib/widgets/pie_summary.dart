import 'dart:math';
import 'package:flutter/material.dart';
import '../models/pie_data.dart';
import '../theme/theme_data.dart';

/// Legend position for PieSummary widget
enum LegendPosition { right, bottom }

/// A radial chart showing proportions with custom labels and colors
class PieSummary extends StatefulWidget {
  /// The data to be displayed in the pie chart
  final List<PieData> data;
  
  /// The radius of the pie chart
  final double radius;
  
  /// The stroke width of the pie sections
  final double sectionStrokeWidth;
  
  /// The space between pie sections
  final double sectionSpace;
  
  /// The position of the legend
  final LegendPosition legendPosition;
  
  /// Whether to show the legend
  final bool showLegend;
  
  /// The text style for the legend labels
  final TextStyle? legendTextStyle;
  
  /// Optional center widget (e.g., "Total" text)
  final Widget? centerWidget;
  
  /// The animation duration for the pie chart
  final Duration animationDuration;
  
  /// The decoration for the container
  final BoxDecoration? decoration;
  
  /// The padding for the container
  final EdgeInsetsGeometry padding;
  
  /// Custom builder for the section labels
  final Widget Function(BuildContext context, PieData data, int index)? sectionLabelBuilder;
  
  /// Custom tooltip builder
  final Widget Function(BuildContext context, PieData data, int index)? tooltipBuilder;

  /// Creates a PieSummary widget
  const PieSummary({
    Key? key,
    required this.data,
    this.radius = 100.0,
    this.sectionStrokeWidth = 20.0,
    this.sectionSpace = 2.0,
    this.legendPosition = LegendPosition.right,
    this.showLegend = true,
    this.legendTextStyle,
    this.centerWidget,
    this.animationDuration = const Duration(milliseconds: 500),
    this.decoration,
    this.padding = const EdgeInsets.all(16.0),
    this.sectionLabelBuilder,
    this.tooltipBuilder,
  }) : super(key: key);

  @override
  State<PieSummary> createState() => _PieSummaryState();
}

class _PieSummaryState extends State<PieSummary> with SingleTickerProviderStateMixin {
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
      child: widget.legendPosition == LegendPosition.right
          ? Row(
              children: [
                Expanded(child: _buildChart()),
                if (widget.showLegend) const SizedBox(width: 16),
                if (widget.showLegend) _buildLegend(),
              ],
            )
          : Column(
              children: [
                Expanded(child: _buildChart()),
                if (widget.showLegend) const SizedBox(height: 16),
                if (widget.showLegend) _buildLegend(),
              ],
            ),
    );
  }

  Widget _buildChart() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: widget.radius * 2,
          height: widget.radius * 2,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: PieChartPainter(
                  data: widget.data,
                  animation: _animation.value,
                  hoveredIndex: hoveredIndex,
                  sectionSpace: widget.sectionSpace,
                  centerRadius: widget.radius / 2,
                  sectionStrokeWidth: widget.sectionStrokeWidth,
                ),
                size: Size(widget.radius * 2, widget.radius * 2),
              );
            },
          ),
        ),
        if (hoveredIndex != null && hoveredIndex! >= 0 && hoveredIndex! < widget.data.length && widget.tooltipBuilder != null)
          widget.tooltipBuilder!(context, widget.data[hoveredIndex!], hoveredIndex!),
        if (widget.centerWidget != null) widget.centerWidget!,
      ],
    );
  }

  Widget _buildLegend() {
    final effectiveLegendTextStyle = widget.legendTextStyle ?? 
        MiniDashboardTheme.adaptiveTextStyle(
          context,
          Theme.of(context).textTheme.bodyMedium!,
          Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white70),
        );

    return widget.legendPosition == LegendPosition.right
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widget.data.asMap().entries.map((entry) {
              final i = entry.key;
              final data = entry.value;
              final isHovered = i == hoveredIndex;
              
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: MouseRegion(
                  onEnter: (_) => setState(() => hoveredIndex = i),
                  onExit: (_) => setState(() => hoveredIndex = null),
                  child: _buildLegendItem(data, i, isHovered, effectiveLegendTextStyle),
                ),
              );
            }).toList(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.data.asMap().entries.map((entry) {
              final i = entry.key;
              final data = entry.value;
              final isHovered = i == hoveredIndex;
              
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: MouseRegion(
                  onEnter: (_) => setState(() => hoveredIndex = i),
                  onExit: (_) => setState(() => hoveredIndex = null),
                  child: _buildLegendItem(data, i, isHovered, effectiveLegendTextStyle),
                ),
              );
            }).toList(),
          );
  }

  Widget _buildLegendItem(PieData data, int index, bool isHovered, TextStyle textStyle) {
    if (widget.sectionLabelBuilder != null) {
      return widget.sectionLabelBuilder!(context, data, index);
    }
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: data.color,
            shape: BoxShape.circle,
            border: isHovered ? Border.all(color: Colors.black, width: 2) : null,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${data.label} (${data.value.toStringAsFixed(1)}%)',
          style: textStyle.copyWith(
            fontWeight: isHovered ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<PieData> data;
  final double animation;
  final int? hoveredIndex;
  final double sectionSpace;
  final double centerRadius;
  final double sectionStrokeWidth;
  
  PieChartPainter({
    required this.data,
    required this.animation,
    this.hoveredIndex,
    required this.sectionSpace,
    required this.centerRadius,
    required this.sectionStrokeWidth,
  });
  
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - (sectionStrokeWidth / 2);
    
    // Calculate total value for percentages
    final total = data.fold(0.0, (sum, item) => sum + item.value);
    
    // Setup paint for sections
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = sectionStrokeWidth
      ..strokeCap = StrokeCap.round;
    
    double startAngle = -pi / 2; // Start from top (negative Y axis)
    
    for (int i = 0; i < data.length; i++) {
      final item = data[i];
      final isHovered = i == hoveredIndex;
      
      // Calculate sweep angle based on percentage of total
      final percent = item.value / total;
      final sweepAngle = 2 * pi * percent * animation;
      
      // Set section color
      paint.color = item.color;
      
      // If hovered, extend the radius slightly
      final effectiveRadius = isHovered ? radius * 1.05 : radius;
      
      // Draw arc
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: effectiveRadius),
        startAngle,
        sweepAngle - (sectionSpace / effectiveRadius), // Subtract space between sections
        false,
        paint,
      );
      
      // Move to next section
      startAngle += sweepAngle;
    }
    
    // Draw center circle
    if (centerRadius > 0) {
      final centerPaint = Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white.withOpacity(0.8);
      
      canvas.drawCircle(center, centerRadius, centerPaint);
    }
  }
  
  @override
  bool shouldRepaint(covariant PieChartPainter oldDelegate) {
    return oldDelegate.animation != animation ||
           oldDelegate.hoveredIndex != hoveredIndex ||
           oldDelegate.data != data;
  }
}
