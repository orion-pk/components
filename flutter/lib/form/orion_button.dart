import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import '../feedback/orion_custom_loader.dart';

enum OrionButtonVariant {
  primary,
  secondary,
  danger,
  outline,
  ghost,
}

enum OrionButtonSize {
  sm,
  md,
  lg,
}

/// Orion Button widget mirroring `Button.jsx`
class OrionButton extends StatelessWidget {
  final String? label;
  final Widget? child;
  final OrionButtonVariant variant;
  final OrionButtonSize size;
  final bool isLoading;
  final bool disabled;
  final Widget? iconLeft;
  final Widget? iconRight;
  final VoidCallback? onPressed;
  final double? width;

  const OrionButton({
    super.key,
    this.label,
    this.child,
    this.variant = OrionButtonVariant.primary,
    this.size = OrionButtonSize.md,
    this.isLoading = false,
    this.disabled = false,
    this.iconLeft,
    this.iconRight,
    this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isActuallyDisabled = disabled || isLoading || onPressed == null;

    double height;
    double fontSize;
    EdgeInsetsGeometry padding;
    double loaderSize;

    switch (size) {
      case OrionButtonSize.sm:
        height = 30;
        fontSize = 12;
        padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4);
        loaderSize = 12;
        break;
      case OrionButtonSize.md:
        height = 38;
        fontSize = 13.5;
        padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        loaderSize = 14;
        break;
      case OrionButtonSize.lg:
        height = 44;
        fontSize = 15;
        padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
        loaderSize = 18;
        break;
    }

    Color bgColor;
    Color textColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case OrionButtonVariant.primary:
        bgColor = OrionColors.primary;
        textColor = Colors.white;
        break;
      case OrionButtonVariant.secondary:
        bgColor = OrionColors.secondaryBg;
        textColor = const Color(0xFF475569);
        borderSide = const BorderSide(color: OrionColors.borderColor, width: 1.5);
        break;
      case OrionButtonVariant.danger:
        bgColor = OrionColors.danger;
        textColor = Colors.white;
        break;
      case OrionButtonVariant.outline:
        bgColor = Colors.transparent;
        textColor = OrionColors.textMain;
        borderSide = const BorderSide(color: OrionColors.borderColor, width: 1.5);
        break;
      case OrionButtonVariant.ghost:
        bgColor = Colors.transparent;
        textColor = OrionColors.textMuted;
        break;
    }

    final loaderColor = (variant == OrionButtonVariant.primary || variant == OrionButtonVariant.danger)
        ? Colors.white
        : OrionColors.primary;

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          OrionCustomLoader(size: loaderSize, color: loaderColor),
          const SizedBox(width: 6),
        ] else if (iconLeft != null) ...[
          IconTheme(
            data: IconThemeData(color: textColor, size: fontSize + 2),
            child: iconLeft!,
          ),
          const SizedBox(width: 6),
        ],
        child ??
            Text(
              label ?? '',
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
        if (!isLoading && iconRight != null) ...[
          const SizedBox(width: 6),
          IconTheme(
            data: IconThemeData(color: textColor, size: fontSize + 2),
            child: iconRight!,
          ),
        ],
      ],
    );

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: isActuallyDisabled ? 0.55 : 1.0,
      child: Material(
        color: bgColor,
        borderRadius: OrionRadius.md,
        child: InkWell(
          onTap: isActuallyDisabled ? null : onPressed,
          borderRadius: OrionRadius.md,
          child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              borderRadius: OrionRadius.md,
              border: borderSide == BorderSide.none ? null : Border.fromBorderSide(borderSide),
            ),
            alignment: Alignment.center,
            child: content,
          ),
        ),
      ),
    );
  }
}
