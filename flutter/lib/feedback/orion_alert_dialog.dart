import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

enum OrionAlertVariant { success, danger, warning, info }

/// Orion Alert Dialog mirroring `AlertDialog.jsx` with full customization support.
class OrionAlertDialog extends StatelessWidget {
  final String title;
  final String? description;
  final String? message; // Alias for description
  final String? content; // Alias for description
  final OrionAlertVariant variant;
  final String confirmText;
  final VoidCallback? onClose;
  final VoidCallback? onConfirm;

  // Custom styling overrides
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const OrionAlertDialog({
    super.key,
    this.title = 'Notification',
    this.description,
    this.message,
    this.content,
    this.variant = OrionAlertVariant.info,
    this.confirmText = 'Got it',
    this.onClose,
    this.onConfirm,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
    this.titleStyle,
    this.descriptionStyle,
  });

  static Future<void> show(
    BuildContext context, {
    String title = 'Notification',
    String? description,
    String? message,
    String? content,
    OrionAlertVariant variant = OrionAlertVariant.info,
    String confirmText = 'Got it',
    bool barrierDismissible = true,
  }) {
    final text = description ?? message ?? content ?? '';
    return showDialog<void>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: const Color.fromRGBO(15, 23, 42, 0.5),
      builder: (ctx) => OrionAlertDialog(
        title: title,
        description: text,
        variant: variant,
        confirmText: confirmText,
        onClose: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bodyText = description ?? message ?? content ?? '';
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

    final handleClose = onClose ?? onConfirm ?? () => Navigator.of(context, rootNavigator: true).pop();

    return Dialog(
      backgroundColor: backgroundColor ?? OrionColors.bgSurface,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? OrionRadius.lg,
        side: BorderSide(color: borderColor ?? OrionColors.borderColor, width: 1.5),
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
                      style: titleStyle ??
                          const TextStyle(
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
                    onPressed: handleClose,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                bodyText,
                style: descriptionStyle ??
                    const TextStyle(
                      fontSize: 14,
                      color: OrionColors.textSecondary,
                      height: 1.5,
                    ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: handleClose,
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
