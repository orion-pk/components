import React from 'react';
import { Filter } from 'lucide-react';

export const FilterButton = ({
  label = 'Filter',
  count,
  active = false,
  onClick,
  className = '',
  style
}) => (
  <button
    type="button"
    onClick={onClick}
    className={`orion-filter-btn ${active ? 'active' : ''} ${className}`}
    style={{
      display: 'inline-flex',
      alignItems: 'center',
      gap: '6px',
      padding: '0.35rem 0.85rem',
      borderRadius: '50px',
      border: active ? '1.5px solid #02658b' : '1.5px solid #cbd5e1',
      background: active ? '#e5f3f7' : '#FFFFFF',
      color: active ? '#02658b' : '#475569',
      fontSize: '0.82rem',
      fontWeight: 600,
      cursor: 'pointer',
      transition: 'all 0.15s ease',
      boxShadow: active ? '0 1px 3px rgba(2,101,139,0.1)' : 'none',
      ...style
    }}
  >
    <Filter size={14} color={active ? '#02658b' : '#64748b'} />
    <span>{label}</span>
    {count !== undefined && (
      <span
        style={{
          background: active ? '#02658b' : '#cbd5e1',
          color: '#FFFFFF',
          padding: '1px 6px',
          borderRadius: '9999px',
          fontSize: '0.72rem',
          fontWeight: 700
        }}
      >
        {count}
      </span>
    )}
  </button>
);

export default FilterButton;
