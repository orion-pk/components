import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

enum OrionStatusType {
  success,
  warning,
  danger,
  info,
}

/// Orion Status Pill widget mirroring `StatusPill.jsx` with full styling customization.
class OrionStatusPill extends StatelessWidget {
  final String? status;
  final String? label;
  final OrionStatusType? type;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final Widget? icon;
  final String? tooltip;

  // Custom styling overrides (falls back to Orion status colors if null)
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final Color? dotColor;
  final bool showDot;

  const OrionStatusPill({
    super.key,
    this.status = 'completed',
    this.label,
    this.type,
    this.padding,
    this.textStyle,
    this.onTap,
    this.icon,
    this.tooltip,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.dotColor,
    this.showDot = true,
  });

  static (String text, OrionStatusType type) _resolveConfig(String? status, String? label, OrionStatusType? explicitType) {
    if (explicitType != null) {
      return (label ?? status ?? '', explicitType);
    }
    final key = (status ?? '').trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_');
    switch (key) {
      case 'completed':
      case 'registered':
      case 'active':
      case 'paid':
      case 'present':
      case 'success':
        return (label ?? (status != null && status.isNotEmpty ? status : 'Completed'), OrionStatusType.success);

      case 'pending':
      case 'in_consultation':
      case 'under_review':
      case 'partially_paid':
      case 'warning':
        return (label ?? (status != null && status.isNotEmpty ? status : 'Pending'), OrionStatusType.warning);

      case 'unregistered':
      case 'critical':
      case 'absent':
      case 'failed':
      case 'suspended':
      case 'unpaid':
      case 'danger':
      case 'error':
        return (label ?? (status != null && status.isNotEmpty ? status : 'Unregistered'), OrionStatusType.danger);

      case 'inactive':
      case 'draft':
      case 'info':
      default:
        return (label ?? (status != null && status.isNotEmpty ? status : 'Inactive'), OrionStatusType.info);
    }
  }

  @override
  Widget build(BuildContext context) {
    final (displayText, resolvedType) = _resolveConfig(status, label, type);

    Color defaultTextColor;
    Color defaultBgColor;
    Color defaultBorderColor;

    switch (resolvedType) {
      case OrionStatusType.success:
        defaultTextColor = OrionColors.statusGreen;
        defaultBgColor = OrionColors.statusGreenBg;
        defaultBorderColor = OrionColors.statusGreenBorder;
        break;
      case OrionStatusType.warning:
        defaultTextColor = OrionColors.statusOrange;
        defaultBgColor = OrionColors.statusOrangeBg;
        defaultBorderColor = OrionColors.statusOrangeBorder;
        break;
      case OrionStatusType.danger:
        defaultTextColor = OrionColors.statusRed;
        defaultBgColor = OrionColors.statusRedBg;
        defaultBorderColor = OrionColors.statusRedBorder;
        break;
      case OrionStatusType.info:
        defaultTextColor = OrionColors.statusBlue;
        defaultBgColor = OrionColors.statusBlueBg;
        defaultBorderColor = OrionColors.statusBlueBorder;
        break;
    }

    final effectiveTextColor = textColor ?? defaultTextColor;
    final effectiveBgColor = backgroundColor ?? defaultBgColor;
    final effectiveBorderColor = borderColor ?? defaultBorderColor;
    final effectiveBorderWidth = borderWidth ?? 1.0;
    final effectiveRadius = borderRadius ?? OrionRadius.full;
    final effectiveDotColor = dotColor ?? effectiveTextColor;

    Widget pill = Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: effectiveRadius,
        border: Border.all(color: effectiveBorderColor, width: effectiveBorderWidth),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            IconTheme(
              data: IconThemeData(color: effectiveTextColor, size: 12),
              child: icon!,
            ),
            const SizedBox(width: 4),
          ] else if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: effectiveDotColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
          Text(
            displayText,
            style: textStyle ??
                TextStyle(
                  color: effectiveTextColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
          ),
        ],
      ),
    );

    if (onTap != null) {
      pill = InkWell(
        onTap: onTap,
        borderRadius: effectiveRadius,
        child: pill,
      );
    }

    if (tooltip != null && tooltip!.isNotEmpty) {
      pill = Tooltip(
        message: tooltip!,
        child: pill,
      );
    }

    return pill;
  }
}
