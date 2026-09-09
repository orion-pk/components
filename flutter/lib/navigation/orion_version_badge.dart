import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import 'orion_update_dialog.dart';

/// Orion Version Badge mirroring `VersionBadge.jsx`
class OrionVersionBadge extends StatelessWidget {
  final String currentVersion;
  final bool hasUpdate;
  final String latestVersion;
  final List<String> releaseNotes;
  final VoidCallback? onUpdateDownload;

  const OrionVersionBadge({
    super.key,
    this.currentVersion = 'v2.4.0',
    this.hasUpdate = false,
    this.latestVersion = 'v2.4.1',
    this.releaseNotes = const [],
    this.onUpdateDownload,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = hasUpdate ? OrionColors.statusOrangeBg : OrionColors.primaryLight;
    final textColor = hasUpdate ? const Color(0xFFB45309) : OrionColors.primary;
    final borderColor = hasUpdate ? OrionColors.statusOrangeBorder : OrionColors.primaryBorder;

    return InkWell(
      onTap: () {
        OrionUpdateDialog.show(
          context,
          currentVersion: currentVersion,
          latestVersion: latestVersion,
          hasUpdate: hasUpdate,
          releaseNotes: releaseNotes,
          onUpdateDownload: onUpdateDownload,
        );
      },
      borderRadius: OrionRadius.full,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: OrionRadius.full,
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              hasUpdate ? Icons.arrow_circle_up : Icons.refresh,
              size: 13,
              color: textColor,
            ),
            const SizedBox(width: 5),
            Text(
              currentVersion,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            if (hasUpdate) ...[
              const SizedBox(width: 5),
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: Color(0xFFB45309),
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
