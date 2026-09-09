import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

class OrionUser {
  final String name;
  final String email;
  final String role;

  const OrionUser({
    required this.name,
    required this.email,
    required this.role,
  });
}

/// Orion Profile Dropdown widget mirroring `ProfileDropdown.jsx`
class OrionProfileDropdown extends StatelessWidget {
  final OrionUser user;
  final VoidCallback? onProfileClick;
  final VoidCallback? onSettings;
  final VoidCallback? onLogout;

  const OrionProfileDropdown({
    super.key,
    this.user = const OrionUser(
      name: 'Super Admin',
      email: 'admin@orion.edu',
      role: 'Super Admin',
    ),
    this.onProfileClick,
    this.onSettings,
    this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final initials = user.name.trim().isNotEmpty
        ? user.name.trim().substring(0, user.name.trim().length >= 2 ? 2 : 1).toUpperCase()
        : 'U';

    return PopupMenuButton<int>(
      offset: const Offset(0, 44),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: OrionRadius.md,
        side: const BorderSide(color: OrionColors.borderColor, width: 1.5),
      ),
      color: Colors.white,
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: OrionColors.textMain,
                ),
              ),
              Text(
                user.email,
                style: const TextStyle(
                  fontSize: 12,
                  color: OrionColors.textMuted,
                ),
              ),
              const Divider(height: 12, color: Color(0xFFF1F5F9)),
            ],
          ),
        ),
        if (onProfileClick != null)
          PopupMenuItem<int>(
            value: 1,
            child: const Row(
              children: [
                Icon(Icons.person_outline, size: 16, color: OrionColors.textSecondary),
                SizedBox(width: 8),
                Text('Profile', style: TextStyle(fontSize: 13, color: OrionColors.textSecondary)),
              ],
            ),
          ),
        if (onSettings != null)
          PopupMenuItem<int>(
            value: 2,
            child: const Row(
              children: [
                Icon(Icons.settings_outlined, size: 16, color: OrionColors.textSecondary),
                SizedBox(width: 8),
                Text('Settings', style: TextStyle(fontSize: 13, color: OrionColors.textSecondary)),
              ],
            ),
          ),
        if (onLogout != null)
          PopupMenuItem<int>(
            value: 3,
            child: const Row(
              children: [
                Icon(Icons.logout, size: 16, color: Color(0xFFDC2626)),
                SizedBox(width: 8),
                Text('Sign Out', style: TextStyle(fontSize: 13, color: Color(0xFFDC2626), fontWeight: FontWeight.w600)),
              ],
            ),
          ),
      ],
      onSelected: (val) {
        if (val == 1) onProfileClick?.call();
        if (val == 2) onSettings?.call();
        if (val == 3) onLogout?.call();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
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
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: OrionColors.textMain,
                  height: 1.1,
                ),
              ),
              Text(
                user.role,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: OrionColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(width: 4),
          const Icon(Icons.keyboard_arrow_down, size: 16, color: OrionColors.textMuted),
        ],
      ),
    );
  }
}
