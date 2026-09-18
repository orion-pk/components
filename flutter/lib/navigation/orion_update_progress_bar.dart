import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Update Progress Bar mirroring `UpdateProgressBar.jsx` with full customization support.
class OrionUpdateProgressBar extends StatelessWidget {
  final double progress; // 0 to 100 or 0.0 to 1.0
  final double? value; // Alias for progress
  final String statusText;
  final String? status; // Alias for statusText
  final String? label; // Alias for statusText
  final String? totalSizeText;
  final Color? color;
  final Color? backgroundColor;
  final double? height;
  final BorderRadius? borderRadius;

  const OrionUpdateProgressBar({
    super.key,
    this.progress = 0,
    this.value,
    this.statusText = 'Downloading update package...',
    this.status,
    this.label,
    this.totalSizeText,
    this.color,
    this.backgroundColor,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final rawVal = value ?? progress;
    // Normalize: if 0.0 - 1.0 is passed, scale to 0 - 100
    final numVal = rawVal <= 1.0 && rawVal > 0.0 ? (rawVal * 100) : rawVal;
    final clamped = numVal.clamp(0.0, 100.0);
    final effectiveText = label ?? status ?? statusText;
    final effectiveHeight = height ?? 8.0;
    final effectiveRadius = borderRadius ?? OrionRadius.full;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              effectiveText,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: OrionColors.textSecondary,
              ),
            ),
            Text(
              '${clamped.toInt()}% ${totalSizeText != null ? "($totalSizeText)" : ""}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: OrionColors.textSecondary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: effectiveHeight,
          decoration: BoxDecoration(
            color: backgroundColor ?? const Color(0xFFE2E8F0),
            borderRadius: effectiveRadius,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    width: constraints.maxWidth * (clamped / 100.0),
                    height: effectiveHeight,
                    decoration: BoxDecoration(
                      color: color ?? OrionColors.primary,
                      borderRadius: effectiveRadius,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
