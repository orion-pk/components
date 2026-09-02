import React from 'react';
import { Search, X, SlidersHorizontal } from 'lucide-react';

export const SearchBar = ({
  value = '',
  onChange,
  onClear,
  placeholder = 'Search by name, role, email, phone or CNIC...',
  showFilterToggle = false,
  onFilterToggle,
  filterActive = false,
  className = '',
  style
}) => (
  <div
    className={`orion-search-bar ${className}`}
    style={{
      position: 'relative',
      display: 'flex',
      alignItems: 'center',
      width: '100%',
      ...style
    }}
  >
    <Search
      size={16}
      color="#64748b"
      style={{
        position: 'absolute',
        left: '12px',
        pointerEvents: 'none'
      }}
    />
    <input
      type="text"
      value={value}
      onChange={(e) => onChange && onChange(e.target.value)}
      placeholder={placeholder}
      style={{
        width: '100%',
        height: '38px',
        borderRadius: '8px',
        border: '1.5px solid #cbd5e1',
        padding: showFilterToggle ? '0 68px 0 36px' : '0 36px 0 36px',
        fontSize: '0.85rem',
        color: '#0f172a',
        outline: 'none',
        background: '#FFFFFF',
        transition: 'border-color 0.15s ease',
        boxSizing: 'border-box'
      }}
    />
    <div style={{ position: 'absolute', right: '8px', display: 'flex', alignItems: 'center', gap: '4px' }}>
      {value && (
        <button
          type="button"
          onClick={() => {
            if (onClear) onClear();
            else if (onChange) onChange('');
          }}
          style={{
            background: 'none',
            border: 'none',
            color: '#94a3b8',
            cursor: 'pointer',
            padding: '4px',
            display: 'flex',
            alignItems: 'center'
          }}
          title="Clear search"
        >
          <X size={14} />
        </button>
      )}
      {showFilterToggle && (
        <button
          type="button"
          onClick={onFilterToggle}
          style={{
            background: filterActive ? '#e5f3f7' : 'none',
            border: filterActive ? '1px solid #bfdbfe' : 'none',
            color: filterActive ? '#02658b' : '#64748b',
            borderRadius: '4px',
            padding: '4px 6px',
            cursor: 'pointer',
            display: 'flex',
            alignItems: 'center'
          }}
          title="Toggle filters"
        >
          <SlidersHorizontal size={15} />
        </button>
      )}
    </div>
  </div>
);

export default SearchBar;
