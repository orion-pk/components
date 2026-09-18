import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import 'orion_pagination.dart';

enum OrionSortDirection { asc, desc }

class OrionDataColumn<T> {
  final String header;
  final String? field;
  final Widget Function(T item)? cellBuilder;
  final double? width;
  final double? minWidth;
  final int? flex;
  final bool sortable;
  final TextAlign align;
  final Comparable Function(T item)? sortKey;

  const OrionDataColumn({
    required this.header,
    this.field,
    this.cellBuilder,
    this.width,
    this.minWidth,
    this.flex,
    this.sortable = true,
    this.align = TextAlign.left,
    this.sortKey,
  });
}

/// Orion DataGrid widget mirroring `DataGrid.jsx` with full styling and layout customization.
class OrionDataGrid<T> extends StatefulWidget {
  final List<OrionDataColumn<T>> columns;
  final List<T> data;
  final String emptyMessage;

  // Sorting
  final String? initialSortField;
  final bool initialSortAscending;

  // Interactivity
  final void Function(T item)? onRowTap;

  // Sizing & Layout
  final double? minTableWidth;
  final double? rowMinHeight;
  final double? dataRowMinHeight;
  final double? dataRowMaxHeight;
  final double? horizontalMargin;
  final double? columnSpacing;

  // Dividers & Borders
  final bool showColumnDividers;
  final bool showHorizontalDividers;
  final Color? columnDividerColor;
  final Color? horizontalDividerColor;
  final double? dividerThickness;
  final Color? borderColor;
  final double? borderWidth;
  final BorderRadius? borderRadius;

  // Styling
  final Color? backgroundColor;
  final Color? headerBackgroundColor;
  final TextStyle? headerTextStyle;
  final Color? dataRowColor;
  final Color? dataRowEvenColor;
  final Color? hoverColor;
  final List<BoxShadow>? boxShadow;
  final Color? sortIconActiveColor;
  final Color? sortIconInactiveColor;

  // Pagination
  final bool enablePagination;
  final int defaultPageSize;
  final List<int> pageSizeOptions;

  const OrionDataGrid({
    super.key,
    required this.columns,
    required this.data,
    this.emptyMessage = 'No records found',
    this.initialSortField,
    this.initialSortAscending = true,
    this.onRowTap,
    this.minTableWidth,
    this.rowMinHeight,
    this.dataRowMinHeight,
    this.dataRowMaxHeight,
    this.horizontalMargin,
    this.columnSpacing,
    this.showColumnDividers = false,
    this.showHorizontalDividers = true,
    this.columnDividerColor,
    this.horizontalDividerColor,
    this.dividerThickness,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.backgroundColor,
    this.headerBackgroundColor,
    this.headerTextStyle,
    this.dataRowColor,
    this.dataRowEvenColor,
    this.hoverColor,
    this.boxShadow,
    this.sortIconActiveColor,
    this.sortIconInactiveColor,
    this.enablePagination = false,
    this.defaultPageSize = 10,
    this.pageSizeOptions = const [10, 20, 30, 50],
  });

  @override
  State<OrionDataGrid<T>> createState() => _OrionDataGridState<T>();
}

class _OrionDataGridState<T> extends State<OrionDataGrid<T>> {
  int? _sortColIndex;
  OrionSortDirection _sortDir = OrionSortDirection.asc;
  int _currentPage = 1;
  late int _pageSize;

  @override
  void initState() {
    super.initState();
    _pageSize = widget.defaultPageSize;
    if (widget.initialSortField != null) {
      final idx = widget.columns.indexWhere((c) => c.field == widget.initialSortField);
      if (idx != -1) {
        _sortColIndex = idx;
        _sortDir = widget.initialSortAscending
            ? OrionSortDirection.asc
            : OrionSortDirection.desc;
      }
    }
  }

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

  Alignment _getAlignment(TextAlign align) {
    switch (align) {
      case TextAlign.right:
        return Alignment.centerRight;
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.left:
      case TextAlign.start:
      case TextAlign.justify:
      default:
        return Alignment.centerLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedData = _getSortedData();
    final totalPages =
        sortedData.isEmpty ? 1 : (sortedData.length / _pageSize).ceil();
    if (_currentPage > totalPages) _currentPage = totalPages;
    if (_currentPage < 1) _currentPage = 1;

    final displayData = widget.enablePagination
        ? sortedData
            .skip((_currentPage - 1) * _pageSize)
            .take(_pageSize)
            .toList()
        : sortedData;

    final effectiveBg = widget.backgroundColor ?? OrionColors.bgSurface;
    final effectiveHeaderBg =
        widget.headerBackgroundColor ?? OrionColors.primaryLight;
    final effectiveBorderColor = widget.borderColor ?? OrionColors.borderColor;
    final effectiveBorderWidth = widget.borderWidth ?? 1.2;
    final effectiveRadius = widget.borderRadius ?? OrionRadius.md;
    final effectiveHeaderTextStyle = widget.headerTextStyle ??
        const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
          color: OrionColors.textMain,
        );
    final effectiveActiveSortColor =
        widget.sortIconActiveColor ?? OrionColors.primary;
    final effectiveInactiveSortColor =
        widget.sortIconInactiveColor ?? OrionColors.textSubtle;
    final effectiveColDividerColor =
        widget.columnDividerColor ?? widget.borderColor ?? OrionColors.borderColor;
    final effectiveHorizDividerColor =
        widget.horizontalDividerColor ?? widget.borderColor ?? OrionColors.borderColor;
    final effectiveDividerThickness = widget.dividerThickness ?? 1.0;
    final effectiveRowMinHeight =
        widget.rowMinHeight ?? widget.dataRowMinHeight ?? 48.0;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: effectiveRadius,
        border: Border.all(
          color: effectiveBorderColor,
          width: effectiveBorderWidth,
        ),
        boxShadow: widget.boxShadow ?? OrionShadows.sm,
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final minW = widget.minTableWidth ?? 0.0;
              final effectiveWidth = constraints.maxWidth > minW
                  ? constraints.maxWidth
                  : minW;

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: effectiveWidth > 0 ? effectiveWidth : null,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header Row
                      Container(
                        decoration: BoxDecoration(
                          color: effectiveHeaderBg,
                          border: widget.showHorizontalDividers
                              ? Border(
                                  bottom: BorderSide(
                                    color: effectiveHorizDividerColor,
                                    width: effectiveDividerThickness,
                                  ),
                                )
                              : null,
                        ),
                        child: Row(
                          children: widget.columns.asMap().entries.map((entry) {
                            final idx = entry.key;
                            final col = entry.value;
                            final isLast = idx == widget.columns.length - 1;
                            final isSorted = _sortColIndex == idx;

                            final headerContent = InkWell(
                              onTap: col.sortable ? () => _handleSort(idx) : null,
                              child: Row(
                                mainAxisAlignment: col.align == TextAlign.right
                                    ? MainAxisAlignment.end
                                    : (col.align == TextAlign.center
                                        ? MainAxisAlignment.center
                                        : MainAxisAlignment.start),
                                children: [
                                  Flexible(
                                    child: Text(
                                      col.header,
                                      style: effectiveHeaderTextStyle,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
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
                            );

                            final cellChild = Container(
                              alignment: _getAlignment(col.align),
                              decoration: BoxDecoration(
                                border: isLast || !widget.showColumnDividers
                                    ? null
                                    : Border(
                                        right: BorderSide(
                                          color: effectiveColDividerColor,
                                          width: effectiveDividerThickness,
                                        ),
                                      ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: (widget.horizontalMargin ?? 16) / 2,
                                vertical: 11,
                              ),
                              child: headerContent,
                            );

                            if (col.width != null) {
                              return SizedBox(width: col.width, child: cellChild);
                            }
                            return Expanded(
                              flex: col.flex ?? 1,
                              child: cellChild,
                            );
                          }).toList(),
                        ),
                      ),

                      // Data Rows
                      if (sortedData.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 36,
                            horizontal: 24,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.search_off_rounded,
                                  size: 36,
                                  color: OrionColors.textMuted,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.emptyMessage,
                                  style: const TextStyle(
                                    color: OrionColors.textSubtle,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ...displayData.asMap().entries.map((entry) {
                          final index = entry.key;
                          final item = entry.value;
                          final isEven = index % 2 == 0;

                          return _OrionDataGridRow<T>(
                            columns: widget.columns,
                            item: item,
                            rowMinHeight: effectiveRowMinHeight,
                            rowMaxHeight: widget.dataRowMaxHeight,
                            horizontalMargin: widget.horizontalMargin ?? 16,
                            backgroundColor: isEven
                                ? (widget.dataRowColor ?? Colors.white)
                                : (widget.dataRowEvenColor ??
                                    widget.dataRowColor ??
                                    const Color(0xFFFAFAFB)),
                            hoverColor: widget.hoverColor ?? const Color(0xFFF1F7F9),
                            onTap: widget.onRowTap != null
                                ? () => widget.onRowTap!(item)
                                : null,
                            showColumnDividers: widget.showColumnDividers,
                            showHorizontalDividers: widget.showHorizontalDividers,
                            columnDividerColor: effectiveColDividerColor,
                            horizontalDividerColor: effectiveHorizDividerColor,
                            dividerThickness: effectiveDividerThickness,
                          );
                        }),
                    ],
                  ),
                ),
              );
            },
          ),
          if (widget.enablePagination && sortedData.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: effectiveBg,
                border: widget.showHorizontalDividers
                    ? Border(
                        top: BorderSide(
                          color: effectiveHorizDividerColor,
                          width: effectiveDividerThickness,
                        ),
                      )
                    : null,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: OrionPagination(
                currentPage: _currentPage,
                pageSize: _pageSize,
                totalItems: sortedData.length,
                pageSizeOptions: widget.pageSizeOptions,
                onPageChange: (newPage) =>
                    setState(() => _currentPage = newPage),
                onPageSizeChange: (newSize) => setState(() {
                  _pageSize = newSize;
                  _currentPage = 1;
                }),
              ),
            ),
        ],
      ),
    );
  }
}

class _OrionDataGridRow<T> extends StatefulWidget {
  final List<OrionDataColumn<T>> columns;
  final T item;
  final double rowMinHeight;
  final double? rowMaxHeight;
  final double horizontalMargin;
  final Color backgroundColor;
  final Color hoverColor;
  final VoidCallback? onTap;
  final bool showColumnDividers;
  final bool showHorizontalDividers;
  final Color columnDividerColor;
  final Color horizontalDividerColor;
  final double dividerThickness;

  const _OrionDataGridRow({
    super.key,
    required this.columns,
    required this.item,
    required this.rowMinHeight,
    this.rowMaxHeight,
    required this.horizontalMargin,
    required this.backgroundColor,
    required this.hoverColor,
    this.onTap,
    required this.showColumnDividers,
    required this.showHorizontalDividers,
    required this.columnDividerColor,
    required this.horizontalDividerColor,
    required this.dividerThickness,
  });

  @override
  State<_OrionDataGridRow<T>> createState() => _OrionDataGridRowState<T>();
}

class _OrionDataGridRowState<T> extends State<_OrionDataGridRow<T>> {
  bool _isHovered = false;

  Alignment _getAlignment(TextAlign align) {
    switch (align) {
      case TextAlign.right:
        return Alignment.centerRight;
      case TextAlign.center:
        return Alignment.center;
      case TextAlign.left:
      case TextAlign.start:
      case TextAlign.justify:
      default:
        return Alignment.centerLeft;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: _isHovered ? widget.hoverColor : widget.backgroundColor,
            border: widget.showHorizontalDividers
                ? Border(
                    bottom: BorderSide(
                      color: widget.horizontalDividerColor,
                      width: widget.dividerThickness,
                    ),
                  )
                : null,
          ),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.columns.asMap().entries.map((entry) {
                final i = entry.key;
                final col = entry.value;
                final isLast = i == widget.columns.length - 1;
                final alignment = _getAlignment(col.align);

                final cellWidget = Container(
                  constraints: BoxConstraints(
                    minHeight: widget.rowMinHeight,
                    maxHeight: widget.rowMaxHeight ?? double.infinity,
                  ),
                  alignment: alignment,
                  decoration: BoxDecoration(
                    border: isLast || !widget.showColumnDividers
                        ? null
                        : Border(
                            right: BorderSide(
                              color: widget.columnDividerColor,
                              width: widget.dividerThickness,
                            ),
                          ),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.horizontalMargin / 2,
                    vertical: 8,
                  ),
                  child: col.cellBuilder != null
                      ? col.cellBuilder!(widget.item)
                      : Text(
                          col.sortKey != null
                              ? col.sortKey!(widget.item).toString()
                              : '',
                          style: const TextStyle(
                            fontSize: 13,
                            color: OrionColors.textSecondary,
                          ),
                        ),
                );

                if (col.width != null) {
                  return SizedBox(width: col.width, child: cellWidget);
                }
                return Expanded(
                  flex: col.flex ?? 1,
                  child: cellWidget,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
