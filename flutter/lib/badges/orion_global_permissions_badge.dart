import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Global Permissions Badge widget mirroring `GlobalPermissionsBadge.jsx` with full customization support.
class OrionGlobalPermissionsBadge extends StatelessWidget {
  final String role;
  final int? permissionsCount;
  final String? customText;
  final EdgeInsetsGeometry? padding;

  // Custom styling overrides (falls back to Orion defaults if null)
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final List<BoxShadow>? boxShadow;

  const OrionGlobalPermissionsBadge({
    super.key,
    this.role = 'Super Admin',
    this.permissionsCount,
    this.customText,
    this.padding,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.textStyle,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final text = customText ??
        (permissionsCount != null ? '$role ($permissionsCount Permissions)' : role);

    final effectiveBg = backgroundColor ?? OrionColors.primaryLight;
    final effectiveText = textColor ?? OrionColors.primary;
    final effectiveBorder = borderColor ?? OrionColors.primaryBorder;
    final effectiveWidth = borderWidth ?? 1.5;
    final effectiveRadius = borderRadius ?? OrionRadius.full;
    final effectiveIcon = icon ?? Icons.shield_outlined;
    final effectiveIconSize = iconSize ?? 16.0;
    final effectiveIconColor = iconColor ?? effectiveText;

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: effectiveRadius,
        border: Border.all(color: effectiveBorder, width: effectiveWidth),
        boxShadow: boxShadow ??
            const [
              BoxShadow(
                color: Color.fromRGBO(2, 101, 139, 0.05),
                offset: Offset(0, 1),
                blurRadius: 2,
              ),
            ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            effectiveIcon,
            size: effectiveIconSize,
            color: effectiveIconColor,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: textStyle ??
                TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: effectiveText,
                ),
          ),
        ],
      ),
    );
  }
}
