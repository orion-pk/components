import React from 'react';

/**
 * SeverityPill for risk/audit classification
 */
export const SeverityPill = ({ severity = 'minor', label, className = '', style }) => {
  const map = {
    minor: { label: label || 'Minor Severity', class: 'success' },
    low: { label: label || 'Low Risk', class: 'success' },
    moderate: { label: label || 'Moderate Severity', class: 'warning' },
    medium: { label: label || 'Medium Risk', class: 'warning' },
    major: { label: label || 'Major Severity', class: 'danger' },
    high: { label: label || 'High Risk', class: 'danger' },
    critical: { label: label || 'Critical Severity', class: 'danger' }
  };

  const key = typeof severity === 'string' ? severity.toLowerCase().trim() : 'minor';
  const config = map[key] || map.minor;

  return (
    <span className={`orion-status-pill ${config.class} ${className}`} style={style}>
      <span className="orion-status-pill-dot" />
      {config.label}
    </span>
  );
};

export default SeverityPill;
