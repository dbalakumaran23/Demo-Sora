import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/glass_widgets.dart';
import '../services/auth_service.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLoginSuccess;

  const LoginScreen({super.key, required this.onLoginSuccess});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _isLogin = true;
  bool _isLoading = false;
  String? _error;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _departmentController = TextEditingController();
  final _rollNumberController = TextEditingController();

  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _departmentController.dispose();
    _rollNumberController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _error = 'Please fill in all required fields.');
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      if (_isLogin) {
        await AuthService().login(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
      } else {
        await AuthService().register(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          fullName: _nameController.text.trim(),
          department: _departmentController.text.trim().isEmpty
              ? null
              : _departmentController.text.trim(),
          rollNumber: _rollNumberController.text.trim().isEmpty
              ? null
              : _rollNumberController.text.trim(),
        );
      }
      widget.onLoginSuccess();
    } on ApiException catch (e) {
      setState(() => _error = e.message);
    } catch (e) {
      setState(() => _error = 'Connection error. Is the server running?');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tc = Tc.of(context);

    return Scaffold(
      backgroundColor: tc.bg,
      body: Container(
        decoration: BoxDecoration(gradient: tc.bgGradient),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnim,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo area
                  Center(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(Icons.school_rounded,
                          color: Colors.white, size: 40),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: Text(
                      'PUnova',
                      style: TextStyle(
                        color: tc.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      _isLogin
                          ? 'Welcome back! Sign in to continue.'
                          : 'Create your campus account.',
                      style: TextStyle(color: tc.textMuted, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Toggle tabs
                  GlassCard(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      children: [
                        _tabButton('Sign In', _isLogin, tc,
                            () => setState(() => _isLogin = true)),
                        _tabButton('Register', !_isLogin, tc,
                            () => setState(() => _isLogin = false)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Error message
                  if (_error != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.accentRed.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: AppColors.accentRed.withValues(alpha: 0.3)),
                      ),
                      child: Text(_error!,
                          style: const TextStyle(
                              color: AppColors.accentRed, fontSize: 13)),
                    ),
                    const SizedBox(height: 14),
                  ],

                  // Form fields
                  if (!_isLogin) ...[
                    _field(
                        tc, 'Full Name', _nameController, Icons.person_rounded),
                    const SizedBox(height: 14),
                  ],
                  _field(tc, 'Email', _emailController, Icons.email_rounded,
                      keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 14),
                  _field(
                      tc, 'Password', _passwordController, Icons.lock_rounded,
                      isPassword: true),
                  if (!_isLogin) ...[
                    const SizedBox(height: 14),
                    _field(tc, 'Department', _departmentController,
                        Icons.business_rounded),
                    const SizedBox(height: 14),
                    _field(tc, 'Roll Number', _rollNumberController,
                        Icons.badge_rounded),
                  ],
                  const SizedBox(height: 28),

                  // Submit button
                  SizedBox(
                    width: double.infinity,
                    child: GlassButton(
                      text: _isLoading
                          ? 'Please wait...'
                          : (_isLogin ? 'Sign In' : 'Create Account'),
                      onPressed: _isLoading ? null : _submit,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Skip for now
                  Center(
                    child: TextButton(
                      onPressed: widget.onLoginSuccess,
                      child: Text(
                        'Skip for now →',
                        style: TextStyle(
                          color: tc.textMuted,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String label, bool isActive, Tc tc, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isActive ? AppColors.primaryGradient : null,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : tc.textMuted,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(
    Tc tc,
    String label,
    TextEditingController controller,
    IconData icon, {
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: tc.glassWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tc.glassBorder),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        style: TextStyle(color: tc.textPrimary, fontSize: 15),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: tc.textMuted, size: 20),
          hintText: label,
          hintStyle: TextStyle(color: tc.textMuted, fontSize: 14),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
