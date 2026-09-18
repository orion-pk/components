import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import 'orion_button.dart';

/// Orion Login Form card mirroring `LoginForm.jsx` with full customization support.
class OrionLoginForm extends StatefulWidget {
  final dynamic Function(String username, String password) onSubmit;
  final bool loading;
  final String? error;
  final String title;
  final String subtitle;
  final String? initialUsername;
  final String? initialPassword;
  final String submitButtonText;
  final Widget? logo;
  final VoidCallback? onForgotPassword;
  final bool showRememberMe;
  final bool rememberMe;
  final ValueChanged<bool>? onRememberMeChanged;
  final List<Widget>? extraWidgets;

  const OrionLoginForm({
    super.key,
    required this.onSubmit,
    this.loading = false,
    this.error,
    this.title = 'Sign In to Your Account',
    this.subtitle = 'Enter your credentials to continue',
    this.initialUsername,
    this.initialPassword,
    this.submitButtonText = 'Sign In',
    this.logo,
    this.onForgotPassword,
    this.showRememberMe = false,
    this.rememberMe = false,
    this.onRememberMeChanged,
    this.extraWidgets,
  });

  @override
  State<OrionLoginForm> createState() => _OrionLoginFormState();
}

class _OrionLoginFormState extends State<OrionLoginForm> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  bool _showPassword = false;
  late bool _rememberMe;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.initialUsername ?? '');
    _passwordController = TextEditingController(text: widget.initialPassword ?? '');
    _rememberMe = widget.rememberMe;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleFormSubmit() {
    final u = _usernameController.text.trim();
    final p = _passwordController.text;
    if (u.isNotEmpty && p.isNotEmpty) {
      widget.onSubmit(u, p);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: OrionColors.bgSurface,
        border: Border.all(color: OrionColors.borderColor, width: 1.5),
        borderRadius: OrionRadius.lg,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -1,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.logo != null) ...[
            Center(child: widget.logo!),
            const SizedBox(height: 16),
          ],
          // Header
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: OrionColors.textMain,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.5,
              color: OrionColors.textMuted,
            ),
          ),
          const SizedBox(height: 24),

          // Error Banner
          if (widget.error != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                border: Border.all(color: const Color(0xFFFECACA)),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, size: 16, color: Color(0xFFDC2626)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.error!,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFFDC2626),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Username Field
          const Text(
            'Username or Email',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: OrionColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: OrionRadius.md,
              border: Border.all(color: OrionColors.borderColor, width: 1.5),
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: _usernameController,
              onSubmitted: (_) => _handleFormSubmit(),
              style: const TextStyle(fontSize: 14, color: OrionColors.textMain),
              decoration: const InputDecoration(
                hintText: 'Enter your username',
                hintStyle: TextStyle(fontSize: 14, color: OrionColors.textSubtle),
                prefixIcon: Icon(Icons.person_outline, size: 16, color: OrionColors.textSubtle),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Password Field
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: OrionColors.textSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: OrionRadius.md,
              border: Border.all(color: OrionColors.borderColor, width: 1.5),
            ),
            alignment: Alignment.center,
            child: TextField(
              controller: _passwordController,
              obscureText: !_showPassword,
              onSubmitted: (_) => _handleFormSubmit(),
              style: const TextStyle(fontSize: 14, color: OrionColors.textMain),
              decoration: InputDecoration(
                hintText: 'Enter your password',
                hintStyle: const TextStyle(fontSize: 14, color: OrionColors.textSubtle),
                prefixIcon: const Icon(Icons.lock_outline, size: 16, color: OrionColors.textSubtle),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    size: 16,
                    color: OrionColors.textSubtle,
                  ),
                  onPressed: () => setState(() => _showPassword = !_showPassword),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),

          if (widget.showRememberMe || widget.onForgotPassword != null) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (widget.showRememberMe)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (val) {
                          setState(() => _rememberMe = val ?? false);
                          if (widget.onRememberMeChanged != null) {
                            widget.onRememberMeChanged!(val ?? false);
                          }
                        },
                      ),
                      const Text('Remember me', style: TextStyle(fontSize: 12.5, color: OrionColors.textSecondary)),
                    ],
                  )
                else
                  const SizedBox.shrink(),
                if (widget.onForgotPassword != null)
                  TextButton(
                    onPressed: widget.onForgotPassword,
                    style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: Size.zero),
                    child: const Text('Forgot password?', style: TextStyle(fontSize: 12.5, color: OrionColors.primary)),
                  ),
              ],
            ),
          ],

          if (widget.extraWidgets != null) ...widget.extraWidgets!,

          const SizedBox(height: 20),

          // Submit Button
          OrionButton(
            text: widget.submitButtonText,
            variant: OrionButtonVariant.primary,
            size: OrionButtonSize.lg,
            isLoading: widget.loading,
            iconRight: const Icon(Icons.login, size: 16),
            onPressed: _handleFormSubmit,
          ),
        ],
      ),
    );
  }
}
