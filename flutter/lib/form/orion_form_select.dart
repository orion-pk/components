import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Form Select dropdown mirroring `FormSelect.jsx`
class OrionFormSelect<T> extends StatelessWidget {
  final String? label;
  final List<T> options;
  final T? value;
  final ValueChanged<T?>? onChange;
  final String? Function(T)? optionLabel;
  final String? error;
  final String placeholder;
  final bool required;

  const OrionFormSelect({
    super.key,
    this.label,
    required this.options,
    this.value,
    this.onChange,
    this.optionLabel,
    this.error,
    this.placeholder = 'Select an option',
    this.required = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
            color: Colors.white,
            borderRadius: OrionRadius.md,
            border: Border.all(
              color: error != null ? OrionColors.statusRed : OrionColors.borderColor,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              hint: Text(
                placeholder,
                style: const TextStyle(fontSize: 13.5, color: OrionColors.textSubtle),
              ),
              icon: const Icon(Icons.arrow_drop_down, color: OrionColors.textMuted),
              items: options.map((opt) {
                final text = optionLabel != null ? optionLabel!(opt) : opt.toString();
                return DropdownMenuItem<T>(
                  value: opt,
                  child: Text(
                    text ?? '',
                    style: const TextStyle(fontSize: 13.5, color: OrionColors.textMain),
                  ),
                );
              }).toList(),
              onChanged: onChange,
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(
            error!,
            style: const TextStyle(
              color: OrionColors.statusRed,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
