import React from 'react';
import { CustomLoader } from '../Feedback/CustomLoader.jsx';

export const Button = React.forwardRef(({
  children,
  variant = 'primary', // 'primary' | 'secondary' | 'danger' | 'outline' | 'ghost'
  size = 'md',        // 'sm' | 'md' | 'lg'
  isLoading = false,
  disabled = false,
  iconLeft,
  iconRight,
  className = '',
  style,
  ...props
}, ref) => {
  const variantClass = `orion-btn-${variant}`;
  const sizeClass = `orion-btn-${size}`;

  return (
    <button
      ref={ref}
      disabled={disabled || isLoading}
      className={`orion-btn ${variantClass} ${sizeClass} ${className}`}
      style={style}
      {...props}
    >
      {isLoading ? (
        <CustomLoader size={size === 'lg' ? 18 : size === 'sm' ? 12 : 14} color={variant === 'primary' || variant === 'danger' ? '#ffffff' : '#02658b'} />
      ) : iconLeft ? (
        <span className="orion-btn-icon-left" style={{ display: 'inline-flex' }}>{iconLeft}</span>
      ) : null}
      <span>{children}</span>
      {!isLoading && iconRight && (
        <span className="orion-btn-icon-right" style={{ display: 'inline-flex' }}>{iconRight}</span>
      )}
    </button>
  );
});

Button.displayName = 'Button';
export default Button;
