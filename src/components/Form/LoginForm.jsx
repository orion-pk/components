import React, { useState } from 'react';
import { User, Lock, Eye, EyeOff, LogIn, AlertCircle } from 'lucide-react';
import { Button } from './Button.jsx';

export const LoginForm = ({
  onSubmit,
  loading = false,
  error = null,
  title = 'Sign In to Your Account',
  subtitle = 'Enter your credentials to continue',
  className = '',
  style
}) => {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);

  const handleSubmit = (e) => {
    e.preventDefault();
    if (onSubmit) {
      onSubmit({ username, password });
    }
  };

  return (
    <div
      className={`orion-login-form-card ${className}`}
      style={{
        background: '#FFFFFF',
        border: '1.5px solid #cbd5e1',
        borderRadius: '12px',
        padding: '2rem',
        maxWidth: '400px',
        width: '100%',
        boxShadow: '0 4px 6px -1px rgba(0, 0, 0, 0.05)',
        boxSizing: 'border-box',
        ...style
      }}
    >
      <div style={{ textAlign: 'center', marginBottom: '1.5rem' }}>
        <h2 style={{ fontSize: '1.4rem', fontWeight: 800, color: '#0f172a', margin: '0 0 0.4rem 0' }}>
          {title}
        </h2>
        <p style={{ fontSize: '0.85rem', color: '#64748b', margin: 0 }}>
          {subtitle}
        </p>
      </div>

      {error && (
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            gap: '8px',
            background: '#fef2f2',
            border: '1px solid #fecaca',
            color: '#dc2626',
            padding: '0.65rem 0.85rem',
            borderRadius: '6px',
            fontSize: '0.82rem',
            marginBottom: '1rem'
          }}
        >
          <AlertCircle size={16} />
          <span>{error}</span>
        </div>
      )}

      <form onSubmit={handleSubmit} style={{ display: 'flex', flexDirection: 'column', gap: '1rem' }}>
        <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
          <label style={{ fontSize: '0.8rem', fontWeight: 700, color: '#334155' }}>
            Username or Email
          </label>
          <div style={{ position: 'relative', display: 'flex', alignItems: 'center' }}>
            <User size={15} color="#94a3b8" style={{ position: 'absolute', left: '12px' }} />
            <input
              type="text"
              placeholder="Enter your username"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              required
              style={{
                width: '100%',
                height: '40px',
                borderRadius: '8px',
                border: '1.5px solid #cbd5e1',
                padding: '0 12px 0 36px',
                fontSize: '0.88rem',
                color: '#0f172a',
                outline: 'none',
                boxSizing: 'border-box'
              }}
            />
          </div>
        </div>

        <div style={{ display: 'flex', flexDirection: 'column', gap: '4px' }}>
          <label style={{ fontSize: '0.8rem', fontWeight: 700, color: '#334155' }}>
            Password
          </label>
          <div style={{ position: 'relative', display: 'flex', alignItems: 'center' }}>
            <Lock size={15} color="#94a3b8" style={{ position: 'absolute', left: '12px' }} />
            <input
              type={showPassword ? 'text' : 'password'}
              placeholder="Enter your password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              style={{
                width: '100%',
                height: '40px',
                borderRadius: '8px',
                border: '1.5px solid #cbd5e1',
                padding: '0 36px 0 36px',
                fontSize: '0.88rem',
                color: '#0f172a',
                outline: 'none',
                boxSizing: 'border-box'
              }}
            />
            <button
              type="button"
              onClick={() => setShowPassword(!showPassword)}
              style={{
                position: 'absolute',
                right: '10px',
                background: 'none',
                border: 'none',
                color: '#94a3b8',
                cursor: 'pointer',
                display: 'flex'
              }}
            >
              {showPassword ? <EyeOff size={16} /> : <Eye size={16} />}
            </button>
          </div>
        </div>

        <Button
          type="submit"
          variant="primary"
          size="lg"
          isLoading={loading}
          iconRight={<LogIn size={16} />}
          style={{ width: '100%', marginTop: '0.5rem' }}
        >
          Sign In
        </Button>
      </form>
    </div>
  );
};

export default LoginForm;
