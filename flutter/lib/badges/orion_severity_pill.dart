import 'package:flutter/material.dart';
import 'orion_status_pill.dart';

/// Orion Severity Pill widget mirroring `SeverityPill.jsx` with full customization support.
class OrionSeverityPill extends StatelessWidget {
  final String severity;
  final String? label;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final Widget? icon;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final Color? dotColor;
  final bool showDot;

  const OrionSeverityPill({
    super.key,
    this.severity = 'minor',
    this.label,
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

  static (String text, String mappedStatus) _resolve(String severity, String? label) {
    final key = severity.trim().toLowerCase();
    switch (key) {
      case 'minor':
        return (label ?? 'Minor Severity', 'active');
      case 'low':
        return (label ?? 'Low Risk', 'active');
      case 'moderate':
        return (label ?? 'Moderate Severity', 'pending');
      case 'medium':
        return (label ?? 'Medium Risk', 'pending');
      case 'major':
        return (label ?? 'Major Severity', 'critical');
      case 'high':
        return (label ?? 'High Risk', 'critical');
      case 'critical':
        return (label ?? 'Critical Severity', 'critical');
      default:
        return (label ?? 'Minor Severity', 'active');
    }
  }

  @override
  Widget build(BuildContext context) {
    final (displayText, mappedStatus) = _resolve(severity, label);
    return OrionStatusPill(
      status: mappedStatus,
      label: displayText,
      padding: padding,
      textStyle: textStyle,
      onTap: onTap,
      icon: icon,
      tooltip: tooltip,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderColor: borderColor,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      dotColor: dotColor,
      showDot: showDot,
    );
  }
}
