import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Counter Card widget mirroring `CounterCard.jsx` with full customization support.
class OrionCounterCard extends StatelessWidget {
  final String label;
  final dynamic count;
  final Widget? icon;
  final VoidCallback? onClick;
  final EdgeInsetsGeometry? padding;

  // Custom styling overrides (falls back to Orion defaults if null)
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final TextStyle? countStyle;
  final TextStyle? labelStyle;
  final List<BoxShadow>? boxShadow;
  final Color? iconBackgroundColor;
  final Color? iconColor;

  const OrionCounterCard({
    super.key,
    required this.label,
    required this.count,
    this.icon,
    this.onClick,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.countStyle,
    this.labelStyle,
    this.boxShadow,
    this.iconBackgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? OrionRadius.md;
    final effectiveBg = backgroundColor ?? OrionColors.bgSurface;
    final effectiveBorderColor = borderColor ?? OrionColors.borderColor;
    final effectiveBorderWidth = borderWidth ?? 1.5;

    return InkWell(
      onTap: onClick,
      borderRadius: effectiveRadius,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: effectiveBg,
          border: Border.all(color: effectiveBorderColor, width: effectiveBorderWidth),
          borderRadius: effectiveRadius,
          boxShadow: boxShadow ??
              const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.02),
                  offset: Offset(0, 1),
                  blurRadius: 3,
                ),
              ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBackgroundColor ?? OrionColors.primaryLight,
                  borderRadius: effectiveRadius,
                ),
                child: IconTheme(
                  data: IconThemeData(
                    color: iconColor ?? OrionColors.primary,
                    size: 20,
                  ),
                  child: icon!,
                ),
              ),
              const SizedBox(width: 14),
            ],
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$count',
                  style: countStyle ??
                      const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w800,
                        color: OrionColors.textMain,
                        height: 1.1,
                      ),
                ),
                Text(
                  label,
                  style: labelStyle ??
                      const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: OrionColors.textMuted,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
