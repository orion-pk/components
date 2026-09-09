import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Search Bar mirroring `SearchBar.jsx`
class OrionSearchBar extends StatefulWidget {
  final String value;
  final ValueChanged<String>? onChange;
  final VoidCallback? onClear;
  final String placeholder;
  final bool showFilterToggle;
  final VoidCallback? onFilterToggle;
  final bool filterActive;

  const OrionSearchBar({
    super.key,
    this.value = '',
    this.onChange,
    this.onClear,
    this.placeholder = 'Search by name, role, email, phone or CNIC...',
    this.showFilterToggle = false,
    this.onFilterToggle,
    this.filterActive = false,
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
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: OrionRadius.md,
        border: Border.all(color: OrionColors.borderColor, width: 1.5),
      ),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, right: 8),
            child: Icon(Icons.search, size: 18, color: OrionColors.textMuted),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChange,
              style: const TextStyle(
                fontSize: 13.5,
                color: OrionColors.textMain,
              ),
              decoration: InputDecoration(
                hintText: widget.placeholder,
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
