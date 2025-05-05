import 'package:flutter/material.dart';
import '../theme/theme_data.dart';

/// A modern, customizable stat card widget with icon, title, and value
class StatCard extends StatelessWidget {
  /// The title to be displayed in the card
  final String title;
  
  /// The value to be displayed in the card
  final String value;
  
  /// The icon to be displayed in the card
  final IconData icon;
  
  /// The color of the icon
  final Color? iconColor;
  
  /// The background color of the card
  final Color? backgroundColor;
  
  /// The text style for the title
  final TextStyle? titleStyle;
  
  /// The text style for the value
  final TextStyle? valueStyle;
  
  /// The decoration for the card
  final BoxDecoration? decoration;
  
  /// The padding for the card contents
  final EdgeInsetsGeometry padding;
  
  /// Optional trailing widget (e.g., badge or arrow)
  final Widget? trailing;
  
  /// Border radius for the card
  final double borderRadius;
  
  /// The elevation of the card
  final double elevation;
  
  /// Callback function when the card is tapped
  final VoidCallback? onTap;
  
  /// Custom builder for the title
  final Widget Function(BuildContext context, String title)? titleBuilder;
  
  /// Custom builder for the icon
  final Widget Function(BuildContext context, IconData icon, Color? color)? iconBuilder;
  
  /// Creates a StatCard widget
  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
    this.backgroundColor,
    this.titleStyle,
    this.valueStyle,
    this.decoration,
    this.padding = const EdgeInsets.all(16.0),
    this.trailing,
    this.borderRadius = 12.0,
    this.elevation = 2.0,
    this.onTap,
    this.titleBuilder,
    this.iconBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? 
        MiniDashboardTheme.adaptiveColor(
          context,
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor.withOpacity(0.8),
        );

    final effectiveTitleStyle = titleStyle ?? 
        MiniDashboardTheme.adaptiveTextStyle(
          context,
          MiniDashboardTheme.defaultLightTitleStyle(context),
          MiniDashboardTheme.defaultDarkTitleStyle(context),
        );

    final effectiveValueStyle = valueStyle ?? 
        MiniDashboardTheme.adaptiveTextStyle(
          context,
          MiniDashboardTheme.defaultLightValueStyle(context),
          MiniDashboardTheme.defaultDarkValueStyle(context),
        );
    
    return Card(
      elevation: elevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      color: backgroundColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: Container(
          decoration: decoration,
          padding: padding,
          child: Row(
            children: [
              _buildIcon(context, effectiveIconColor),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(context, effectiveTitleStyle),
                    const SizedBox(height: 4),
                    Text(value, style: effectiveValueStyle),
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context, Color effectiveIconColor) {
    if (iconBuilder != null) {
      return iconBuilder!(context, icon, effectiveIconColor);
    }
    
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: effectiveIconColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: effectiveIconColor, size: 24),
    );
  }

  Widget _buildTitle(BuildContext context, TextStyle effectiveTitleStyle) {
    if (titleBuilder != null) {
      return titleBuilder!(context, title);
    }
    
    return Text(title, style: effectiveTitleStyle);
  }
}
