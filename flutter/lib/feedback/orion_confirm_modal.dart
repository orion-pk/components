import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

enum OrionConfirmVariant { danger, primary }

/// Orion Confirm Modal / Dialog mirroring `ConfirmModal.jsx`
class OrionConfirmDialog extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String message;
  final String confirmText;
  final String cancelText;
  final OrionConfirmVariant confirmVariant;
  final bool loading;
  final String? error;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const OrionConfirmDialog({
    super.key,
    this.title = 'Confirm Action',
    this.subtitle = 'Permanent Action',
    required this.message,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.confirmVariant = OrionConfirmVariant.danger,
    this.loading = false,
    this.error,
    required this.onConfirm,
    required this.onCancel,
  });

  static Future<bool?> show(
    BuildContext context, {
    String title = 'Confirm Action',
    String? subtitle = 'Permanent Action',
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    OrionConfirmVariant confirmVariant = OrionConfirmVariant.danger,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: const Color.fromRGBO(15, 23, 42, 0.5),
      builder: (ctx) => OrionConfirmDialog(
        title: title,
        subtitle: subtitle,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmVariant: confirmVariant,
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
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: iconBg,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(Icons.warning_amber_rounded, size: 22, color: iconColor),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: OrionColors.textMain,
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: OrionColors.textMuted,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18, color: OrionColors.textMuted),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: loading ? null : onCancel,
                  ),
                ],
              ),
              if (error != null) ...[
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFE4E6),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFFECDD3)),
                  ),
                  child: Text(
                    error!,
                    style: const TextStyle(color: OrionColors.danger, fontSize: 13),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  color: OrionColors.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: loading ? null : onCancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: OrionColors.textSecondary,
                      backgroundColor: OrionColors.secondaryBg,
                      side: const BorderSide(color: OrionColors.borderColor, width: 1.5),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    child: Text(
                      cancelText,
                      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: loading ? null : onConfirm,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: confirmBg,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    ),
                    child: loading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (isDanger) ...[
                                const Icon(Icons.delete_outline, size: 16),
                                const SizedBox(width: 6),
                              ],
                              Text(
                                confirmText,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                              ),
                            ],
                          ),
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
