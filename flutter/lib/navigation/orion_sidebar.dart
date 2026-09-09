import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

class OrionSidebarItem {
  final String key;
  final String label;
  final Widget? icon;

  const OrionSidebarItem({
    required this.key,
    required this.label,
    this.icon,
  });
}

/// Orion Sidebar widget mirroring `Sidebar.jsx` with full customization support.
class OrionSidebar extends StatelessWidget {
  final List<OrionSidebarItem> items;
  final String activeKey;
  final ValueChanged<String>? onSelect;
  final bool collapsed;
  final String headerTitle;

  // Custom styling overrides (falls back to Orion defaults if null)
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderWidth;
  final Color? activeItemColor;
  final Color? activeTextColor;
  final Color? inactiveTextColor;
  final double? width;
  final double? collapsedWidth;

  const OrionSidebar({
    super.key,
    required this.items,
    required this.activeKey,
    this.onSelect,
    this.collapsed = false,
    this.headerTitle = 'Navigation',
    this.backgroundColor,
    this.borderColor,
    this.borderWidth,
    this.activeItemColor,
    this.activeTextColor,
    this.inactiveTextColor,
    this.width,
    this.collapsedWidth,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveWidth = width ?? 240.0;
    final effectiveCollapsedWidth = collapsedWidth ?? 70.0;
    final effectiveBg = backgroundColor ?? Colors.white;
    final effectiveBorderColor = borderColor ?? OrionColors.borderColor;
    final effectiveBorderWidth = borderWidth ?? 1.5;
    final effectiveActiveItemBg = activeItemColor ?? OrionColors.primaryLight;
    final effectiveActiveText = activeTextColor ?? OrionColors.primary;
    final effectiveInactiveText = inactiveTextColor ?? OrionColors.textSecondary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: collapsed ? effectiveCollapsedWidth : effectiveWidth,
      decoration: BoxDecoration(
        color: effectiveBg,
        border: Border(right: BorderSide(color: effectiveBorderColor, width: effectiveBorderWidth)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!collapsed && headerTitle.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 8),
              child: Text(
                headerTitle.toUpperCase(),
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: OrionColors.textSubtle,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final item = items[index];
                final isActive = item.key == activeKey;

                return InkWell(
                  onTap: () => onSelect?.call(item.key),
                  borderRadius: OrionRadius.md,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: EdgeInsets.symmetric(
                      horizontal: collapsed ? 8 : 12,
                      vertical: 9,
                    ),
                    decoration: BoxDecoration(
                      color: isActive ? effectiveActiveItemBg : Colors.transparent,
                      borderRadius: OrionRadius.md,
                      border: isActive
                          ? Border.all(color: OrionColors.primaryBorder)
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          collapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                      children: [
                        if (item.icon != null) ...[
                          IconTheme(
                            data: IconThemeData(
                              color: isActive ? effectiveActiveText : effectiveInactiveText,
                              size: 18,
                            ),
                            child: item.icon!,
                          ),
                          if (!collapsed) const SizedBox(width: 10),
                        ],
                        if (!collapsed)
                          Expanded(
                            child: Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                                color: isActive ? effectiveActiveText : effectiveInactiveText,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
