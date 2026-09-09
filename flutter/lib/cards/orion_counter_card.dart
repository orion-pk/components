import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Counter Card widget mirroring `CounterCard.jsx`
class OrionCounterCard extends StatelessWidget {
  final String label;
  final dynamic count;
  final Widget? icon;
  final VoidCallback? onClick;
  final EdgeInsetsGeometry? padding;

  const OrionCounterCard({
    super.key,
    required this.label,
    required this.count,
    this.icon,
    this.onClick,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: OrionRadius.md,
      child: Container(
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        decoration: BoxDecoration(
          color: OrionColors.bgSurface,
          border: Border.all(color: OrionColors.borderColor, width: 1.5),
          borderRadius: OrionRadius.md,
          boxShadow: const [
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
                  color: OrionColors.primaryLight,
                  borderRadius: OrionRadius.md,
                ),
                child: IconTheme(
                  data: const IconThemeData(
                    color: OrionColors.primary,
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
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                    color: OrionColors.textMain,
                    height: 1.1,
                  ),
                ),
                Text(
                  label,
                  style: const TextStyle(
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
