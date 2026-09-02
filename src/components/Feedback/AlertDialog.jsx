import React from 'react';
import { createPortal } from 'react-dom';
import { CheckCircle2, AlertCircle, AlertTriangle, Info, X } from 'lucide-react';

export const AlertDialog = ({
  isOpen,
  title = 'Notification',
  description,
  variant = 'info',
  confirmText = 'Got it',
  onClose,
  className = '',
  style
}) => {
  if (!isOpen) return null;

  const iconMap = {
    success: <CheckCircle2 size={24} color="#10b981" />,
    danger: <AlertCircle size={24} color="#ef4444" />,
    warning: <AlertTriangle size={24} color="#f59e0b" />,
    info: <Info size={24} color="#02658b" />
  };

  const modalContent = (
    <div
      className={`orion-modal-overlay alert-dialog-portal ${className}`}
      style={{
        position: 'fixed',
        inset: 0,
        backgroundColor: 'rgba(15, 23, 42, 0.5)',
        backdropFilter: 'blur(4px)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        zIndex: 10000,
        padding: '1rem',
        ...style
      }}
      onClick={onClose}
    >
      <div
        className="orion-modal-box"
        style={{
          background: '#FFFFFF',
          borderRadius: '0.75rem',
          border: '1.5px solid #cbd5e1',
          width: '100%',
          maxWidth: '420px',
          padding: '1.5rem',
          display: 'flex',
          flexDirection: 'column',
          gap: '1rem',
          boxShadow: '0 20px 25px -5px rgba(0,0,0,0.15)',
        }}
        onClick={(e) => e.stopPropagation()}
      >
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '0.75rem' }}>
            {iconMap[variant] || iconMap.info}
            <h3 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 700, color: '#0f172a' }}>
              {title}
            </h3>
          </div>
          <button
            type="button"
            onClick={onClose}
            style={{ background: 'none', border: 'none', color: '#64748b', cursor: 'pointer' }}
          >
            <X size={18} />
          </button>
        </div>

        <div style={{ fontSize: '0.9rem', color: '#334155', lineHeight: 1.5 }}>
          {description}
        </div>

        <div style={{ display: 'flex', justifyContent: 'flex-end', marginTop: '0.5rem' }}>
          <button
            type="button"
            onClick={onClose}
            style={{
              background: '#02658b',
              border: 'none',
              color: '#FFFFFF',
              padding: '0.5rem 1.25rem',
              borderRadius: '0.375rem',
              cursor: 'pointer',
              fontWeight: 600,
              fontSize: '0.85rem',
            }}
          >
            {confirmText}
          </button>
        </div>
      </div>
    </div>
  );

  return typeof document !== 'undefined' ? createPortal(modalContent, document.body) : modalContent;
};

export default AlertDialog;
