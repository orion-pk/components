import React, { useState } from 'react';
import { RefreshCw, ArrowUpCircle } from 'lucide-react';
import { UpdateDialog } from './UpdateDialog.jsx';

export const VersionBadge = ({
  currentVersion = 'v2.4.0',
  hasUpdate = false,
  latestVersion = 'v2.4.1',
  releaseNotes,
  onUpdateDownload,
  className = '',
  style
}) => {
  const [dialogOpen, setDialogOpen] = useState(false);

  return (
    <>
      <button
        type="button"
        onClick={() => setDialogOpen(true)}
        className={`orion-version-badge ${className}`}
        style={{
          display: 'inline-flex',
          alignItems: 'center',
          gap: '5px',
          fontSize: '0.74rem',
          fontWeight: 700,
          padding: '3px 9px',
          borderRadius: '9999px',
          background: hasUpdate ? '#fef3c7' : '#e5f3f7',
          color: hasUpdate ? '#b45309' : '#02658b',
          border: hasUpdate ? '1.5px solid #fde68a' : '1.5px solid #bfdbfe',
          cursor: 'pointer',
          outline: 'none',
          ...style
        }}
        title="Click to view update details"
      >
        {hasUpdate ? <ArrowUpCircle size={13} /> : <RefreshCw size={12} />}
        <span>{currentVersion}</span>
        {hasUpdate && (
          <span style={{ background: '#b45309', color: '#fff', borderRadius: '50%', width: '6px', height: '6px' }} />
        )}
      </button>

      <UpdateDialog
        isOpen={dialogOpen}
        currentVersion={currentVersion}
        latestVersion={latestVersion}
        hasUpdate={hasUpdate}
        releaseNotes={releaseNotes}
        onClose={() => setDialogOpen(false)}
        onUpdateDownload={onUpdateDownload}
      />
    </>
  );
};

export default VersionBadge;
