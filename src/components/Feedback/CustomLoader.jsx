import React from 'react';

export const CustomLoader = ({
  size = 20,
  text,
  fullPage = false,
  color = '#02658b',
  className = '',
  style
}) => {
  const spinner = (
    <div
      style={{
        display: 'inline-flex',
        alignItems: 'center',
        gap: '10px',
        ...style
      }}
      className={className}
    >
      <div
        style={{
          width: size,
          height: size,
          border: '2.5px solid #e2e8f0',
          borderTopColor: color,
          borderRadius: '50%',
          animation: 'spin 0.75s linear infinite',
          flexShrink: 0
        }}
      />
      {text && (
        <span style={{ fontSize: '0.85rem', color: '#475569', fontWeight: 600 }}>
          {text}
        </span>
      )}
    </div>
  );

  if (fullPage) {
    return (
      <div
        style={{
          position: 'fixed',
          inset: 0,
          background: 'rgba(255, 255, 255, 0.85)',
          backdropFilter: 'blur(3px)',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          zIndex: 9999
        }}
      >
        {spinner}
      </div>
    );
  }

  return spinner;
};

export default CustomLoader;
