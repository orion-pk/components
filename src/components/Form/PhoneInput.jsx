import React from 'react';
import { Phone } from 'lucide-react';

export const PhoneInput = ({
  label = 'Phone Number',
  value = '',
  onChange,
  placeholder = '123 045 223 48',
  error,
  maxLength = 14,
  required = false,
  className = '',
  style
}) => {
  const handleInputChange = (e) => {
    // Filter only digits and space / plus
    const raw = e.target.value.replace(/[^\d+ ]/g, '');
    if (onChange) {
      onChange(raw.slice(0, maxLength));
    }
  };

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '4px', width: '100%', ...style }} className={className}>
      {label && (
        <label style={{ fontSize: '0.78rem', fontWeight: 700, color: '#334155' }}>
          {label} {required && <span style={{ color: '#ef4444' }}>*</span>}
        </label>
      )}
      <div style={{ position: 'relative', display: 'flex', alignItems: 'center', width: '100%' }}>
        <Phone size={14} color="#94a3b8" style={{ position: 'absolute', left: '12px', pointerEvents: 'none' }} />
        <input
          type="tel"
          value={value}
          onChange={handleInputChange}
          placeholder={placeholder}
          style={{
            width: '100%',
            height: '38px',
            borderRadius: '8px',
            border: error ? '1.5px solid #ef4444' : '1.5px solid #cbd5e1',
            padding: '0 12px 0 34px',
            fontSize: '0.85rem',
            color: '#0f172a',
            outline: 'none',
            background: '#FFFFFF',
            boxSizing: 'border-box'
          }}
        />
      </div>
      {error && <span style={{ color: '#ef4444', fontSize: '0.75rem', fontWeight: 600 }}>{error}</span>}
    </div>
  );
};

export default PhoneInput;
