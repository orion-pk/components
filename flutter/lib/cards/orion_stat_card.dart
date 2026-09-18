import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import '../feedback/orion_custom_loader.dart';

enum OrionStatChangeType { up, down }

/// Orion Stat Card widget mirroring `StatCard.jsx` with full customization support.
class OrionStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? change;
  final OrionStatChangeType changeType;
  final Widget? icon;
  final IconData? iconData; // Shorthand
  final String? subtitle;
  final VoidCallback? onClick;
  final VoidCallback? onTap; // Alias for onClick
  final bool isLoading;
  final String? tooltip;
  final EdgeInsetsGeometry? padding;

  // Custom styling overrides (falls back to Orion defaults if null)
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;
  final TextStyle? subtitleStyle;
  final List<BoxShadow>? boxShadow;
  final Color? iconBackgroundColor;
  final Color? iconColor;

  const OrionStatCard({
    super.key,
    required this.title,
    required this.value,
    this.change,
    this.changeType = OrionStatChangeType.up,
    this.icon,
    this.iconData,
    this.subtitle,
    this.onClick,
    this.onTap,
    this.isLoading = false,
    this.tooltip,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.titleStyle,
    this.valueStyle,
    this.subtitleStyle,
    this.boxShadow,
    this.iconBackgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(10);
    final effectiveBg = backgroundColor ?? OrionColors.bgSurface;
    final effectiveBorderColor = borderColor ?? OrionColors.borderColor;
    final effectiveBorderWidth = borderWidth ?? 1.5;
    final effectiveTap = onTap ?? onClick;
    final effectiveIcon = icon ?? (iconData != null ? Icon(iconData) : null);

    Widget card = Container(
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: effectiveBg,
        border: Border.all(color: effectiveBorderColor, width: effectiveBorderWidth),
        borderRadius: effectiveRadius,
        boxShadow: boxShadow ??
            const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.03),
                offset: Offset(0, 1),
                blurRadius: 3,
              ),
            ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: titleStyle ??
                    const TextStyle(
                      fontSize: 13,
                      color: OrionColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              if (effectiveIcon != null)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: iconBackgroundColor ?? OrionColors.primaryLight,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: IconTheme(
                    data: IconThemeData(
                      color: iconColor ?? OrionColors.primary,
                      size: 16,
                    ),
                    child: effectiveIcon,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: OrionCustomLoader(size: 20),
            )
          else
            Text(
              value,
              style: valueStyle ??
                  const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: OrionColors.textMain,
                    letterSpacing: -0.5,
                  ),
            ),
          if (change != null || subtitle != null) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                if (change != null) ...[
                  Icon(
                    changeType == OrionStatChangeType.up
                        ? Icons.arrow_outward
                        : Icons.arrow_downward,
                    size: 14,
                    color: changeType == OrionStatChangeType.up
                        ? OrionColors.statusGreen
                        : OrionColors.statusRed,
                  ),
                  const SizedBox(width: 2),
                  Text(
                    change!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: changeType == OrionStatChangeType.up
                          ? OrionColors.statusGreen
                          : OrionColors.statusRed,
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: subtitleStyle ??
                        const TextStyle(
                          fontSize: 12,
                          color: OrionColors.textSubtle,
                        ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );

    if (effectiveTap != null) {
      card = InkWell(
        onTap: effectiveTap,
        borderRadius: effectiveRadius,
        child: card,
      );
    }

    if (tooltip != null && tooltip!.isNotEmpty) {
      card = Tooltip(
        message: tooltip!,
        child: card,
      );
    }

    return card;
  }
}
