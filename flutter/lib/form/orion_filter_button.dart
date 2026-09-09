import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Filter Button mirroring `FilterButton.jsx`
class OrionFilterButton extends StatelessWidget {
  final String label;
  final int? count;
  final bool active;
  final VoidCallback? onClick;
  final EdgeInsetsGeometry? padding;

  const OrionFilterButton({
    super.key,
    this.label = 'Filter',
    this.count,
    this.active = false,
    this.onClick,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = active ? OrionColors.primary : OrionColors.borderColor;
    final bgColor = active ? OrionColors.primaryLight : Colors.white;
    final textColor = active ? OrionColors.primary : const Color(0xFF475569);
    final iconColor = active ? OrionColors.primary : OrionColors.textMuted;

    return InkWell(
      onTap: onClick,
      borderRadius: BorderRadius.circular(50),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(color: borderColor, width: 1.5),
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
            Icon(Icons.filter_list, size: 14, color: iconColor),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            if (count != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                decoration: BoxDecoration(
                  color: active ? OrionColors.primary : OrionColors.borderColor,
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
