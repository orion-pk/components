import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Global Permissions Badge widget mirroring `GlobalPermissionsBadge.jsx`
class OrionGlobalPermissionsBadge extends StatelessWidget {
  final String role;
  final int? permissionsCount;
  final String? customText;
  final EdgeInsetsGeometry? padding;

  const OrionGlobalPermissionsBadge({
    super.key,
    this.role = 'Super Admin',
    this.permissionsCount,
    this.customText,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final text = customText ??
        (permissionsCount != null ? '$role ($permissionsCount Permissions)' : role);

    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: OrionColors.primaryLight,
        borderRadius: OrionRadius.full,
        border: Border.all(color: OrionColors.primaryBorder, width: 1.5),
        boxShadow: const [
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
          const Icon(
            Icons.shield_outlined,
            size: 16,
            color: OrionColors.primary,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: OrionColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}
