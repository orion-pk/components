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

/// Orion Button widget mirroring `Button.jsx` with full customization support.
class OrionButton extends StatelessWidget {
  final String? label;
  final String? text; // Alias for label
  final Widget? child;
  final OrionButtonVariant variant;
  final OrionButtonSize size;
  final bool isLoading;
  final bool disabled;
  final Widget? iconLeft;
  final Widget? iconRight;
  final IconData? icon; // Shorthand for left icon
  final VoidCallback? onPressed;
  final double? width;

  // Custom styling overrides (falls back to Orion variant defaults if null)
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final TextStyle? textStyle;

  const OrionButton({
    super.key,
    this.label,
    this.text,
    this.child,
    this.variant = OrionButtonVariant.primary,
    this.size = OrionButtonSize.md,
    this.isLoading = false,
    this.disabled = false,
    this.iconLeft,
    this.iconRight,
    this.icon,
    this.onPressed,
    this.width,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.padding,
    this.height,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final isActuallyDisabled = disabled || isLoading || onPressed == null;
    final buttonText = label ?? text;

    double defaultHeight;
    double defaultFontSize;
    EdgeInsetsGeometry defaultPadding;
    double loaderSize;

    switch (size) {
      case OrionButtonSize.sm:
        defaultHeight = 30;
        defaultFontSize = 12;
        defaultPadding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4);
        loaderSize = 12;
        break;
      case OrionButtonSize.md:
        defaultHeight = 38;
        defaultFontSize = 13.5;
        defaultPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
        loaderSize = 14;
        break;
      case OrionButtonSize.lg:
        defaultHeight = 44;
        defaultFontSize = 15;
        defaultPadding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10);
        loaderSize = 18;
        break;
    }

    Color defaultBgColor;
    Color defaultTextColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case OrionButtonVariant.primary:
        defaultBgColor = OrionColors.primary;
        defaultTextColor = Colors.white;
        break;
      case OrionButtonVariant.secondary:
        defaultBgColor = OrionColors.secondaryBg;
        defaultTextColor = const Color(0xFF475569);
        borderSide = const BorderSide(color: OrionColors.borderColor, width: 1.5);
        break;
      case OrionButtonVariant.danger:
        defaultBgColor = OrionColors.danger;
        defaultTextColor = Colors.white;
        break;
      case OrionButtonVariant.outline:
        defaultBgColor = Colors.transparent;
        defaultTextColor = OrionColors.textMain;
        borderSide = const BorderSide(color: OrionColors.borderColor, width: 1.5);
        break;
      case OrionButtonVariant.ghost:
        defaultBgColor = Colors.transparent;
        defaultTextColor = OrionColors.textMuted;
        break;
    }

    final effectiveBg = backgroundColor ?? defaultBgColor;
    final effectiveTextColor = textColor ?? defaultTextColor;
    final effectiveHeight = height ?? defaultHeight;
    final effectivePadding = padding ?? defaultPadding;
    final effectiveRadius = borderRadius ?? OrionRadius.md;

    if (borderColor != null) {
      borderSide = BorderSide(color: borderColor!, width: 1.5);
    }

    final loaderColor = (variant == OrionButtonVariant.primary || variant == OrionButtonVariant.danger)
        ? Colors.white
        : OrionColors.primary;

    final effectiveLeftIcon = iconLeft ?? (icon != null ? Icon(icon) : null);

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          OrionCustomLoader(size: loaderSize, color: loaderColor),
          const SizedBox(width: 6),
        ] else if (effectiveLeftIcon != null) ...[
          IconTheme(
            data: IconThemeData(color: effectiveTextColor, size: defaultFontSize + 2),
            child: effectiveLeftIcon,
          ),
          const SizedBox(width: 6),
        ],
        child ??
            Text(
              buttonText ?? '',
              style: textStyle ??
                  TextStyle(
                    color: effectiveTextColor,
                    fontSize: defaultFontSize,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                  ),
            ),
        if (!isLoading && iconRight != null) ...[
          const SizedBox(width: 6),
          IconTheme(
            data: IconThemeData(color: effectiveTextColor, size: defaultFontSize + 2),
            child: iconRight!,
          ),
        ],
      ],
    );

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: isActuallyDisabled ? 0.55 : 1.0,
      child: Material(
        color: effectiveBg,
        borderRadius: effectiveRadius,
        child: InkWell(
          onTap: isActuallyDisabled ? null : onPressed,
          borderRadius: effectiveRadius,
          child: Container(
            width: width,
            height: effectiveHeight,
            padding: effectivePadding,
            decoration: BoxDecoration(
              borderRadius: effectiveRadius,
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
