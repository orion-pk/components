import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Form Select dropdown mirroring `FormSelect.jsx` with full customization support.
class OrionFormSelect<T> extends StatelessWidget {
  final String? label;
  final List<T>? options;
  final List<T>? items; // Alias for options
  final List<DropdownMenuItem<T>>? customItems;
  final T? value;
  final ValueChanged<T?>? onChange;
  final ValueChanged<T?>? onChanged; // Alias for onChange
  final String? Function(T)? optionLabel;
  final String? error;
  final String? errorText; // Alias for error
  final String placeholder;
  final String? hintText; // Alias for placeholder
  final bool required;
  final bool enabled;
  final FormFieldValidator<T>? validator;
  final EdgeInsetsGeometry? padding;

  const OrionFormSelect({
    super.key,
    this.label,
    this.options,
    this.items,
    this.customItems,
    this.value,
    this.onChange,
    this.onChanged,
    this.optionLabel,
    this.error,
    this.errorText,
    this.placeholder = 'Select an option',
    this.hintText,
    this.required = false,
    this.enabled = true,
    this.validator,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveError = error ?? errorText;
    final effectiveHint = hintText ?? placeholder;
    final effectiveCallback = onChanged ?? onChange;
    final effectiveList = items ?? options ?? <T>[];

    final dropdownItems = customItems ??
        effectiveList.map((opt) {
          final text = optionLabel != null ? optionLabel!(opt) : opt.toString();
          return DropdownMenuItem<T>(
            value: opt,
            child: Text(
              text ?? '',
              style: const TextStyle(fontSize: 13.5, color: OrionColors.textMain),
            ),
          );
        }).toList();

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
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: enabled ? Colors.white : const Color(0xFFF8FAFC),
              borderRadius: OrionRadius.md,
              border: Border.all(
                color: effectiveError != null ? OrionColors.statusRed : OrionColors.borderColor,
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                value: value,
                isExpanded: true,
                hint: Text(
                  effectiveHint,
                  style: const TextStyle(fontSize: 13.5, color: OrionColors.textSubtle),
                ),
                icon: const Icon(Icons.arrow_drop_down, color: OrionColors.textMuted),
                items: dropdownItems,
                onChanged: enabled ? effectiveCallback : null,
              ),
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
