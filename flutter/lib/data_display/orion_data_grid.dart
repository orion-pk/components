import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';

enum OrionSortDirection { asc, desc }

class OrionDataColumn<T> {
  final String header;
  final String? field;
  final Widget Function(T item)? cellBuilder;
  final double? width;
  final bool sortable;
  final TextAlign align;
  final Comparable Function(T item)? sortKey;

  const OrionDataColumn({
    required this.header,
    this.field,
    this.cellBuilder,
    this.width,
    this.sortable = true,
    this.align = TextAlign.left,
    this.sortKey,
  });
}

/// Orion DataGrid widget mirroring `DataGrid.jsx` with full styling customization.
class OrionDataGrid<T> extends StatefulWidget {
  final List<OrionDataColumn<T>> columns;
  final List<T> data;
  final String emptyMessage;

  // Custom styling overrides (falls back to Orion defaults if null)
  final Color? backgroundColor;
  final Color? headerBackgroundColor;
  final TextStyle? headerTextStyle;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;
  final double? dataRowMinHeight;
  final double? dataRowMaxHeight;
  final double? dividerThickness;
  final double? horizontalMargin;
  final double? columnSpacing;
  final Color? sortIconActiveColor;
  final Color? sortIconInactiveColor;
  final List<BoxShadow>? boxShadow;

  const OrionDataGrid({
    super.key,
    required this.columns,
    required this.data,
    this.emptyMessage = 'No records found',
    this.backgroundColor,
    this.headerBackgroundColor,
    this.headerTextStyle,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.dataRowMinHeight,
    this.dataRowMaxHeight,
    this.dividerThickness,
    this.horizontalMargin,
    this.columnSpacing,
    this.sortIconActiveColor,
    this.sortIconInactiveColor,
    this.boxShadow,
  });

  @override
  State<OrionDataGrid<T>> createState() => _OrionDataGridState<T>();
}

class _OrionDataGridState<T> extends State<OrionDataGrid<T>> {
  int? _sortColIndex;
  OrionSortDirection _sortDir = OrionSortDirection.asc;

  void _handleSort(int colIdx) {
    final col = widget.columns[colIdx];
    if (!col.sortable) return;

    setState(() {
      if (_sortColIndex == colIdx) {
        _sortDir = _sortDir == OrionSortDirection.asc
            ? OrionSortDirection.desc
            : OrionSortDirection.asc;
      } else {
        _sortColIndex = colIdx;
        _sortDir = OrionSortDirection.asc;
      }
    });
  }

  List<T> _getSortedData() {
    if (_sortColIndex == null) return widget.data;
    final col = widget.columns[_sortColIndex!];
    if (col.sortKey == null) return widget.data;

    final sorted = List<T>.from(widget.data);
    sorted.sort((a, b) {
      final keyA = col.sortKey!(a);
      final keyB = col.sortKey!(b);
      return _sortDir == OrionSortDirection.asc
          ? Comparable.compare(keyA, keyB)
          : Comparable.compare(keyB, keyA);
    });
    return sorted;
  }

  @override
  Widget build(BuildContext context) {
    final sortedData = _getSortedData();

    final effectiveBg = widget.backgroundColor ?? OrionColors.bgSurface;
    final effectiveHeaderBg = widget.headerBackgroundColor ?? OrionColors.primaryLight;
    final effectiveBorderColor = widget.borderColor ?? OrionColors.borderColor;
    final effectiveBorderWidth = widget.borderWidth ?? 1.5;
    final effectiveRadius = widget.borderRadius ?? OrionRadius.md;
    final effectiveHeaderTextStyle = widget.headerTextStyle ??
        const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          color: OrionColors.textMain,
        );
    final effectiveActiveSortColor = widget.sortIconActiveColor ?? OrionColors.primary;
    final effectiveInactiveSortColor = widget.sortIconInactiveColor ?? OrionColors.textSubtle;

    return Container(
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: effectiveRadius,
        border: Border.all(color: effectiveBorderColor, width: effectiveBorderWidth),
        boxShadow: widget.boxShadow,
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(effectiveHeaderBg),
            headingTextStyle: effectiveHeaderTextStyle,
            dataRowMinHeight: widget.dataRowMinHeight ?? 48,
            dataRowMaxHeight: widget.dataRowMaxHeight ?? 52,
            dividerThickness: widget.dividerThickness ?? 1,
            horizontalMargin: widget.horizontalMargin ?? 16,
            columnSpacing: widget.columnSpacing ?? 24,
            columns: List.generate(widget.columns.length, (idx) {
              final col = widget.columns[idx];
              final isSorted = _sortColIndex == idx;

              return DataColumn(
                label: InkWell(
                  onTap: col.sortable ? () => _handleSort(idx) : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(col.header),
                      if (col.sortable) ...[
                        const SizedBox(width: 4),
                        Icon(
                          isSorted
                              ? (_sortDir == OrionSortDirection.asc
                                  ? Icons.arrow_upward
                                  : Icons.arrow_downward)
                              : Icons.unfold_more,
                          size: 14,
                          color: isSorted
                              ? effectiveActiveSortColor
                              : effectiveInactiveSortColor,
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
            rows: sortedData.isEmpty
                ? [
                    DataRow(
                      cells: [
                        DataCell(
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24),
                              child: Text(
                                widget.emptyMessage,
                                style: const TextStyle(color: OrionColors.textSubtle),
                              ),
                            ),
                          ),
                        ),
                        ...List.generate(
                          widget.columns.length - 1,
                          (_) => const DataCell(SizedBox.shrink()),
                        ),
                      ],
                    )
                  ]
                : sortedData.map((item) {
                    return DataRow(
                      cells: widget.columns.map((col) {
                        return DataCell(
                          col.cellBuilder != null
                              ? col.cellBuilder!(item)
                              : Text(
                                  col.sortKey != null ? col.sortKey!(item).toString() : '',
                                  style: const TextStyle(
                                    fontSize: 13.5,
                                    color: OrionColors.textSecondary,
                                  ),
                                ),
                        );
                      }).toList(),
                    );
                  }).toList(),
          ),
        ),
      ),
    );
  }
}
