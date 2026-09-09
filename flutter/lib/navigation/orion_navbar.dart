import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import 'orion_version_badge.dart';
import 'orion_profile_dropdown.dart';

/// Orion Navbar header mirroring `Navbar.jsx` with full customization support.
class OrionNavbar extends StatelessWidget implements PreferredSizeWidget {
  final String brandName;
  final Widget? logo;
  final OrionUser user;
  final String currentVersion;
  final bool hasUpdate;
  final VoidCallback? onLogout;
  final VoidCallback? onSettings;
  final List<Widget>? rightActions;

  // Custom styling overrides (falls back to Orion defaults if null)
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? height;
  final TextStyle? brandTextStyle;
  final List<BoxShadow>? boxShadow;

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

    return Container(
      height: effectiveHeight,
      padding: const EdgeInsets.symmetric(horizontal: 24),
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
            children: [
              if (logo != null) ...[
                logo!,
                const SizedBox(width: 10),
              ],
              Text(
                brandName,
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
            children: [
              OrionVersionBadge(
                currentVersion: currentVersion,
                hasUpdate: hasUpdate,
              ),
              const SizedBox(width: 14),
              if (rightActions != null) ...[
                ...rightActions!,
                const SizedBox(width: 14),
              ],
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
