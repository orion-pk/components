import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

enum OrionConfirmVariant { danger, primary }

/// Orion Confirm Modal / Dialog mirroring `ConfirmModal.jsx` with full customization support.
class OrionConfirmDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String? message;
  final String? description; // Alias for message
  final String? content; // Alias for message
  final String confirmText;
  final String cancelText;
  final OrionConfirmVariant confirmVariant;
  final bool loading;
  final String? error;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  // Custom styling overrides (falls back to Orion defaults if null)
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? messageStyle;

  const OrionConfirmDialog({
    super.key,
    this.title = 'Confirm Action',
    this.subtitle = 'Permanent Action',
    this.message,
    this.description,
    this.content,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.confirmVariant = OrionConfirmVariant.danger,
    this.loading = false,
    this.error,
    required this.onConfirm,
    required this.onCancel,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.titleStyle,
    this.messageStyle,
  });

  static Future<bool?> show(
    BuildContext context, {
    String title = 'Confirm Action',
    String? subtitle = 'Permanent Action',
    String? message,
    String? description,
    String? content,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    OrionConfirmVariant confirmVariant = OrionConfirmVariant.danger,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    BorderRadius? borderRadius,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: const Color.fromRGBO(15, 23, 42, 0.5),
      builder: (ctx) => OrionConfirmDialog(
        title: title,
        subtitle: subtitle,
        message: message ?? description ?? content ?? '',
        confirmText: confirmText,
        cancelText: cancelText,
        confirmVariant: confirmVariant,
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        borderWidth: borderWidth,
        borderRadius: borderRadius,
        titleStyle: titleStyle,
        messageStyle: messageStyle,
        onConfirm: () => Navigator.of(ctx).pop(true),
        onCancel: () => Navigator.of(ctx).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDanger = confirmVariant == OrionConfirmVariant.danger;
    final iconColor = isDanger ? OrionColors.danger : OrionColors.primary;
    final iconBg = isDanger ? OrionColors.dangerBg : OrionColors.primaryLight;
    final confirmBg = isDanger ? OrionColors.danger : OrionColors.primary;

    final effectiveBg = backgroundColor ?? OrionColors.bgSurface;
    final effectiveBorderColor = borderColor ?? OrionColors.borderColor;
    final effectiveBorderWidth = borderWidth ?? 1.5;
    final effectiveRadius = borderRadius ?? OrionRadius.lg;
    final bodyText = message ?? description ?? content ?? '';

    return Dialog(
      backgroundColor: effectiveBg,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveRadius,
        side: BorderSide(color: effectiveBorderColor, width: effectiveBorderWidth),
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
                      color: iconBg,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      isDanger ? Icons.warning_amber_rounded : Icons.info_outline,
                      size: 20,
                      color: iconColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: titleStyle ??
                              const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: OrionColors.textMain,
                              ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: const TextStyle(fontSize: 12.5, color: OrionColors.textMuted),
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18, color: OrionColors.textSubtle),
                    onPressed: onCancel,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Body
              Text(
                bodyText,
                style: messageStyle ??
                    const TextStyle(
                      fontSize: 13.5,
                      color: OrionColors.textSecondary,
                      height: 1.45,
                    ),
              ),
              if (error != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: OrionColors.statusRedBg,
                    border: Border.all(color: OrionColors.statusRedBorder),
                    borderRadius: OrionRadius.sm,
                  ),
                  child: Text(
                    error!,
                    style: const TextStyle(color: OrionColors.statusRed, fontSize: 12.5),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              // Actions
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: loading ? null : onCancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: OrionColors.textSecondary,
                      side: const BorderSide(color: OrionColors.borderColor, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: OrionRadius.sm),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    child: Text(cancelText, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: loading ? null : onConfirm,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: confirmBg,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: OrionRadius.sm),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    child: loading
                        ? const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Text(confirmText, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Alias for OrionConfirmDialog
typedef OrionConfirmModal = OrionConfirmDialog;
