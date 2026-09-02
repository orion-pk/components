import React from 'react';
import { Copy, Edit2, Trash2 } from 'lucide-react';

export const UserDetailsCard = ({
  user = {},
  onEdit,
  onDelete,
  onCopyInvite,
  className = '',
  style
}) => {
  const { name = 'User Name', email = 'user@example.com', role = 'User', phoneNumber, cnic } = user;
  const initials = name ? name.substring(0, 2).toUpperCase() : 'U';

  return (
    <div
      className={`orion-user-details-card ${className}`}
      style={{
        background: '#FFFFFF',
        border: '1.5px solid #cbd5e1',
        borderRadius: '10px',
        padding: '1.25rem',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'space-between',
        boxShadow: '0 1px 3px rgba(0,0,0,0.03)',
        flexWrap: 'wrap',
        gap: '1rem',
        ...style
      }}
    >
      <div style={{ display: 'flex', alignItems: 'center', gap: '12px' }}>
        <div
          style={{
            width: '46px',
            height: '46px',
            borderRadius: '50%',
            backgroundColor: '#02658b',
            color: '#FFFFFF',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
            fontWeight: 800,
            fontSize: '1rem',
            flexShrink: 0
          }}
        >
          {initials}
        </div>
        <div>
          <div style={{ fontWeight: 700, fontSize: '0.98rem', color: '#0f172a' }}>{name}</div>
          <div style={{ fontSize: '0.82rem', color: '#64748b', display: 'flex', alignItems: 'center', gap: '8px', flexWrap: 'wrap' }}>
            <span>{email}</span>
            <span>•</span>
            <span style={{ color: '#02658b', fontWeight: 700, background: '#e5f3f7', padding: '2px 8px', borderRadius: '4px' }}>
              {role}
            </span>
            {phoneNumber && <span>• {phoneNumber}</span>}
            {cnic && <span>• CNIC: {cnic}</span>}
          </div>
        </div>
      </div>

      <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
        {onCopyInvite && (
          <button
            type="button"
            onClick={onCopyInvite}
            style={{
              padding: '6px 12px',
              borderRadius: '6px',
              border: '1.5px solid #cbd5e1',
              background: '#FFFFFF',
              color: '#334155',
              fontSize: '0.82rem',
              fontWeight: 600,
              cursor: 'pointer',
              display: 'flex',
              alignItems: 'center',
              gap: '4px'
            }}
          >
            <Copy size={13} /> Copy Link
          </button>
        )}
        {onEdit && (
          <button
            type="button"
            onClick={onEdit}
            style={{
              padding: '6px 12px',
              borderRadius: '6px',
              border: '1.5px solid #cbd5e1',
              background: '#f1f5f9',
              color: '#334155',
              fontSize: '0.82rem',
              fontWeight: 600,
              cursor: 'pointer',
              display: 'flex',
              alignItems: 'center',
              gap: '4px'
            }}
          >
            <Edit2 size={13} /> Edit
          </button>
        )}
        {onDelete && (
          <button
            type="button"
            onClick={onDelete}
            style={{
              padding: '6px 12px',
              borderRadius: '6px',
              border: 'none',
              background: '#9f1239',
              color: '#FFFFFF',
              fontSize: '0.82rem',
              fontWeight: 600,
              cursor: 'pointer',
              display: 'flex',
              alignItems: 'center',
              gap: '4px'
            }}
          >
            <Trash2 size={13} /> Delete
          </button>
        )}
      </div>
    </div>
  );
};

export default UserDetailsCard;
