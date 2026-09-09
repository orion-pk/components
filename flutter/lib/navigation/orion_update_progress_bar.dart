import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Update Progress Bar mirroring `UpdateProgressBar.jsx`
class OrionUpdateProgressBar extends StatelessWidget {
  final double progress; // 0 to 100
  final String statusText;
  final String? totalSizeText;

  const OrionUpdateProgressBar({
    super.key,
    this.progress = 0,
    this.statusText = 'Downloading update package...',
    this.totalSizeText,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 100.0);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              statusText,
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
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFFE2E8F0),
            borderRadius: OrionRadius.full,
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    width: constraints.maxWidth * (clamped / 100.0),
                    height: 8,
                    decoration: BoxDecoration(
                      color: OrionColors.primary,
                      borderRadius: OrionRadius.full,
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
