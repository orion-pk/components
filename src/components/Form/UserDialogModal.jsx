import React, { useState, useEffect } from 'react';
import { createPortal } from 'react-dom';
import { X, User, GraduationCap, Users, Lock, Eye, EyeOff, Save, AlertCircle } from 'lucide-react';
import { Button } from './Button.jsx';

export const UserDialogModal = ({
  isOpen,
  mode = 'add', // 'add' | 'edit'
  initialData = null,
  roles = ['Teacher', 'Student', 'Parent'],
  onClose,
  onSubmit,
  loading = false,
  error = null,
  className = '',
  style
}) => {
  const [selectedRole, setSelectedRole] = useState('Teacher');
  const [fullName, setFullName] = useState('');
  const [cnic, setCnic] = useState('');
  const [contact, setContact] = useState('');
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);

  useEffect(() => {
    if (initialData) {
      setFullName(initialData.name || initialData.fullName || '');
      setCnic(initialData.cnic || '');
      setContact(initialData.contact || initialData.phoneNumber || '');
      setEmail(initialData.email || '');
      setSelectedRole(initialData.role || 'Teacher');
    } else {
      setFullName('');
      setCnic('');
      setContact('');
      setEmail('');
      setPassword('');
      setSelectedRole('Teacher');
    }
  }, [initialData, isOpen]);

  if (!isOpen) return null;

  // Format CNIC: xxxxx-xxxxxxx-x (15 chars with dashes)
  const handleCnicChange = (e) => {
    const raw = e.target.value.replace(/[^\d]/g, '');
    let formatted = raw;
    if (raw.length > 5 && raw.length <= 12) {
      formatted = `${raw.slice(0, 5)}-${raw.slice(5)}`;
    } else if (raw.length > 12) {
      formatted = `${raw.slice(0, 5)}-${raw.slice(5, 12)}-${raw.slice(12, 13)}`;
    }
    setCnic(formatted);
  };

  // Format Contact: 123 045 223 48
  const handleContactChange = (e) => {
    const raw = e.target.value.replace(/[^\d]/g, '');
    let formatted = raw;
    if (raw.length > 3 && raw.length <= 6) {
      formatted = `${raw.slice(0, 3)} ${raw.slice(3)}`;
    } else if (raw.length > 6 && raw.length <= 9) {
      formatted = `${raw.slice(0, 3)} ${raw.slice(3, 6)} ${raw.slice(6)}`;
    } else if (raw.length > 9) {
      formatted = `${raw.slice(0, 3)} ${raw.slice(3, 6)} ${raw.slice(6, 9)} ${raw.slice(9, 11)}`;
    }
    setContact(formatted);
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    if (onSubmit) {
      onSubmit({
        role: selectedRole,
        fullName,
        cnic,
        contact,
        email,
        password: password || undefined
      });
    }
  };

  const getRoleIcon = (roleName) => {
    if (roleName === 'Teacher') return <GraduationCap size={15} />;
    if (roleName === 'Parent') return <Users size={15} />;
    return <User size={15} />;
  };

  const modalContent = (
    <div
      className={`orion-modal-overlay user-dialog-portal ${className}`}
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
          maxWidth: '560px',
          padding: '1.5rem',
          display: 'flex',
          flexDirection: 'column',
          gap: '1rem',
          boxShadow: '0 20px 25px -5px rgba(0,0,0,0.15)',
          maxHeight: '90vh',
          overflowY: 'auto'
        }}
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderBottom: '1px solid #f1f5f9', paddingBottom: '0.75rem' }}>
          <div>
            <h3 style={{ margin: 0, fontSize: '1.15rem', fontWeight: 800, color: '#0f172a' }}>
              {mode === 'add' ? 'Add New User' : 'Edit User Details'}
            </h3>
            <p style={{ margin: '2px 0 0 0', fontSize: '0.8rem', color: '#64748b' }}>
              {mode === 'add' ? 'Create an account and assign workspace role.' : 'Update user profile and contact information.'}
            </p>
          </div>
          <button
            type="button"
            onClick={onClose}
            style={{ background: 'none', border: 'none', color: '#94a3b8', cursor: 'pointer' }}
          >
            <X size={18} />
          </button>
        </div>

        {/* Role Selection Chips */}
        <div style={{ display: 'flex', flexDirection: 'column', gap: '6px', alignItems: 'center' }}>
          <span style={{ fontSize: '0.85rem', fontWeight: 700, color: '#0f172a' }}>Select Role</span>
          <div
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: '6px',
              background: '#FFFFFF',
              padding: '4px',
              borderRadius: '50px',
              border: '1.5px solid #cbd5e1',
            }}
          >
            {roles.map((r) => {
              const isSel = selectedRole === r;
              return (
                <button
                  key={r}
                  type="button"
                  onClick={() => setSelectedRole(r)}
                  style={{
                    display: 'flex',
                    alignItems: 'center',
                    gap: '4px',
                    padding: '5px 14px',
                    borderRadius: '50px',
                    fontSize: '0.82rem',
                    fontWeight: 700,
                    cursor: 'pointer',
                    border: isSel ? '1.5px solid #02658b' : '1.5px solid transparent',
                    background: isSel ? '#FFFFFF' : 'transparent',
                    color: isSel ? '#02658b' : '#64748b',
                    boxShadow: isSel ? '0 1px 4px rgba(2,101,139,0.15)' : 'none',
                    transition: 'all 0.15s ease'
                  }}
                >
                  {getRoleIcon(r)}
                  <span>{r}</span>
                </button>
              );
            })}
          </div>
        </div>

        {error && (
          <div
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: '6px',
              background: '#fef2f2',
              border: '1px solid #fecaca',
              color: '#dc2626',
              padding: '8px 12px',
              borderRadius: '6px',
              fontSize: '0.82rem'
            }}
          >
            <AlertCircle size={15} />
            <span>{error}</span>
          </div>
        )}

        {/* Form Inputs */}
        <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
          <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '0.85rem' }}>
            {/* Full Name */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
              <label style={{ fontSize: '0.78rem', fontWeight: 700, color: '#334155' }}>
                Full Name <span style={{ color: '#ef4444' }}>*</span>
              </label>
              <input
                type="text"
                placeholder="Enter name here"
                value={fullName}
                onChange={(e) => setFullName(e.target.value)}
                required
                style={{
                  height: '38px',
                  borderRadius: '8px',
                  border: '1.5px solid #cbd5e1',
                  padding: '0 10px',
                  fontSize: '0.85rem',
                  outline: 'none'
                }}
              />
            </div>

            {/* CNIC */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
              <label style={{ fontSize: '0.78rem', fontWeight: 700, color: '#334155' }}>
                CNIC (13 Digits)
              </label>
              <input
                type="text"
                placeholder="1234-5678910-2"
                value={cnic}
                onChange={handleCnicChange}
                maxLength={15}
                style={{
                  height: '38px',
                  borderRadius: '8px',
                  border: '1.5px solid #cbd5e1',
                  padding: '0 10px',
                  fontSize: '0.85rem',
                  outline: 'none'
                }}
              />
            </div>

            {/* Contact */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
              <label style={{ fontSize: '0.78rem', fontWeight: 700, color: '#334155' }}>
                Contact Number
              </label>
              <input
                type="text"
                placeholder="123 045 223 48"
                value={contact}
                onChange={handleContactChange}
                maxLength={14}
                style={{
                  height: '38px',
                  borderRadius: '8px',
                  border: '1.5px solid #cbd5e1',
                  padding: '0 10px',
                  fontSize: '0.85rem',
                  outline: 'none'
                }}
              />
            </div>

            {/* Email */}
            <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
              <label style={{ fontSize: '0.78rem', fontWeight: 700, color: '#334155' }}>
                Email Address <span style={{ color: '#ef4444' }}>*</span>
              </label>
              <input
                type="email"
                placeholder="Enter email address"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                required
                style={{
                  height: '38px',
                  borderRadius: '8px',
                  border: '1.5px solid #cbd5e1',
                  padding: '0 10px',
                  fontSize: '0.85rem',
                  outline: 'none'
                }}
              />
            </div>
          </div>

          {/* Password (only if add mode or if updating) */}
          {mode === 'add' && (
            <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
              <label style={{ fontSize: '0.78rem', fontWeight: 700, color: '#334155' }}>
                Temporary Password <span style={{ color: '#ef4444' }}>*</span>
              </label>
              <div style={{ position: 'relative', display: 'flex', alignItems: 'center' }}>
                <Lock size={15} color="#94a3b8" style={{ position: 'absolute', left: '10px' }} />
                <input
                  type={showPassword ? 'text' : 'password'}
                  placeholder="Enter temporary password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  required
                  style={{
                    width: '100%',
                    height: '38px',
                    borderRadius: '8px',
                    border: '1.5px solid #cbd5e1',
                    padding: '0 36px 0 32px',
                    fontSize: '0.85rem',
                    outline: 'none',
                    boxSizing: 'border-box'
                  }}
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  style={{ position: 'absolute', right: '10px', background: 'none', border: 'none', color: '#94a3b8', cursor: 'pointer', display: 'flex' }}
                >
                  {showPassword ? <EyeOff size={15} /> : <Eye size={15} />}
                </button>
              </div>
            </div>
          )}

          {/* Action Buttons */}
          <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '8px', borderTop: '1px solid #f1f5f9', paddingTop: '1rem', marginTop: '0.5rem' }}>
            <Button variant="secondary" type="button" onClick={onClose} disabled={loading}>
              Cancel
            </Button>
            <Button variant="primary" type="submit" isLoading={loading} iconLeft={<Save size={15} />}>
              {mode === 'add' ? 'Save & Create' : 'Save Changes'}
            </Button>
          </div>
        </form>
      </div>
    </div>
  );

  return typeof document !== 'undefined' ? createPortal(modalContent, document.body) : modalContent;
};

export default UserDialogModal;
