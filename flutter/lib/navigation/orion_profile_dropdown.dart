import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

class OrionUser {
  final String name;
  final String email;
  final String role;
  final String? avatarUrl;

  const OrionUser({
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl,
  });
}

/// Orion Profile Dropdown widget mirroring `ProfileDropdown.jsx` with full customization support.
class OrionProfileDropdown extends StatelessWidget {
  final OrionUser? user;
  final String? userName;
  final String? userEmail;
  final String? userRole;
  final String? avatarUrl;
  final VoidCallback? onProfileClick;
  final VoidCallback? onProfile; // Alias
  final VoidCallback? onSettings;
  final VoidCallback? onLogout;
  final List<PopupMenuEntry<dynamic>>? customMenuItems;

  const OrionProfileDropdown({
    super.key,
    this.user,
    this.userName,
    this.userEmail,
    this.userRole,
    this.avatarUrl,
    this.onProfileClick,
    this.onProfile,
    this.onSettings,
    this.onLogout,
    this.customMenuItems,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveUser = user ??
        OrionUser(
          name: userName ?? 'Super Admin',
          email: userEmail ?? 'admin@orion.edu',
          role: userRole ?? 'Super Admin',
          avatarUrl: avatarUrl,
        );

    final effectiveProfile = onProfile ?? onProfileClick;
    final initials = effectiveUser.name.trim().isNotEmpty
        ? effectiveUser.name.trim().substring(0, effectiveUser.name.trim().length >= 2 ? 2 : 1).toUpperCase()
        : 'U';

    final effectiveAvatar = effectiveUser.avatarUrl ?? avatarUrl;

    return PopupMenuButton<dynamic>(
      offset: const Offset(0, 44),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: OrionRadius.md,
        side: const BorderSide(color: OrionColors.borderColor, width: 1.5),
      ),
      color: Colors.white,
      itemBuilder: (context) => [
        PopupMenuItem<dynamic>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                effectiveUser.name,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: OrionColors.textMain,
                ),
              ),
              Text(
                effectiveUser.email,
                style: const TextStyle(
                  fontSize: 12,
                  color: OrionColors.textMuted,
                ),
              ),
              const Divider(height: 12, color: Color(0xFFF1F5F9)),
            ],
          ),
        ),
        if (customMenuItems != null) ...customMenuItems!,
        if (effectiveProfile != null)
          PopupMenuItem<dynamic>(
            value: 'profile',
            child: const Row(
              children: [
                Icon(Icons.person_outline, size: 16, color: OrionColors.textSecondary),
                SizedBox(width: 8),
                Text('Profile', style: TextStyle(fontSize: 13, color: OrionColors.textSecondary)),
              ],
            ),
          ),
        if (onSettings != null)
          PopupMenuItem<dynamic>(
            value: 'settings',
            child: const Row(
              children: [
                Icon(Icons.settings_outlined, size: 16, color: OrionColors.textSecondary),
                SizedBox(width: 8),
                Text('Settings', style: TextStyle(fontSize: 13, color: OrionColors.textSecondary)),
              ],
            ),
          ),
        if (onLogout != null)
          PopupMenuItem<dynamic>(
            value: 'logout',
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
        if (val == 'profile') effectiveProfile?.call();
        if (val == 'settings') onSettings?.call();
        if (val == 'logout') onLogout?.call();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: OrionColors.primary,
              shape: BoxShape.circle,
              image: effectiveAvatar != null
                  ? DecorationImage(
                      image: NetworkImage(effectiveAvatar),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            alignment: Alignment.center,
            child: effectiveAvatar == null
                ? Text(
                    initials,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                effectiveUser.name,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: OrionColors.textMain,
                  height: 1.1,
                ),
              ),
              Text(
                effectiveUser.role,
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
