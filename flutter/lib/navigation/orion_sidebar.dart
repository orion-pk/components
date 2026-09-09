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

/// Orion Sidebar widget mirroring `Sidebar.jsx`
class OrionSidebar extends StatelessWidget {
  final List<OrionSidebarItem> items;
  final String activeKey;
  final ValueChanged<String>? onSelect;
  final bool collapsed;
  final String headerTitle;

  const OrionSidebar({
    super.key,
    required this.items,
    required this.activeKey,
    this.onSelect,
    this.collapsed = false,
    this.headerTitle = 'Navigation',
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: collapsed ? 70 : 240,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: OrionColors.borderColor, width: 1.5)),
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
              separatorBuilder: (_, __) => const SizedBox(height: 4),
              itemBuilder: (context, index) {
                final item = items[index];
                final isAct = activeKey == item.key;

                return InkWell(
                  onTap: () => onSelect?.call(item.key),
                  borderRadius: OrionRadius.md,
                  child: Container(
                    padding: collapsed
                        ? const EdgeInsets.all(10)
                        : const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    decoration: BoxDecoration(
                      color: isAct ? OrionColors.primaryLight : Colors.transparent,
                      borderRadius: OrionRadius.md,
                      border: Border.all(
                        color: isAct ? OrionColors.primaryBorder : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment:
                          collapsed ? MainAxisAlignment.center : MainAxisAlignment.start,
                      children: [
                        if (item.icon != null)
                          IconTheme(
                            data: IconThemeData(
                              color: isAct ? OrionColors.primary : OrionColors.textMuted,
                              size: 18,
                            ),
                            child: item.icon!,
                          ),
                        if (!collapsed) ...[
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: isAct ? FontWeight.w700 : FontWeight.w500,
                                color: isAct ? OrionColors.primary : const Color(0xFF475569),
                              ),
                            ),
                          ),
                        ],
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
