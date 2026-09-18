import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/orion_theme.dart';

/// Orion Phone Input mirroring `PhoneInput.jsx` with full customization support.
class OrionPhoneInput extends StatelessWidget {
  final String? label;
  final String? value;
  final String? initialValue;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onChanged; // Alias
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final String placeholder;
  final String? hintText; // Alias
  final String? error;
  final String? errorText; // Alias
  final int maxLength;
  final bool required;
  final bool enabled;
  final bool autofocus;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry? padding;

  const OrionPhoneInput({
    super.key,
    this.label = 'Phone Number',
    this.value,
    this.initialValue,
    this.onChange,
    this.onChanged,
    this.controller,
    this.validator,
    this.placeholder = '123 045 223 48',
    this.hintText,
    this.error,
    this.errorText,
    this.maxLength = 14,
    this.required = false,
    this.enabled = true,
    this.autofocus = false,
    this.prefixIcon,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveError = error ?? errorText;
    final effectiveHint = hintText ?? placeholder;
    final effectiveCallback = onChanged ?? onChange;

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (label != null) ...[
            RichText(
              text: TextSpan(
                text: label!,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: OrionColors.textSecondary,
                ),
                children: [
                  if (required)
                    const TextSpan(
                      text: ' *',
                      style: TextStyle(color: OrionColors.statusRed),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 4),
          ],
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: enabled ? Colors.white : const Color(0xFFF8FAFC),
              borderRadius: OrionRadius.md,
              border: Border.all(
                color: effectiveError != null ? OrionColors.statusRed : OrionColors.borderColor,
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: prefixIcon ?? const Icon(Icons.phone_outlined, size: 16, color: OrionColors.textSubtle),
                ),
                Expanded(
                  child: TextFormField(
                    controller: controller,
                    initialValue: controller == null ? (initialValue ?? value) : null,
                    enabled: enabled,
                    autofocus: autofocus,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[\d+ ]')),
                      LengthLimitingTextInputFormatter(maxLength),
                    ],
                    onChanged: effectiveCallback,
                    validator: validator,
                    style: TextStyle(
                      fontSize: 13.5,
                      color: enabled ? OrionColors.textMain : OrionColors.textMuted,
                    ),
                    decoration: InputDecoration(
                      hintText: effectiveHint,
                      hintStyle: const TextStyle(
                        fontSize: 13.5,
                        color: OrionColors.textSubtle,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (effectiveError != null) ...[
            const SizedBox(height: 4),
            Text(
              effectiveError,
              style: const TextStyle(
                color: OrionColors.statusRed,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
