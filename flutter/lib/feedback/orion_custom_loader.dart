import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Custom Loader widget mirroring `CustomLoader.jsx` with full customization support.
class OrionCustomLoader extends StatelessWidget {
  final double size;
  final String? text;
  final String? label; // Alias for text
  final String? message; // Alias for text
  final Color color;
  final double strokeWidth;
  final Color? trackColor;
  final TextStyle? textStyle;
  final bool fullScreen;

  const OrionCustomLoader({
    super.key,
    this.size = 20,
    this.text,
    this.label,
    this.message,
    this.color = OrionColors.primary,
    this.strokeWidth = 2.5,
    this.trackColor,
    this.textStyle,
    this.fullScreen = false,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = label ?? message ?? text;

    Widget loader = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            backgroundColor: trackColor ?? const Color(0xFFE2E8F0),
          ),
        ),
        if (displayText != null) ...[
          const SizedBox(width: 10),
          Text(
            displayText,
            style: textStyle ??
                const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: OrionColors.textSecondary,
                ),
          ),
        ],
      ],
    );

    if (fullScreen) {
      return Container(
        color: const Color.fromRGBO(255, 255, 255, 0.85),
        alignment: Alignment.center,
        child: loader,
      );
    }

    return loader;
  }
}
