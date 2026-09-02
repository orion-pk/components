import React, { useState, useRef, useEffect } from 'react';
import { User, Settings, LogOut, ChevronDown } from 'lucide-react';

export const ProfileDropdown = ({
  user = { name: 'Super Admin', email: 'admin@orion.edu', role: 'Super Admin' },
  onLogout,
  onSettings,
  onProfileClick,
  className = '',
  style
}) => {
  const [isOpen, setIsOpen] = useState(false);
  const dropdownRef = useRef(null);

  useEffect(() => {
    const handleClickOutside = (e) => {
      if (dropdownRef.current && !dropdownRef.current.contains(e.target)) {
        setIsOpen(false);
      }
    };
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const initials = user?.name ? user.name.substring(0, 2).toUpperCase() : 'U';

  return (
    <div className={`orion-profile-dropdown ${className}`} ref={dropdownRef} style={{ position: 'relative', ...style }}>
      <button
        type="button"
        onClick={() => setIsOpen(!isOpen)}
        style={{
          display: 'flex',
          alignItems: 'center',
          gap: '8px',
          background: 'none',
          border: 'none',
          cursor: 'pointer',
          padding: '4px',
          borderRadius: '8px',
          outline: 'none'
        }}
      >
        <div
          style={{
            width: '36px',
            height: '36px',
            borderRadius: '50%',
            backgroundColor: '#02658b',
            color: '#FFFFFF',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            fontWeight: 800,
            fontSize: '0.85rem',
            flexShrink: 0
          }}
        >
          {initials}
        </div>
        <div style={{ textAlign: 'left', display: 'none', sm: 'block' }}>
          <div style={{ fontSize: '0.85rem', fontWeight: 700, color: '#0f172a', lineHeight: 1.1 }}>
            {user?.name}
          </div>
          <div style={{ fontSize: '0.72rem', color: '#64748b' }}>
            {user?.role}
          </div>
        </div>
        <ChevronDown size={14} color="#64748b" />
      </button>

      {isOpen && (
        <div
          style={{
            position: 'absolute',
            right: 0,
            top: '46px',
            background: '#FFFFFF',
            borderRadius: '8px',
            border: '1.5px solid #cbd5e1',
            boxShadow: '0 10px 15px -3px rgba(0, 0, 0, 0.1)',
            minWidth: '200px',
            padding: '6px',
            zIndex: 1000,
            display: 'flex',
            flexDirection: 'column',
            gap: '2px'
          }}
        >
          <div style={{ padding: '8px 10px', borderBottom: '1px solid #f1f5f9' }}>
            <div style={{ fontSize: '0.85rem', fontWeight: 700, color: '#0f172a' }}>{user?.name}</div>
            <div style={{ fontSize: '0.75rem', color: '#64748b' }}>{user?.email}</div>
          </div>

          {onProfileClick && (
            <button
              type="button"
              onClick={() => { setIsOpen(false); onProfileClick(); }}
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '8px',
                width: '100%',
                padding: '8px 10px',
                borderRadius: '6px',
                border: 'none',
                background: 'none',
                color: '#334155',
                fontSize: '0.82rem',
                fontWeight: 600,
                cursor: 'pointer',
                textAlign: 'left'
              }}
            >
              <User size={14} /> Profile
            </button>
          )}

          {onSettings && (
            <button
              type="button"
              onClick={() => { setIsOpen(false); onSettings(); }}
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '8px',
                width: '100%',
                padding: '8px 10px',
                borderRadius: '6px',
                border: 'none',
                background: 'none',
                color: '#334155',
                fontSize: '0.82rem',
                fontWeight: 600,
                cursor: 'pointer',
                textAlign: 'left'
              }}
            >
              <Settings size={14} /> Settings
            </button>
          )}

          {onLogout && (
            <button
              type="button"
              onClick={() => { setIsOpen(false); onLogout(); }}
              style={{
                display: 'flex',
                alignItems: 'center',
                gap: '8px',
                width: '100%',
                padding: '8px 10px',
                borderRadius: '6px',
                border: 'none',
                background: 'none',
                color: '#dc2626',
                fontSize: '0.82rem',
                fontWeight: 600,
                cursor: 'pointer',
                textAlign: 'left',
                borderTop: '1px solid #f1f5f9'
              }}
            >
              <LogOut size={14} /> Sign Out
            </button>
          )}
        </div>
      )}
    </div>
  );
};

export default ProfileDropdown;
