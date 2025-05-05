import 'package:flutter/material.dart';

/// A customizable card widget for displaying statistics with an icon, title, and value.
class StatCard extends StatelessWidget {
  /// The title text displayed in the card.
  final String title;
  
  /// The value text displayed in the card.
  final String value;
  
  /// The icon displayed in the card.
  final IconData icon;
  
  /// The color of the icon.
  final Color iconColor;
  
  /// The background color of the card.
  final Color backgroundColor;
  
  /// The style for the title text.
  final TextStyle? titleStyle;
  
  /// The style for the value text.
  final TextStyle? valueStyle;
  
  /// The box decoration for the card.
  final BoxDecoration? decoration;
  
  /// An optional widget displayed at the trailing end of the card.
  final Widget? trailing;
  
  /// The callback when the card is tapped.
  final VoidCallback? onTap;
  
  /// The padding inside the card.
  final EdgeInsetsGeometry padding;
  
  /// The margin around the card.
  final EdgeInsetsGeometry margin;
  
  /// The border radius of the card.
  final BorderRadiusGeometry borderRadius;
  
  /// The elevation of the card.
  final double elevation;
  
  /// Optional builder for customizing the title widget.
  final Widget Function(BuildContext, String)? titleBuilder;
  
  /// Optional builder for customizing the value widget.
  final Widget Function(BuildContext, String)? valueBuilder;
  
  /// Optional builder for customizing the icon widget.
  final Widget Function(BuildContext, IconData, Color)? iconBuilder;
  
  /// An optional header widget displayed at the top of the card.
  final Widget? header;
  
  /// An optional footer widget displayed at the bottom of the card.
  final Widget? footer;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor = Colors.blue,
    this.backgroundColor = Colors.white,
    this.titleStyle,
    this.valueStyle,
    this.decoration,
    this.trailing,
    this.onTap,
    this.padding = const EdgeInsets.all(16.0),
    this.margin = const EdgeInsets.all(8.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(12.0)),
    this.elevation = 2.0,
    this.titleBuilder,
    this.valueBuilder,
    this.iconBuilder,
    this.header,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final defaultTitleStyle = theme.textTheme.titleMedium?.copyWith(
      color: theme.textTheme.titleMedium?.color?.withOpacity(0.8),
    );
    
    final defaultValueStyle = theme.textTheme.headlineSmall?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Material(
      elevation: elevation,
      borderRadius: borderRadius,
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius,
        child: Container(
          padding: padding,
          margin: margin,
          decoration: decoration ?? BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (header != null) 
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: header!,
                ),
              Row(
                children: [
                  _buildIcon(context),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle(context, defaultTitleStyle),
                        const SizedBox(height: 4),
                        _buildValue(context, defaultValueStyle),
                      ],
                    ),
                  ),
                  if (trailing != null) trailing!,
                ],
              ),
              if (footer != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: footer!,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    if (iconBuilder != null) {
      return iconBuilder!(context, icon, iconColor);
    }
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: 24,
      ),
    );
  }

  Widget _buildTitle(BuildContext context, TextStyle? defaultStyle) {
    if (titleBuilder != null) {
      return titleBuilder!(context, title);
    }
    
    return Text(
      title,
      style: titleStyle ?? defaultStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildValue(BuildContext context, TextStyle? defaultStyle) {
    if (valueBuilder != null) {
      return valueBuilder!(context, value);
    }
    
    return Text(
      value,
      style: valueStyle ?? defaultStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
