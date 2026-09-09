import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Custom Loader widget mirroring `CustomLoader.jsx`
class OrionCustomLoader extends StatelessWidget {
  final double size;
  final String? text;
  final Color color;

  const OrionCustomLoader({
    super.key,
    this.size = 20,
    this.text,
    this.color = OrionColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 2.5,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            backgroundColor: const Color(0xFFE2E8F0),
          ),
        ),
        if (text != null) ...[
          const SizedBox(width: 10),
          Text(
            text!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: OrionColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
