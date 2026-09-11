import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/premium_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../application/auth_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    await ref.read(authControllerProvider.notifier).signIn(
      _emailController.text,
      _passwordController.text,
    );
    
    // Check if there was an error in state
    final authState = ref.read(authControllerProvider);
    if (authState.hasError && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authState.error.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: PremiumBackground(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: GlassCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                          // App Logo
                          Center(
                            child: Image.asset(
                              'assets/images/logo.png',
                              height: 120,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 120,
                                  alignment: Alignment.center,
                                  child: const Text('Save logo to assets/images/logo.png', textAlign: TextAlign.center),
                                );
                              },
                            ),
                          ).animate().fade(duration: 600.ms).slideY(begin: -0.2, end: 0, curve: Curves.easeOutCubic),
                          const SizedBox(height: 24),
                          Text(
                            'Welcome Back',
                            style: AppTypography.headlineLg.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ).animate().fade(delay: 200.ms, duration: 600.ms).slideY(begin: 0.2, end: 0),
                          const SizedBox(height: 8),
                          Text(
                            'Login to your Hivemind account',
                            style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                            textAlign: TextAlign.center,
                          ).animate().fade(delay: 300.ms, duration: 600.ms),
                          const SizedBox(height: 40),
                          
                          // Email Field
                          _buildTextField(
                            controller: _emailController,
                            label: 'University Email',
                            icon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ).animate().fade(delay: 400.ms, duration: 600.ms).slideX(begin: -0.1, end: 0),
                          const SizedBox(height: 16),
                          
                          // Password Field
                          _buildTextField(
                            controller: _passwordController,
                            label: 'Password',
                            icon: Icons.lock_outline,
                            obscureText: true,
                          ).animate().fade(delay: 500.ms, duration: 600.ms).slideX(begin: 0.1, end: 0),
                          
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ).animate().fade(delay: 600.ms, duration: 600.ms),
                          
                          const SizedBox(height: 24),
                          
                          PrimaryButton(
                            label: 'Log In',
                            isLoading: isLoading,
                            onPressed: _handleLogin,
                          ).animate().fade(delay: 700.ms, duration: 600.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
                          
                          const SizedBox(height: 24),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account?',
                                style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                              ),
                              TextButton(
                                onPressed: () => context.go('/register'),
                                child: Text(
                                  'Sign Up',
                                  style: AppTypography.bodySm.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ).animate().fade(delay: 800.ms, duration: 600.ms),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.primary.withOpacity(0.6)),
        filled: true,
        fillColor: AppColors.surfaceContainerLow,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.outlineVariant.withOpacity(0.5), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }
}
