import React from 'react';
import { ArrowUpRight, ArrowDownRight } from 'lucide-react';

export const StatCard = ({
  title,
  value,
  change,
  changeType = 'up',
  icon,
  subtitle,
  className = '',
  style,
  onClick
}) => (
  <div
    className={`orion-stat-card ${className}`}
    onClick={onClick}
    style={{
      background: '#FFFFFF',
      border: '1.5px solid #cbd5e1',
      borderRadius: '10px',
      padding: '1.25rem',
      boxShadow: '0 1px 3px rgba(0,0,0,0.03)',
      display: 'flex',
      flexDirection: 'column',
      gap: '0.5rem',
      cursor: onClick ? 'pointer' : 'default',
      ...style
    }}
  >
    <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
      <span style={{ fontSize: '0.84rem', color: '#64748b', fontWeight: 600 }}>{title}</span>
      {icon && (
        <div style={{ color: '#02658b', background: '#e5f3f7', padding: '6px', borderRadius: '6px', display: 'flex' }}>
          {icon}
        </div>
      )}
    </div>
    <div style={{ fontSize: '1.8rem', fontWeight: 800, color: '#0f172a', letterSpacing: '-0.02em' }}>
      {value}
    </div>
    {(change || subtitle) && (
      <div style={{ display: 'flex', alignItems: 'center', gap: '6px', fontSize: '0.8rem' }}>
        {change && (
          <span
            style={{
              color: changeType === 'up' ? '#10b981' : '#ef4444',
              fontWeight: 700,
              display: 'inline-flex',
              alignItems: 'center',
              gap: '2px'
            }}
          >
            {changeType === 'up' ? <ArrowUpRight size={14} /> : <ArrowDownRight size={14} />}
            {change}
          </span>
        )}
        {subtitle && <span style={{ color: '#94a3b8' }}>{subtitle}</span>}
      </div>
    )}
  </div>
);

export default StatCard;
