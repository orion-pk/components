import React from 'react';

export const Sidebar = ({
  items = [],
  activeItem,
  onSelect,
  collapsed = false,
  headerTitle = 'Navigation',
  className = '',
  style
}) => (
  <aside
    className={`orion-sidebar ${className}`}
    style={{
      width: collapsed ? '70px' : '240px',
      background: '#FFFFFF',
      borderRight: '1.5px solid #cbd5e1',
      display: 'flex',
      flexDirection: 'column',
      padding: '1rem 0.75rem',
      transition: 'width 0.2s ease',
      height: '100%',
      boxSizing: 'border-box',
      ...style
    }}
  >
    {!collapsed && headerTitle && (
      <div
        style={{
          fontSize: '0.72rem',
          fontWeight: 800,
          color: '#94a3b8',
          textTransform: 'uppercase',
          marginBottom: '8px',
          paddingLeft: '10px',
          letterSpacing: '0.5px'
        }}
      >
        {headerTitle}
      </div>
    )}

    <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
      {items.map((item) => {
        const isAct = activeItem === item.key;
        return (
          <button
            key={item.key}
            type="button"
            onClick={() => onSelect && onSelect(item.key, item)}
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: '10px',
              padding: collapsed ? '10px' : '9px 12px',
              borderRadius: '8px',
              border: isAct ? '1px solid #bfdbfe' : '1px solid transparent',
              background: isAct ? '#e5f3f7' : 'transparent',
              color: isAct ? '#02658b' : '#475569',
              fontWeight: isAct ? 700 : 500,
              cursor: 'pointer',
              fontSize: '0.86rem',
              textAlign: 'left',
              justifyContent: collapsed ? 'center' : 'flex-start',
              transition: 'all 0.15s ease'
            }}
            title={collapsed ? item.label : undefined}
          >
            {item.icon && <span style={{ display: 'flex', color: isAct ? '#02658b' : '#64748b' }}>{item.icon}</span>}
            {!collapsed && <span>{item.label}</span>}
          </button>
        );
      })}
    </div>
  </aside>
);

export default Sidebar;
