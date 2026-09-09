import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Filter Button mirroring `FilterButton.jsx` with full customization support.
class OrionFilterButton extends StatelessWidget {
  final String label;
  final int? count;
  final bool active;
  final VoidCallback? onClick;
  final EdgeInsetsGeometry? padding;

  // Custom styling overrides (falls back to Orion defaults if null)
  final Color? activeBackgroundColor;
  final Color? inactiveBackgroundColor;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;

  const OrionFilterButton({
    super.key,
    this.label = 'Filter',
    this.count,
    this.active = false,
    this.onClick,
    this.padding,
    this.activeBackgroundColor,
    this.inactiveBackgroundColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
    this.borderRadius,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderColor = active
        ? (activeBorderColor ?? OrionColors.primary)
        : (inactiveBorderColor ?? OrionColors.borderColor);

    final effectiveBg = active
        ? (activeBackgroundColor ?? OrionColors.primaryLight)
        : (inactiveBackgroundColor ?? Colors.white);

    final effectiveTextColor = active
        ? (activeTextColor ?? OrionColors.primary)
        : (inactiveTextColor ?? const Color(0xFF475569));

    final effectiveIconColor = active
        ? (activeTextColor ?? OrionColors.primary)
        : (inactiveTextColor ?? OrionColors.textMuted);

    final effectiveRadius = borderRadius ?? BorderRadius.circular(50);

    return InkWell(
      onTap: onClick,
      borderRadius: effectiveRadius,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: effectiveBg,
          borderRadius: effectiveRadius,
          border: Border.all(color: effectiveBorderColor, width: 1.5),
          boxShadow: active
              ? const [
                  BoxShadow(
                    color: Color.fromRGBO(2, 101, 139, 0.1),
                    offset: Offset(0, 1),
                    blurRadius: 3,
                  )
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.filter_list, size: 14, color: effectiveIconColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: textStyle ??
                  TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: effectiveTextColor,
                  ),
            ),
            if (count != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: active
                      ? (activeBorderColor ?? OrionColors.primary)
                      : (inactiveBorderColor ?? OrionColors.borderColor),
                  borderRadius: OrionRadius.full,
                ),
                child: Text(
                  '$count',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
