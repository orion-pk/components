import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

enum OrionStatusType {
  success,
  warning,
  danger,
  info,
}

/// Orion Status Pill widget mirroring `StatusPill.jsx`
class OrionStatusPill extends StatelessWidget {
  final String status;
  final String? label;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;

  const OrionStatusPill({
    super.key,
    this.status = 'completed',
    this.label,
    this.padding,
    this.textStyle,
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

    Color textColor;
    Color bgColor;
    Color borderColor;

    switch (type) {
      case OrionStatusType.success:
        textColor = OrionColors.statusGreen;
        bgColor = OrionColors.statusGreenBg;
        borderColor = OrionColors.statusGreenBorder;
        break;
      case OrionStatusType.warning:
        textColor = OrionColors.statusOrange;
        bgColor = OrionColors.statusOrangeBg;
        borderColor = OrionColors.statusOrangeBorder;
        break;
      case OrionStatusType.danger:
        textColor = OrionColors.statusRed;
        bgColor = OrionColors.statusRedBg;
        borderColor = OrionColors.statusRedBorder;
        break;
      case OrionStatusType.info:
        textColor = OrionColors.statusBlue;
        bgColor = OrionColors.statusBlueBg;
        borderColor = OrionColors.statusBlueBorder;
        break;
    }

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: OrionRadius.full,
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(
              color: textColor,
              shape: BoxShape.circle,
            ),
          ),
          Text(
            displayText,
            style: textStyle ??
                TextStyle(
                  color: textColor,
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
