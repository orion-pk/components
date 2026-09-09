import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

/// Orion Pagination controls mirroring `Pagination.jsx`
class OrionPagination extends StatelessWidget {
  final int currentPage;
  final int pageSize;
  final int totalItems;
  final ValueChanged<int>? onPageChange;
  final ValueChanged<int>? onPageSizeChange;
  final List<int> pageSizeOptions;

  const OrionPagination({
    super.key,
    this.currentPage = 1,
    this.pageSize = 10,
    this.totalItems = 0,
    this.onPageChange,
    this.onPageSizeChange,
    this.pageSizeOptions = const [10, 20, 30, 50],
  });

  @override
  Widget build(BuildContext context) {
    final totalPages = (totalItems / pageSize).ceil().clamp(1, 999999);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: OrionRadius.md,
        border: Border.all(color: OrionColors.borderColor, width: 1.5),
      ),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // Left: Page Navigation (Previous, 1, ..., Next)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                onPressed: currentPage > 1 ? () => onPageChange?.call(currentPage - 1) : null,
                style: OutlinedButton.styleFrom(
                  foregroundColor: OrionColors.textMain,
                  disabledForegroundColor: OrionColors.textSubtle,
                  side: const BorderSide(color: OrionColors.borderColor, width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  minimumSize: const Size(0, 30),
                ),
                child: const Text('Previous', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 6),
              // Page 1
              InkWell(
                onTap: () => onPageChange?.call(1),
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                  decoration: BoxDecoration(
                    color: currentPage == 1 ? OrionColors.secondaryBg : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: OrionColors.borderColor, width: 1.5),
                  ),
                  child: const Text(
                    '1',
                    style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: OrionColors.textMain),
                  ),
                ),
              ),
              if (totalPages > 2) ...[
                const SizedBox(width: 4),
                const Text('...', style: TextStyle(color: OrionColors.textSubtle)),
                const SizedBox(width: 4),
              ],
              if (totalPages > 1) ...[
                const SizedBox(width: 4),
                InkWell(
                  onTap: () => onPageChange?.call(totalPages),
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                    decoration: BoxDecoration(
                      color: currentPage == totalPages ? OrionColors.secondaryBg : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: OrionColors.borderColor, width: 1.5),
                    ),
                    child: Text(
                      '$totalPages',
                      style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: OrionColors.textMain),
                    ),
                  ),
                ),
              ],
              const SizedBox(width: 6),
              ElevatedButton(
                onPressed: currentPage < totalPages ? () => onPageChange?.call(currentPage + 1) : null,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: OrionColors.primary,
                  disabledForegroundColor: Colors.white.withValues(alpha: 0.5),
                  disabledBackgroundColor: OrionColors.primary.withValues(alpha: 0.5),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  minimumSize: const Size(0, 30),
                ),
                child: const Text('Next', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
              ),
            ],
          ),

          // Right Selectors: Rows & Page #
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Rows', style: TextStyle(fontSize: 13, color: OrionColors.textSecondary)),
              const SizedBox(width: 6),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: OrionColors.borderColor, width: 1.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: pageSize,
                    isDense: true,
                    icon: const Icon(Icons.arrow_drop_down, size: 16),
                    items: pageSizeOptions.map((opt) {
                      return DropdownMenuItem<int>(
                        value: opt,
                        child: Text('$opt', style: const TextStyle(fontSize: 12.5, color: OrionColors.textMain)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) onPageSizeChange?.call(val);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Text('Page #', style: TextStyle(fontSize: 13, color: OrionColors.textSecondary)),
              const SizedBox(width: 6),
              Container(
                height: 28,
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  border: Border.all(color: OrionColors.borderColor, width: 1.5),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: currentPage.clamp(1, totalPages),
                    isDense: true,
                    icon: const Icon(Icons.arrow_drop_down, size: 16),
                    items: List.generate(totalPages, (i) => i + 1).map((p) {
                      final str = p < 10 ? '0$p' : '$p';
                      return DropdownMenuItem<int>(
                        value: p,
                        child: Text(str, style: const TextStyle(fontSize: 12.5, color: OrionColors.textMain)),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) onPageChange?.call(val);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
