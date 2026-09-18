import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

class OrionSidebarItem {
  final String key;
  final String label;
  final Widget? icon;
  final IconData? iconData; // Shorthand
  final String? badge;
  final int? count;
  final String? tooltip;
  final VoidCallback? onTap;

  const OrionSidebarItem({
    required this.key,
    required this.label,
    this.icon,
    this.iconData,
    this.badge,
    this.count,
    this.tooltip,
    this.onTap,
  });
}

/// Orion Sidebar widget mirroring `Sidebar.jsx` with full customization support.
class OrionSidebar extends StatelessWidget {
  final List<OrionSidebarItem> items;
  final String activeKey;
  final ValueChanged<String>? onSelect;
  final ValueChanged<String>? onItemTap; // Alias for onSelect
  final bool collapsed;
  final bool? isCollapsed; // Alias for collapsed
  final String headerTitle;
  final Widget? headerWidget;
  final Widget? footerWidget;

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
    this.onItemTap,
    this.collapsed = false,
    this.isCollapsed,
    this.headerTitle = 'Navigation',
    this.headerWidget,
    this.footerWidget,
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
    final effectiveCollapsed = isCollapsed ?? collapsed;
    final effectiveCallback = onItemTap ?? onSelect;
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
      width: effectiveCollapsed ? effectiveCollapsedWidth : effectiveWidth,
      decoration: BoxDecoration(
        color: effectiveBg,
        border: Border(right: BorderSide(color: effectiveBorderColor, width: effectiveBorderWidth)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (headerWidget != null) ...[
            headerWidget!,
            const SizedBox(height: 12),
          ] else if (!effectiveCollapsed && headerTitle.isNotEmpty) ...[
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
                final effectiveIcon = item.icon ?? (item.iconData != null ? Icon(item.iconData) : null);
                final badgeText = item.badge ?? (item.count != null ? '${item.count}' : null);

                Widget rowWidget = AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding: EdgeInsets.symmetric(
                    horizontal: effectiveCollapsed ? 8 : 12,
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
                        effectiveCollapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                    children: [
                      if (effectiveIcon != null) ...[
                        IconTheme(
                          data: IconThemeData(
                            color: isActive ? effectiveActiveText : effectiveInactiveText,
                            size: 18,
                          ),
                          child: effectiveIcon,
                        ),
                        if (!effectiveCollapsed) const SizedBox(width: 10),
                      ],
                      if (!effectiveCollapsed) ...[
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
                        if (badgeText != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: isActive ? OrionColors.primary : const Color(0xFFE2E8F0),
                              borderRadius: OrionRadius.full,
                            ),
                            child: Text(
                              badgeText,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: isActive ? Colors.white : OrionColors.textSecondary,
                              ),
                            ),
                          ),
                      ],
                    ],
                  ),
                );

                if (item.tooltip != null) {
                  rowWidget = Tooltip(
                    message: item.tooltip!,
                    child: rowWidget,
                  );
                }

                return InkWell(
                  onTap: () {
                    if (item.onTap != null) {
                      item.onTap!();
                    } else if (effectiveCallback != null) {
                      effectiveCallback(item.key);
                    }
                  },
                  borderRadius: OrionRadius.md,
                  child: rowWidget,
                );
              },
            ),
          ),
          if (footerWidget != null) ...[
            const SizedBox(height: 12),
            footerWidget!,
          ],
        ],
      ),
    );
  }
}
