import React from 'react';
import { VersionBadge } from './VersionBadge.jsx';
import { ProfileDropdown } from './ProfileDropdown.jsx';

export const Navbar = ({
  brandName = 'Orion Academy',
  logo,
  user = { name: 'Super Admin', email: 'admin@orion.edu', role: 'Super Admin' },
  currentVersion = 'v2.4.0',
  hasUpdate = false,
  onLogout,
  onSettings,
  rightActions,
  className = '',
  style
}) => (
  <header
    className={`orion-navbar ${className}`}
    style={{
      height: '60px',
      background: '#FFFFFF',
      borderBottom: '1.5px solid #cbd5e1',
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'space-between',
      padding: '0 1.5rem',
      position: 'sticky',
      top: 0,
      zIndex: 100,
      boxShadow: '0 1px 3px rgba(0,0,0,0.02)',
      ...style
    }}
  >
    <div style={{ display: 'flex', alignItems: 'center', gap: '10px' }}>
      {logo && <div style={{ display: 'flex', alignItems: 'center' }}>{logo}</div>}
      <span style={{ fontWeight: 800, fontSize: '1.15rem', color: '#02658b', letterSpacing: '-0.01em' }}>
        {brandName}
      </span>
    </div>

    <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
      {rightActions}
      <VersionBadge currentVersion={currentVersion} hasUpdate={hasUpdate} />
      <ProfileDropdown user={user} onLogout={onLogout} onSettings={onSettings} />
    </div>
  </header>
);

export default Navbar;
