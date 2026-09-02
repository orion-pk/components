import React from 'react';
import { createPortal } from 'react-dom';
import { RefreshCw, ArrowUpCircle, CheckCircle2, X } from 'lucide-react';
import { Button } from '../Form/Button.jsx';

export const UpdateDialog = ({
  isOpen,
  currentVersion = 'v2.4.0',
  latestVersion = 'v2.4.1',
  hasUpdate = false,
  releaseNotes = ['Optimized User & Role Management DataGrid', 'Improved modal form validation and phone number limits', 'Enhanced system stability and faster synchronization'],
  onClose,
  onUpdateDownload,
  updating = false,
  className = '',
  style
}) => {
  if (!isOpen) return null;

  const modalContent = (
    <div
      className={`orion-modal-overlay update-dialog-portal ${className}`}
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
          borderRadius: '12px',
          border: '1.5px solid #cbd5e1',
          width: '100%',
          maxWidth: '460px',
          padding: '1.5rem',
          display: 'flex',
          flexDirection: 'column',
          gap: '1rem',
          boxShadow: '0 20px 25px -5px rgba(0,0,0,0.15)',
        }}
        onClick={(e) => e.stopPropagation()}
      >
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
            <div
              style={{
                width: '36px',
                height: '36px',
                borderRadius: '50%',
                background: hasUpdate ? '#fef3c7' : '#e5f3f7',
                color: hasUpdate ? '#b45309' : '#02658b',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center'
              }}
            >
              {hasUpdate ? <ArrowUpCircle size={20} /> : <CheckCircle2 size={20} />}
            </div>
            <div>
              <h3 style={{ margin: 0, fontSize: '1.1rem', fontWeight: 800, color: '#0f172a' }}>
                {hasUpdate ? 'System Update Available' : 'System Up to Date'}
              </h3>
              <div style={{ fontSize: '0.78rem', color: '#64748b' }}>
                Installed: <strong>{currentVersion}</strong> {hasUpdate && `→ Latest: ${latestVersion}`}
              </div>
            </div>
          </div>
          <button
            type="button"
            onClick={onClose}
            style={{ background: 'none', border: 'none', color: '#94a3b8', cursor: 'pointer' }}
          >
            <X size={18} />
          </button>
        </div>

        {hasUpdate ? (
          <div>
            <div style={{ fontSize: '0.85rem', fontWeight: 700, color: '#334155', marginBottom: '6px' }}>
              What's New in {latestVersion}:
            </div>
            <ul style={{ margin: 0, paddingLeft: '1.2rem', fontSize: '0.82rem', color: '#475569', lineHeight: 1.6 }}>
              {releaseNotes.map((note, i) => (
                <li key={i}>{note}</li>
              ))}
            </ul>
          </div>
        ) : (
          <p style={{ margin: 0, fontSize: '0.85rem', color: '#475569', lineHeight: 1.5 }}>
            You are currently running the latest certified build of the Orion application. No pending updates found.
          </p>
        )}

        <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '8px', marginTop: '0.5rem', borderTop: '1px solid #f1f5f9', paddingTop: '0.85rem' }}>
          <Button variant="secondary" onClick={onClose}>
            Close
          </Button>
          {hasUpdate && (
            <Button
              variant="primary"
              onClick={onUpdateDownload}
              isLoading={updating}
              iconLeft={<RefreshCw size={14} />}
            >
              Update Now
            </Button>
          )}
        </div>
      </div>
    </div>
  );

  return typeof document !== 'undefined' ? createPortal(modalContent, document.body) : modalContent;
};

export default UpdateDialog;
