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
  final String status;
  final String? label;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

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
    this.padding,
    this.textStyle,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.dotColor,
    this.showDot = true,
  });

  static (String text, OrionStatusType type) _resolveConfig(String status, String? label) {
    final key = status.trim().toLowerCase().replaceAll(RegExp(r'\s+'), '_');
    switch (key) {
      case 'completed':
        return (label ?? 'Completed', OrionStatusType.success);
      case 'registered':
        return (label ?? 'Registered', OrionStatusType.success);
      case 'active':
        return (label ?? 'Active', OrionStatusType.success);
      case 'paid':
        return (label ?? 'Paid', OrionStatusType.success);
      case 'present':
        return (label ?? 'Present', OrionStatusType.success);

      case 'pending':
        return (label ?? 'Pending', OrionStatusType.warning);
      case 'in_consultation':
        return (label ?? 'In Consultation', OrionStatusType.warning);
      case 'under_review':
        return (label ?? 'Under Review', OrionStatusType.warning);
      case 'partially_paid':
        return (label ?? 'Partially Paid', OrionStatusType.warning);

      case 'unregistered':
        return (label ?? 'Unregistered', OrionStatusType.danger);
      case 'critical':
        return (label ?? 'Critical', OrionStatusType.danger);
      case 'absent':
        return (label ?? 'Absent', OrionStatusType.danger);
      case 'failed':
        return (label ?? 'Failed', OrionStatusType.danger);
      case 'suspended':
        return (label ?? 'Suspended', OrionStatusType.danger);
      case 'unpaid':
        return (label ?? 'Unpaid', OrionStatusType.danger);

      case 'inactive':
        return (label ?? 'Inactive', OrionStatusType.info);
      case 'draft':
        return (label ?? 'Draft', OrionStatusType.info);

      default:
        return (label ?? status, OrionStatusType.info);
    }
  }

  @override
  Widget build(BuildContext context) {
    final (displayText, type) = _resolveConfig(status, label);

    Color defaultTextColor;
    Color defaultBgColor;
    Color defaultBorderColor;

    switch (type) {
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

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: effectiveBgColor,
        borderRadius: effectiveRadius,
        border: Border.all(color: effectiveBorderColor, width: effectiveBorderWidth),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot)
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: effectiveDotColor,
                shape: BoxShape.circle,
              ),
            ),
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
  }
}
