import React from 'react';

export const FormSelect = ({
  label,
  options = [],
  value,
  onChange,
  error,
  placeholder = 'Select an option',
  required = false,
  className = '',
  style
}) => (
  <div style={{ display: 'flex', flexDirection: 'column', gap: '4px', width: '100%', ...style }} className={className}>
    {label && (
      <label style={{ fontSize: '0.78rem', fontWeight: 700, color: '#334155' }}>
        {label} {required && <span style={{ color: '#ef4444' }}>*</span>}
      </label>
    )}
    <select
      value={value}
      onChange={(e) => onChange && onChange(e.target.value)}
      style={{
        width: '100%',
        height: '38px',
        borderRadius: '8px',
        border: error ? '1.5px solid #ef4444' : '1.5px solid #cbd5e1',
        padding: '0 10px',
        fontSize: '0.85rem',
        color: '#0f172a',
        outline: 'none',
        background: '#FFFFFF',
        cursor: 'pointer',
        boxSizing: 'border-box'
      }}
    >
      {placeholder && <option value="">{placeholder}</option>}
      {options.map((opt, i) => {
        const val = typeof opt === 'object' ? opt.value : opt;
        const lbl = typeof opt === 'object' ? opt.label : opt;
        return (
          <option key={i} value={val}>
            {lbl}
          </option>
        );
      })}
    </select>
    {error && <span style={{ color: '#ef4444', fontSize: '0.75rem', fontWeight: 600 }}>{error}</span>}
  </div>
);

export default FormSelect;
