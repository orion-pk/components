import React from 'react';

/**
 * StatusPill component supporting standard Orion status types
 */
export const StatusPill = ({ status = 'completed', label, className = '', style }) => {
  const statusMap = {
    completed: { text: label || 'Completed', class: 'success' },
    registered: { text: label || 'Registered', class: 'success' },
    active: { text: label || 'Active', class: 'success' },
    paid: { text: label || 'Paid', class: 'success' },
    present: { text: label || 'Present', class: 'success' },
    
    pending: { text: label || 'Pending', class: 'warning' },
    in_consultation: { text: label || 'In Consultation', class: 'warning' },
    under_review: { text: label || 'Under Review', class: 'warning' },
    partially_paid: { text: label || 'Partially Paid', class: 'warning' },
    
    unregistered: { text: label || 'Unregistered', class: 'danger' },
    critical: { text: label || 'Critical', class: 'danger' },
    absent: { text: label || 'Absent', class: 'danger' },
    failed: { text: label || 'Failed', class: 'danger' },
    suspended: { text: label || 'Suspended', class: 'danger' },
    unpaid: { text: label || 'Unpaid', class: 'danger' },
    
    inactive: { text: label || 'Inactive', class: 'info' },
    draft: { text: label || 'Draft', class: 'info' }
  };

  const key = typeof status === 'string' ? status.toLowerCase().replace(/\s+/g, '_') : 'info';
  const config = statusMap[key] || { text: label || status, class: 'info' };

  return (
    <span className={`orion-status-pill ${config.class} ${className}`} style={style}>
      <span className="orion-status-pill-dot" />
      {config.text}
    </span>
  );
};

export default StatusPill;
