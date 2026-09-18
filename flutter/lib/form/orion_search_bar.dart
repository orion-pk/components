import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Search Bar mirroring `SearchBar.jsx` with full customization support.
class OrionSearchBar extends StatefulWidget {
  final String value;
  final ValueChanged<String>? onChange;
  final ValueChanged<String>? onChanged; // Alias for onChange
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onClear;
  final String placeholder;
  final String? hintText; // Alias for placeholder
  final TextEditingController? controller;
  final bool showFilterToggle;
  final VoidCallback? onFilterToggle;
  final bool filterActive;

  // Custom styling overrides (falls back to Orion defaults if null)
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final double? height;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final Color? iconColor;

  const OrionSearchBar({
    super.key,
    this.value = '',
    this.onChange,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
    this.placeholder = 'Search by name, role, email, phone or CNIC...',
    this.hintText,
    this.controller,
    this.showFilterToggle = false,
    this.onFilterToggle,
    this.filterActive = false,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.height,
    this.textStyle,
    this.hintStyle,
    this.iconColor,
  });

  @override
  State<OrionSearchBar> createState() => _OrionSearchBarState();
}

class _OrionSearchBarState extends State<OrionSearchBar> {
  late TextEditingController _effectiveController;
  bool _createdInternally = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _effectiveController = widget.controller!;
    } else {
      _effectiveController = TextEditingController(text: widget.value);
      _createdInternally = true;
    }
  }

  @override
  void didUpdateWidget(covariant OrionSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_createdInternally && oldWidget.value != widget.value && _effectiveController.text != widget.value) {
      _effectiveController.text = widget.value;
    }
  }

  @override
  void dispose() {
    if (_createdInternally) {
      _effectiveController.dispose();
    }
    super.dispose();
  }

  void _triggerChange(String val) {
    if (widget.onChange != null) widget.onChange!(val);
    if (widget.onChanged != null) widget.onChanged!(val);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBg = widget.backgroundColor ?? Colors.white;
    final effectiveBorderColor = widget.borderColor ?? OrionColors.borderColor;
    final effectiveBorderWidth = widget.borderWidth ?? 1.5;
    final effectiveRadius = widget.borderRadius ?? OrionRadius.md;
    final effectiveHeight = widget.height ?? 38.0;
    final effectiveIconColor = widget.iconColor ?? OrionColors.textMuted;
    final effectiveHint = widget.hintText ?? widget.placeholder;

    return Container(
      height: effectiveHeight,
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: effectiveRadius,
        border: Border.all(color: effectiveBorderColor, width: effectiveBorderWidth),
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 8),
            child: Icon(Icons.search, size: 18, color: effectiveIconColor),
          ),
          Expanded(
            child: TextField(
              controller: _effectiveController,
              onChanged: _triggerChange,
              onSubmitted: widget.onSubmitted,
              style: widget.textStyle ??
                  const TextStyle(
                    fontSize: 13.5,
                    color: OrionColors.textMain,
                  ),
              decoration: InputDecoration(
                hintText: effectiveHint,
                hintStyle: widget.hintStyle ??
                    const TextStyle(
                      fontSize: 13.5,
                      color: OrionColors.textSubtle,
                    ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
          if (_effectiveController.text.isNotEmpty || widget.value.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close, size: 16, color: OrionColors.textSubtle),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              constraints: const BoxConstraints(),
              onPressed: () {
                _effectiveController.clear();
                if (widget.onClear != null) {
                  widget.onClear!();
                } else {
                  _triggerChange('');
                }
              },
            ),
          if (widget.showFilterToggle) ...[
            Container(
              margin: const EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                color: widget.filterActive ? OrionColors.primaryLight : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: widget.filterActive
                    ? Border.all(color: OrionColors.primaryBorder)
                    : null,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.tune,
                  size: 16,
                  color: widget.filterActive ? OrionColors.primary : OrionColors.textMuted,
                ),
                padding: const EdgeInsets.all(4),
                constraints: const BoxConstraints(),
                onPressed: widget.onFilterToggle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
