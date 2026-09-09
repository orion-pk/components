import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Phone Input mirroring `PhoneInput.jsx`
class OrionPhoneInput extends StatelessWidget {
  final String? label;
  final String value;
  final ValueChanged<String>? onChange;
  final String placeholder;
  final String? error;
  final int maxLength;
  final bool required;

  const OrionPhoneInput({
    super.key,
    this.label = 'Phone Number',
    this.value = '',
    this.onChange,
    this.placeholder = '123 045 223 48',
    this.error,
    this.maxLength = 14,
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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: OrionRadius.md,
            border: Border.all(
              color: error != null ? OrionColors.statusRed : OrionColors.borderColor,
              width: 1.5,
            ),
          ),
          alignment: Alignment.center,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(Icons.phone_outlined, size: 16, color: OrionColors.textSubtle),
              ),
              Expanded(
                child: TextFormField(
                  initialValue: value,
                  keyboardType: TextInputType.phone,
                  onChanged: (val) {
                    final filtered = val.replaceAll(RegExp(r'[^\d+ ]'), '');
                    final truncated = filtered.length > maxLength
                        ? filtered.substring(0, maxLength)
                        : filtered;
                    if (onChange != null) onChange!(truncated);
                  },
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: OrionColors.textMain,
                  ),
                  decoration: InputDecoration(
                    hintText: placeholder,
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
