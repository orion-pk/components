import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import 'orion_version_badge.dart';
import 'orion_profile_dropdown.dart';

/// Orion Navbar header mirroring `Navbar.jsx`
class OrionNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String brandName;
  final Widget? logo;
  final OrionUser user;
  final String currentVersion;
  final bool hasUpdate;
  final VoidCallback? onLogout;
  final VoidCallback? onSettings;
  final List<Widget>? rightActions;

  const OrionNavbar({
    super.key,
    this.brandName = 'Orion Academy',
    this.logo,
    this.user = const OrionUser(
      name: 'Super Admin',
      email: 'admin@orion.edu',
      role: 'Super Admin',
    ),
    this.currentVersion = 'v2.4.0',
    this.hasUpdate = false,
    this.onLogout,
    this.onSettings,
    this.rightActions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: OrionColors.borderColor, width: 1.5)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.02),
            offset: Offset(0, 1),
            blurRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (logo != null) ...[
                logo!,
                const SizedBox(width: 10),
              ],
              Text(
                brandName,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 18,
                  color: OrionColors.primary,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
          Row(
            children: [
              if (rightActions != null) ...rightActions!,
              const SizedBox(width: 12),
              OrionVersionBadge(
                currentVersion: currentVersion,
                hasUpdate: hasUpdate,
              ),
              const SizedBox(width: 12),
              OrionProfileDropdown(
                user: user,
                onLogout: onLogout,
                onSettings: onSettings,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
