import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

enum OrionStatChangeType { up, down }

/// Orion Stat Card widget mirroring `StatCard.jsx`
class OrionStatCard extends StatelessWidget {
  final String title;
  final String value;
  final String? change;
  final OrionStatChangeType changeType;
  final Widget? icon;
  final String? subtitle;
  final VoidCallback? onClick;
  final EdgeInsetsGeometry? padding;

  const OrionStatCard({
    super.key,
    required this.title,
    required this.value,
    this.change,
    this.changeType = OrionStatChangeType.up,
    this.icon,
    this.subtitle,
    this.onClick,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: padding ?? const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: OrionColors.bgSurface,
          border: Border.all(color: OrionColors.borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.03),
              offset: Offset(0, 1),
              blurRadius: 3,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: OrionColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (icon != null)
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: OrionColors.primaryLight,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: IconTheme(
                      data: const IconThemeData(
                        color: OrionColors.primary,
                        size: 16,
                      ),
                      child: icon!,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: OrionColors.textMain,
                letterSpacing: -0.5,
              ),
            ),
            if (change != null || subtitle != null) ...[
              const SizedBox(height: 6),
              Row(
                children: [
                  if (change != null) ...[
                    Icon(
                      changeType == OrionStatChangeType.up
                          ? Icons.arrow_outward
                          : Icons.arrow_downward,
                      size: 14,
                      color: changeType == OrionStatChangeType.up
                          ? OrionColors.statusGreen
                          : OrionColors.statusRed,
                    ),
                    const SizedBox(width: 2),
                    Text(
                      change!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: changeType == OrionStatChangeType.up
                            ? OrionColors.statusGreen
                            : OrionColors.statusRed,
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: OrionColors.textSubtle,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
