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

/// Orion DataGrid widget mirroring `DataGrid.jsx`
class OrionDataGrid<T> extends StatefulWidget {
  final List<OrionDataColumn<T>> columns;
  final List<T> data;
  final String emptyMessage;

  const OrionDataGrid({
    super.key,
    required this.columns,
    required this.data,
    this.emptyMessage = 'No records found',
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

    return Container(
      decoration: BoxDecoration(
        color: OrionColors.bgSurface,
        borderRadius: OrionRadius.md,
        border: Border.all(color: OrionColors.borderColor, width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            headingRowColor: WidgetStateProperty.all(OrionColors.primaryLight),
            headingTextStyle: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: OrionColors.textMain,
            ),
            dataRowMinHeight: 48,
            dataRowMaxHeight: 52,
            dividerThickness: 1,
            horizontalMargin: 16,
            columnSpacing: 24,
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
                          color: isSorted ? OrionColors.primary : OrionColors.textSubtle,
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
