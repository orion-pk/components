import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import 'orion_update_dialog.dart';

/// Orion Version Badge mirroring `VersionBadge.jsx` with full customization support.
class OrionVersionBadge extends StatelessWidget {
  final String? version; // Alias for currentVersion
  final String currentVersion;
  final bool hasUpdate;
  final String latestVersion;
  final List<String> releaseNotes;
  final VoidCallback? onUpdateDownload;
  final VoidCallback? onTap;

  // Custom styling overrides (falls back to Orion defaults if null)
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final IconData? icon;
  final double? iconSize;
  final Color? dotColor;

  const OrionVersionBadge({
    super.key,
    this.version,
    this.currentVersion = 'v1.0.0',
    this.hasUpdate = false,
    this.latestVersion = 'v1.0.1',
    this.releaseNotes = const [],
    this.onUpdateDownload,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.padding,
    this.textStyle,
    this.icon,
    this.iconSize,
    this.dotColor,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveVersion = version ?? currentVersion;
    final defaultBgColor = hasUpdate ? OrionColors.statusOrangeBg : OrionColors.primaryLight;
    final defaultTextColor = hasUpdate ? const Color(0xFFB45309) : OrionColors.primary;
    final defaultBorderColor = hasUpdate ? OrionColors.statusOrangeBorder : OrionColors.primaryBorder;

    final effectiveBg = backgroundColor ?? defaultBgColor;
    final effectiveText = textColor ?? defaultTextColor;
    final effectiveBorder = borderColor ?? defaultBorderColor;
    final effectiveWidth = borderWidth ?? 1.5;
    final effectiveRadius = borderRadius ?? OrionRadius.full;
    final effectivePadding = padding ?? const EdgeInsets.symmetric(horizontal: 9, vertical: 3);
    final effectiveIcon = icon ?? (hasUpdate ? Icons.arrow_circle_up : Icons.refresh);
    final effectiveIconSize = iconSize ?? 13.0;
    final effectiveDotColor = dotColor ?? const Color(0xFFB45309);

    return InkWell(
      onTap: onTap ??
          () {
            OrionUpdateDialog.show(
              context,
              currentVersion: effectiveVersion,
              latestVersion: latestVersion,
              hasUpdate: hasUpdate,
              releaseNotes: releaseNotes,
              onUpdateDownload: onUpdateDownload,
            );
          },
      borderRadius: effectiveRadius,
      child: Container(
        padding: effectivePadding,
        decoration: BoxDecoration(
          color: effectiveBg,
          borderRadius: effectiveRadius,
          border: Border.all(color: effectiveBorder, width: effectiveWidth),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              effectiveIcon,
              size: effectiveIconSize,
              color: effectiveText,
            ),
            const SizedBox(width: 5),
            Text(
              effectiveVersion,
              style: textStyle ??
                  TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: effectiveText,
                  ),
            ),
            if (hasUpdate) ...[
              const SizedBox(width: 5),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: effectiveDotColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
