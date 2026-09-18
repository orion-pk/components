import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import 'orion_version_badge.dart';
import 'orion_profile_dropdown.dart';

/// Orion Navbar header mirroring `Navbar.jsx` with full customization support.
class OrionNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String? brandName;
  final String? title; // Alias for brandName
  final Widget? logo;
  final Widget? leading;
  final OrionUser? user;
  final String? userName;
  final String? userEmail;
  final String? userRole;
  final String currentVersion;
  final bool hasUpdate;
  final bool showVersionBadge;
  final bool showProfileDropdown;
  final VoidCallback? onLogout;
  final VoidCallback? onSettings;
  final VoidCallback? onVersionTap;
  final List<Widget>? rightActions;
  final List<Widget>? actions; // Alias for rightActions

  // Custom styling overrides (falls back to Orion defaults if null)
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? height;
  final TextStyle? brandTextStyle;
  final List<BoxShadow>? boxShadow;

  const OrionNavbar({
    super.key,
    this.brandName,
    this.title,
    this.logo,
    this.leading,
    this.user,
    this.userName,
    this.userEmail,
    this.userRole,
    this.currentVersion = 'v1.0.0',
    this.hasUpdate = false,
    this.showVersionBadge = true,
    this.showProfileDropdown = true,
    this.onLogout,
    this.onSettings,
    this.onVersionTap,
    this.rightActions,
    this.actions,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.height,
    this.brandTextStyle,
    this.boxShadow,
  });

  @override
  Size get preferredSize => Size.fromHeight(height ?? 60.0);

  @override
  Widget build(BuildContext context) {
    final effectiveHeight = height ?? 60.0;
    final effectiveBg = backgroundColor ?? Colors.white;
    final effectiveBorderColor = borderColor ?? OrionColors.borderColor;
    final effectiveBorderWidth = borderWidth ?? 1.5;
    final effectiveTitle = title ?? brandName ?? 'Orion App';
    final effectiveActions = actions ?? rightActions;

    final effectiveUser = user ??
        OrionUser(
          name: userName ?? 'Super Admin',
          email: userEmail ?? 'admin@orion.edu',
          role: userRole ?? 'Super Admin',
        );

    return Container(
      height: effectiveHeight,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: effectiveBg,
        border: Border(bottom: BorderSide(color: effectiveBorderColor, width: effectiveBorderWidth)),
        boxShadow: boxShadow ??
            const [
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
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 8),
              ],
              if (logo != null) ...[
                logo!,
                const SizedBox(width: 10),
              ],
              Text(
                effectiveTitle,
                style: brandTextStyle ??
                    const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: OrionColors.textMain,
                    ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showVersionBadge) ...[
                OrionVersionBadge(
                  currentVersion: currentVersion,
                  hasUpdate: hasUpdate,
                  onTap: onVersionTap,
                ),
                const SizedBox(width: 14),
              ],
              if (effectiveActions != null) ...[
                ...effectiveActions,
                const SizedBox(width: 14),
              ],
              if (showProfileDropdown)
                OrionProfileDropdown(
                  user: effectiveUser,
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
