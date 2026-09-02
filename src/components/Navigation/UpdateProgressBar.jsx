import React from 'react';

export const UpdateProgressBar = ({
  progress = 0,
  statusText = 'Downloading update package...',
  totalSizeText,
  className = '',
  style
}) => {
  const clamped = Math.min(100, Math.max(0, progress));

  return (
    <div className={`orion-update-progress ${className}`} style={{ width: '100%', display: 'flex', flexDirection: 'column', gap: '6px', ...style }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', fontSize: '0.8rem', fontWeight: 600, color: '#334155' }}>
        <span>{statusText}</span>
        <span>{clamped}% {totalSizeText && `(${totalSizeText})`}</span>
      </div>
      <div style={{ height: '8px', background: '#e2e8f0', borderRadius: '9999px', overflow: 'hidden' }}>
        <div
          style={{
            height: '100%',
            width: `${clamped}%`,
            background: '#02658b',
            borderRadius: '9999px',
            transition: 'width 0.25s ease'
          }}
        />
      </div>
    </div>
  );
};

export default UpdateProgressBar;
