import 'package:flutter/material.dart';
import '../theme/orion_theme.dart';
import 'orion_button.dart';

enum OrionUserDialogMode { add, edit }

class OrionUserData {
  final String role;
  final String fullName;
  final String cnic;
  final String contact;
  final String email;
  final String? password;

  const OrionUserData({
    required this.role,
    required this.fullName,
    required this.cnic,
    required this.contact,
    required this.email,
    this.password,
  });
}

/// Orion User Dialog Modal mirroring `UserDialogModal.jsx`
class OrionUserDialogModal extends StatefulWidget {
  final OrionUserDialogMode mode;
  final OrionUserData? initialData;
  final List<String> roles;
  final Future<void> Function(OrionUserData data) onSubmit;
  final VoidCallback onClose;
  final bool loading;
  final String? error;

  const OrionUserDialogModal({
    super.key,
    this.mode = OrionUserDialogMode.add,
    this.initialData,
    this.roles = const ['Teacher', 'Student', 'Parent'],
    required this.onSubmit,
    required this.onClose,
    this.loading = false,
    this.error,
  });

  static Future<void> show(
    BuildContext context, {
    OrionUserDialogMode mode = OrionUserDialogMode.add,
    OrionUserData? initialData,
    List<String> roles = const ['Teacher', 'Student', 'Parent'],
    required Future<void> Function(OrionUserData data) onSubmit,
  }) {
    return showDialog<void>(
      context: context,
      barrierColor: const Color.fromRGBO(15, 23, 42, 0.5),
      builder: (ctx) => OrionUserDialogModal(
        mode: mode,
        initialData: initialData,
        roles: roles,
        onSubmit: onSubmit,
        onClose: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  @override
  State<OrionUserDialogModal> createState() => _OrionUserDialogModalState();
}

class _OrionUserDialogModalState extends State<OrionUserDialogModal> {
  late String _selectedRole;
  final _nameController = TextEditingController();
  final _cnicController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialData?.role ?? widget.roles.first;
    if (widget.initialData != null) {
      _nameController.text = widget.initialData!.fullName;
      _cnicController.text = widget.initialData!.cnic;
      _contactController.text = widget.initialData!.contact;
      _emailController.text = widget.initialData!.email;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cnicController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _formatCnic(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^\d]'), '');
    String formatted = digits;
    if (digits.length > 5 && digits.length <= 12) {
      formatted = '${digits.substring(0, 5)}-${digits.substring(5)}';
    } else if (digits.length > 12) {
      formatted = '${digits.substring(0, 5)}-${digits.substring(5, 12)}-${digits.substring(12, 13)}';
    }
    _cnicController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  void _formatContact(String raw) {
    final digits = raw.replaceAll(RegExp(r'[^\d]'), '');
    String formatted = digits;
    if (digits.length > 3 && digits.length <= 6) {
      formatted = '${digits.substring(0, 3)} ${digits.substring(3)}';
    } else if (digits.length > 6 && digits.length <= 9) {
      formatted = '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6)}';
    } else if (digits.length > 9) {
      formatted = '${digits.substring(0, 3)} ${digits.substring(3, 6)} ${digits.substring(6, 9)} ${digits.substring(9, digits.length > 11 ? 11 : digits.length)}';
    }
    _contactController.value = TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }

  IconData _getRoleIcon(String role) {
    switch (role.toLowerCase()) {
      case 'teacher':
        return Icons.school_outlined;
      case 'parent':
        return Icons.group_outlined;
      default:
        return Icons.person_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdd = widget.mode == OrionUserDialogMode.add;

    return Dialog(
      backgroundColor: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: OrionRadius.lg,
        side: const BorderSide(color: OrionColors.borderColor, width: 1.5),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAdd ? 'Add New User' : 'Edit User Details',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: OrionColors.textMain,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        isAdd
                            ? 'Create an account and assign workspace role.'
                            : 'Update user profile and contact information.',
                        style: const TextStyle(fontSize: 12.5, color: OrionColors.textMuted),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18, color: OrionColors.textSubtle),
                    onPressed: widget.onClose,
                  ),
                ],
              ),
              const Divider(height: 24, color: Color(0xFFF1F5F9)),

              // Role Selection Chips
              Center(
                child: Column(
                  children: [
                    const Text(
                      'Select Role',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: OrionColors.textMain,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: OrionColors.borderColor, width: 1.5),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.roles.map((r) {
                          final isSel = _selectedRole == r;
                          return InkWell(
                            onTap: () => setState(() => _selectedRole = r),
                            borderRadius: BorderRadius.circular(50),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                              decoration: BoxDecoration(
                                color: isSel ? Colors.white : Colors.transparent,
                                borderRadius: BorderRadius.circular(50),
                                border: isSel
                                    ? Border.all(color: OrionColors.primary, width: 1.5)
                                    : Border.all(color: Colors.transparent, width: 1.5),
                                boxShadow: isSel
                                    ? const [
                                        BoxShadow(
                                          color: Color.fromRGBO(2, 101, 139, 0.15),
                                          offset: Offset(0, 1),
                                          blurRadius: 4,
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    _getRoleIcon(r),
                                    size: 15,
                                    color: isSel ? OrionColors.primary : OrionColors.textMuted,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    r,
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w700,
                                      color: isSel ? OrionColors.primary : OrionColors.textMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              if (widget.error != null) ...[
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFFFECACA)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, size: 15, color: Color(0xFFDC2626)),
                      const SizedBox(width: 6),
                      Text(widget.error!, style: const TextStyle(color: Color(0xFFDC2626), fontSize: 13)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Grid of Inputs
              Wrap(
                spacing: 14,
                runSpacing: 14,
                children: [
                  _buildField('Full Name', _nameController, 'Enter name here', required: true),
                  _buildField('CNIC (13 Digits)', _cnicController, '1234-5678910-2', onChanged: _formatCnic),
                  _buildField('Contact Number', _contactController, '123 045 223 48', onChanged: _formatContact),
                  _buildField('Email Address', _emailController, 'Enter email address', required: true),
                ],
              ),
              if (isAdd) ...[
                const SizedBox(height: 14),
                _buildPasswordField(),
              ],

              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OrionButton(
                    label: 'Cancel',
                    variant: OrionButtonVariant.secondary,
                    onPressed: widget.loading ? null : widget.onClose,
                  ),
                  const SizedBox(width: 8),
                  OrionButton(
                    label: isAdd ? 'Save & Create' : 'Save Changes',
                    variant: OrionButtonVariant.primary,
                    isLoading: widget.loading,
                    iconLeft: const Icon(Icons.save_outlined, size: 15),
                    onPressed: () {
                      widget.onSubmit(
                        OrionUserData(
                          role: _selectedRole,
                          fullName: _nameController.text.trim(),
                          cnic: _cnicController.text.trim(),
                          contact: _contactController.text.trim(),
                          email: _emailController.text.trim(),
                          password: isAdd ? _passwordController.text : null,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller, String hint, {bool required = false, ValueChanged<String>? onChanged}) {
    return SizedBox(
      width: 245,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: label,
              style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: OrionColors.textSecondary),
              children: [
                if (required) const TextSpan(text: ' *', style: TextStyle(color: OrionColors.statusRed)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: OrionRadius.md,
              border: Border.all(color: OrionColors.borderColor, width: 1.5),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(fontSize: 13.5, color: OrionColors.textMain),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(fontSize: 13.5, color: OrionColors.textSubtle),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Temporary Password',
            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, color: OrionColors.textSecondary),
            children: [
              TextSpan(text: ' *', style: TextStyle(color: OrionColors.statusRed)),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Container(
          height: 38,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: OrionRadius.md,
            border: Border.all(color: OrionColors.borderColor, width: 1.5),
          ),
          alignment: Alignment.center,
          child: TextField(
            controller: _passwordController,
            obscureText: !_showPassword,
            style: const TextStyle(fontSize: 13.5, color: OrionColors.textMain),
            decoration: InputDecoration(
              hintText: 'Enter temporary password',
              hintStyle: const TextStyle(fontSize: 13.5, color: OrionColors.textSubtle),
              prefixIcon: const Icon(Icons.lock_outline, size: 15, color: OrionColors.textSubtle),
              suffixIcon: IconButton(
                icon: Icon(
                  _showPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  size: 15,
                  color: OrionColors.textSubtle,
                ),
                onPressed: () => setState(() => _showPassword = !_showPassword),
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ],
    );
  }
}
