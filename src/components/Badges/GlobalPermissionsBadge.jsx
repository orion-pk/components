import React from 'react';
import { ShieldCheck } from 'lucide-react';

export const GlobalPermissionsBadge = ({
  role = 'Super Admin',
  permissionsCount,
  customText,
  className = '',
  style
}) => (
  <div 
    className={`orion-permissions-badge ${className}`}
    style={{
      display: 'inline-flex',
      alignItems: 'center',
      gap: '8px',
      background: '#e5f3f7',
      color: '#02658b',
      padding: '6px 14px',
      borderRadius: '9999px',
      fontSize: '0.82rem',
      fontWeight: 700,
      border: '1.5px solid #bfdbfe',
      boxShadow: '0 1px 2px rgba(2,101,139,0.05)',
      ...style
    }}
  >
    <ShieldCheck size={16} strokeWidth={2.4} />
    <span>
      {customText || `${role}${permissionsCount !== undefined ? ` (${permissionsCount} Permissions)` : ''}`}
    </span>
  </div>
);

export default GlobalPermissionsBadge;
