import React, { useState } from 'react';
import { ArrowUp, ArrowDown, ArrowUpDown } from 'lucide-react';

export const DataGrid = ({
  columns = [],
  data = [],
  keyField = 'id',
  onSort,
  emptyMessage = 'No records found',
  className = '',
  style
}) => {
  const [sortField, setSortField] = useState(null);
  const [sortDirection, setSortDirection] = useState('asc');

  const handleHeaderClick = (col) => {
    if (!col.sortable && col.sortable !== undefined) return;
    const field = col.field;
    let nextDir = 'asc';
    if (sortField === field) {
      nextDir = sortDirection === 'asc' ? 'desc' : 'asc';
    }
    setSortField(field);
    setSortDirection(nextDir);
    if (onSort) onSort(field, nextDir);
  };

  const sortedData = [...data].sort((a, b) => {
    if (!sortField) return 0;
    const valA = a[sortField];
    const valB = b[sortField];
    if (valA === valB) return 0;
    if (valA === null || valA === undefined) return 1;
    if (valB === null || valB === undefined) return -1;
    if (typeof valA === 'string') {
      return sortDirection === 'asc' 
        ? valA.localeCompare(String(valB)) 
        : String(valB).localeCompare(valA);
    }
    return sortDirection === 'asc' ? valA - valB : valB - valA;
  });

  return (
    <div className={`orion-datagrid-container ${className}`} style={style}>
      <table className="orion-datagrid">
        <thead>
          <tr>
            {columns.map((col, idx) => {
              const isSorted = sortField === col.field;
              return (
                <th
                  key={idx}
                  onClick={() => handleHeaderClick(col)}
                  style={{
                    cursor: col.sortable !== false ? 'pointer' : 'default',
                    width: col.width,
                    minWidth: col.minWidth,
                    textAlign: col.align || 'left',
                    ...col.headerStyle
                  }}
                  title={col.sortable !== false ? `Sort by ${col.header}` : undefined}
                >
                  <div style={{ display: 'flex', alignItems: 'center', justifyContent: col.align === 'right' ? 'flex-end' : 'space-between', gap: '4px' }}>
                    <span>{col.header}</span>
                    {col.sortable !== false && (
                      isSorted ? (
                        sortDirection === 'asc' ? <ArrowUp size={14} strokeWidth={2.8} /> : <ArrowDown size={14} strokeWidth={2.8} />
                      ) : (
                        <ArrowUpDown size={13} style={{ opacity: 0.35 }} />
                      )
                    )}
                  </div>
                </th>
              );
            })}
          </tr>
        </thead>
        <tbody>
          {sortedData.length === 0 ? (
            <tr>
              <td colSpan={columns.length} style={{ textAlign: 'center', padding: '2rem', color: '#94a3b8' }}>
                {emptyMessage}
              </td>
            </tr>
          ) : (
            sortedData.map((row, rowIdx) => (
              <tr key={row[keyField] || rowIdx}>
                {columns.map((col, colIdx) => (
                  <td key={colIdx} style={{ textAlign: col.align || 'left', ...col.cellStyle }}>
                    {col.render ? col.render(row[col.field], row) : row[col.field]}
                  </td>
                ))}
              </tr>
            ))
          )}
        </tbody>
      </table>
    </div>
  );
};

export default DataGrid;
