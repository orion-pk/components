import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import 'orion_button.dart';

/// Orion Login Form card mirroring `LoginForm.jsx`
class OrionLoginForm extends StatefulWidget {
  final Future<void> Function(String username, String password) onSubmit;
  final bool loading;
  final String? error;
  final String title;
  final String subtitle;

  const OrionLoginForm({
    super.key,
    required this.onSubmit,
    this.loading = false,
    this.error,
    this.title = 'Sign In to Your Account',
    this.subtitle = 'Enter your credentials to continue',
  });

  @override
  State<OrionLoginForm> createState() => _OrionLoginFormState();
}

class _OrionLoginFormState extends State<OrionLoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

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
          const SizedBox(height: 24),

          // Submit Button
          OrionButton(
            label: 'Sign In',
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
