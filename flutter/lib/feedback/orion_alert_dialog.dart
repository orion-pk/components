import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

enum OrionAlertVariant { success, danger, warning, info }

/// Orion Alert Dialog mirroring `AlertDialog.jsx`
class OrionAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final OrionAlertVariant variant;
  final String confirmText;
  final VoidCallback onClose;

  const OrionAlertDialog({
    super.key,
    this.title = 'Notification',
    required this.description,
    this.variant = OrionAlertVariant.info,
    this.confirmText = 'Got it',
    required this.onClose,
  });

  static Future<void> show(
    BuildContext context, {
    String title = 'Notification',
    required String description,
    OrionAlertVariant variant = OrionAlertVariant.info,
    String confirmText = 'Got it',
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: const Color.fromRGBO(15, 23, 42, 0.5),
      builder: (ctx) => OrionAlertDialog(
        title: title,
        description: description,
        variant: variant,
        confirmText: confirmText,
        onClose: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color iconColor;

    switch (variant) {
      case OrionAlertVariant.success:
        icon = Icons.check_circle_outline;
        iconColor = OrionColors.statusGreen;
        break;
      case OrionAlertVariant.danger:
        icon = Icons.error_outline;
        iconColor = OrionColors.statusRed;
        break;
      case OrionAlertVariant.warning:
        icon = Icons.warning_amber_rounded;
        iconColor = OrionColors.statusOrange;
        break;
      case OrionAlertVariant.info:
        icon = Icons.info_outline;
        iconColor = OrionColors.primary;
        break;
    }

    return Dialog(
      backgroundColor: OrionColors.bgSurface,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: OrionRadius.lg,
        side: const BorderSide(color: OrionColors.borderColor, width: 1.5),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 24, color: iconColor),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: OrionColors.textMain,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18, color: OrionColors.textMuted),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: onClose,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: OrionColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: onClose,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: OrionColors.primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    confirmText,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
