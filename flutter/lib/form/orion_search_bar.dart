import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Search Bar mirroring `SearchBar.jsx` with full customization support.
class OrionSearchBar extends StatefulWidget {
  final String value;
  final ValueChanged<String>? onChange;
  final VoidCallback? onClear;
  final String placeholder;
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
    this.onClear,
    this.placeholder = 'Search by name, role, email, phone or CNIC...',
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
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant OrionSearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && _controller.text != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBg = widget.backgroundColor ?? Colors.white;
    final effectiveBorderColor = widget.borderColor ?? OrionColors.borderColor;
    final effectiveBorderWidth = widget.borderWidth ?? 1.5;
    final effectiveRadius = widget.borderRadius ?? OrionRadius.md;
    final effectiveHeight = widget.height ?? 38.0;
    final effectiveIconColor = widget.iconColor ?? OrionColors.textMuted;

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
              controller: _controller,
              onChanged: widget.onChange,
              style: widget.textStyle ??
                  const TextStyle(
                    fontSize: 13.5,
                    color: OrionColors.textMain,
                  ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
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
          if (widget.value.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close, size: 16, color: OrionColors.textSubtle),
              padding: const EdgeInsets.symmetric(horizontal: 4),
              constraints: const BoxConstraints(),
              onPressed: () {
                _controller.clear();
                if (widget.onClear != null) {
                  widget.onClear!();
                } else if (widget.onChange != null) {
                  widget.onChange!('');
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
