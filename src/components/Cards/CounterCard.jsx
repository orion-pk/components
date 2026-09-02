import React from 'react';

export const CounterCard = ({ label, count, icon, className = '', style, onClick }) => (
  <div
    className={`orion-counter-card ${className}`}
    onClick={onClick}
    style={{
      background: '#FFFFFF',
      border: '1.5px solid #cbd5e1',
      borderRadius: '8px',
      padding: '0.9rem 1.15rem',
      display: 'flex',
      alignItems: 'center',
      gap: '0.85rem',
      boxShadow: '0 1px 3px rgba(0,0,0,0.02)',
      cursor: onClick ? 'pointer' : 'default',
      ...style
    }}
  >
    {icon && (
      <div
        style={{
          background: '#e5f3f7',
          color: '#02658b',
          padding: '8px',
          borderRadius: '8px',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          flexShrink: 0
        }}
      >
        {icon}
      </div>
    )}
    <div>
      <div style={{ fontSize: '1.35rem', fontWeight: 800, color: '#0f172a', lineHeight: 1.1 }}>
        {count}
      </div>
      <div style={{ fontSize: '0.78rem', color: '#64748b', fontWeight: 600 }}>
        {label}
      </div>
    </div>
  </div>
);

export default CounterCard;
