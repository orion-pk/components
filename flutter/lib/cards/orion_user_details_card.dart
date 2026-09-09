import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion User Details Card widget mirroring `UserDetailsCard.jsx`
class OrionUserDetailsCard extends StatelessWidget {
  final String name;
  final String email;
  final String role;
  final String? phoneNumber;
  final String? cnic;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onCopyInvite;
  final EdgeInsetsGeometry? padding;

  const OrionUserDetailsCard({
    super.key,
    required this.name,
    required this.email,
    required this.role,
    this.phoneNumber,
    this.cnic,
    this.onEdit,
    this.onDelete,
    this.onCopyInvite,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().isNotEmpty
        ? name.trim().substring(0, name.trim().length >= 2 ? 2 : 1).toUpperCase()
        : 'U';

    return Container(
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
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              Container(
                width: 46,
                height: 46,
                decoration: const BoxDecoration(
                  color: OrionColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  initials,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: OrionColors.textMain,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          email,
                          style: const TextStyle(
                            fontSize: 13,
                            color: OrionColors.textMuted,
                          ),
                        ),
                        const Text('•', style: TextStyle(color: OrionColors.textMuted)),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: OrionColors.primaryLight,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            role,
                            style: const TextStyle(
                              color: OrionColors.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        if (phoneNumber != null) ...[
                          const Text('•', style: TextStyle(color: OrionColors.textMuted)),
                          Text(
                            phoneNumber!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: OrionColors.textMuted,
                            ),
                          ),
                        ],
                        if (cnic != null) ...[
                          const Text('•', style: TextStyle(color: OrionColors.textMuted)),
                          Text(
                            'CNIC: $cnic',
                            style: const TextStyle(
                              fontSize: 13,
                              color: OrionColors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (onCopyInvite != null || onEdit != null || onDelete != null) ...[
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onCopyInvite != null)
                  TextButton.icon(
                    onPressed: onCopyInvite,
                    icon: const Icon(Icons.copy, size: 13),
                    label: const Text('Copy Link', style: TextStyle(fontSize: 13)),
                    style: TextButton.styleFrom(
                      foregroundColor: OrionColors.textSecondary,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: OrionColors.borderColor, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: OrionRadius.sm),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                  ),
                if (onEdit != null) ...[
                  const SizedBox(width: 8),
                  TextButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit, size: 13),
                    label: const Text('Edit', style: TextStyle(fontSize: 13)),
                    style: TextButton.styleFrom(
                      foregroundColor: OrionColors.textSecondary,
                      backgroundColor: OrionColors.secondaryBg,
                      side: const BorderSide(color: OrionColors.borderColor, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: OrionRadius.sm),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                  ),
                ],
                if (onDelete != null) ...[
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline, size: 13),
                    label: const Text('Delete', style: TextStyle(fontSize: 13)),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: OrionColors.danger,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: OrionRadius.sm),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
