import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import '../form/orion_button.dart';

/// Orion Update Dialog mirroring `UpdateDialog.jsx`
class OrionUpdateDialog extends StatelessWidget {
  final String currentVersion;
  final String latestVersion;
  final bool hasUpdate;
  final List<String> releaseNotes;
  final VoidCallback onClose;
  final VoidCallback? onUpdateDownload;
  final bool updating;

  const OrionUpdateDialog({
    super.key,
    this.currentVersion = 'v2.4.0',
    this.latestVersion = 'v2.4.1',
    this.hasUpdate = false,
    this.releaseNotes = const [
      'Optimized User & Role Management DataGrid',
      'Improved modal form validation and phone number limits',
      'Enhanced system stability and faster synchronization',
    ],
    required this.onClose,
    this.onUpdateDownload,
    this.updating = false,
  });

  static Future<void> show(
    BuildContext context, {
    String currentVersion = 'v2.4.0',
    String latestVersion = 'v2.4.1',
    bool hasUpdate = false,
    List<String> releaseNotes = const [],
    VoidCallback? onUpdateDownload,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: const Color.fromRGBO(15, 23, 42, 0.5),
      builder: (ctx) => OrionUpdateDialog(
        currentVersion: currentVersion,
        latestVersion: latestVersion,
        hasUpdate: hasUpdate,
        releaseNotes: releaseNotes.isNotEmpty
            ? releaseNotes
            : const [
                'Optimized User & Role Management DataGrid',
                'Improved modal form validation and phone number limits',
                'Enhanced system stability and faster synchronization',
              ],
        onClose: () => Navigator.of(ctx).pop(),
        onUpdateDownload: onUpdateDownload,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: OrionRadius.lg,
        side: const BorderSide(color: OrionColors.borderColor, width: 1.5),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 460),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: hasUpdate ? OrionColors.statusOrangeBg : OrionColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      hasUpdate ? Icons.arrow_circle_up : Icons.check_circle_outline,
                      size: 20,
                      color: hasUpdate ? const Color(0xFFB45309) : OrionColors.primary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasUpdate ? 'System Update Available' : 'System Up to Date',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: OrionColors.textMain,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Installed: $currentVersion ${hasUpdate ? "→ Latest: $latestVersion" : ""}',
                          style: const TextStyle(fontSize: 12.5, color: OrionColors.textMuted),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18, color: OrionColors.textSubtle),
                    onPressed: onClose,
                  ),
                ],
              ),
              const SizedBox(height: 16),

              if (hasUpdate) ...[
                Text(
                  "What's New in $latestVersion:",
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: OrionColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: releaseNotes.map((note) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(color: OrionColors.textMuted, fontSize: 13)),
                          Expanded(
                            child: Text(
                              note,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF475569),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ] else ...[
                const Text(
                  'You are currently running the latest certified build of the Orion application. No pending updates found.',
                  style: TextStyle(
                    fontSize: 13.5,
                    color: Color(0xFF475569),
                    height: 1.5,
                  ),
                ),
              ],

              const SizedBox(height: 20),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OrionButton(
                    label: 'Close',
                    variant: OrionButtonVariant.secondary,
                    onPressed: onClose,
                  ),
                  if (hasUpdate && onUpdateDownload != null) ...[
                    const SizedBox(width: 8),
                    OrionButton(
                      label: 'Update Now',
                      variant: OrionButtonVariant.primary,
                      isLoading: updating,
                      iconLeft: const Icon(Icons.refresh, size: 14),
                      onPressed: onUpdateDownload,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
