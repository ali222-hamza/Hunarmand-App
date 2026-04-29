import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    final vm = context.read<AuthViewModel>();

    bool ok = await vm.loginUser(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (ok) {
      final String role = vm.userRole;
      if (role == 'admin') {
        Navigator.pushReplacementNamed(context, '/admin');
      } else if (role == 'worker') {
        Navigator.pushReplacementNamed(context, '/worker_home');
      } else {
        Navigator.pushReplacementNamed(context, '/customer_home');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(vm.errorMessage),
          backgroundColor: const Color(0xFFEF4444),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();
    // Screen dimensions le rahe hain responsiveness ke liye
    final size = MediaQuery.of(context).size;
    final bool isSmallPhone = size.width < 360;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: Color(0xFF374151), size: 26),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Login',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
        centerTitle: true,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              // Physics ensure karti hai ke scroll smoothly chale
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.06, // 6% side padding
                vertical: 16,
              ),
              child: ConstrainedBox(
                // Isse content screen se bahar nahi jata
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.02),
                        Text('Welcome Back',
                            style: TextStyle(
                                fontSize: isSmallPhone ? 22 : 26,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF1A1A2E))),
                        const SizedBox(height: 6),
                        const Text(
                          'Enter your credentials to access your Pakistan social impact dashboard.',
                          style: TextStyle(
                              fontSize: 13, color: Color(0xFF6B7280), height: 1.4),
                        ),
                        SizedBox(height: size.height * 0.04),

                        // Email field
                        const Text('Email or Username',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A2E))),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hint: 'Enter your email',
                          prefixIcon: Icons.person_outline,
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Email is required';
                            if (!v.contains('@')) return 'Enter a valid email';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Password field
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Password',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF1A1A2E))),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/forgot_password'),
                              child: const Text('Forgot Password?',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF1E3A8A))),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        CustomTextField(
                          hint: 'Enter password',
                          prefixIcon: Icons.lock_outline,
                          controller: _passwordController,
                          isPassword: true,
                          validator: (v) {
                            if (v == null || v.isEmpty) return 'Password is required';
                            if (v.length < 6) return 'At least 6 characters';
                            return null;
                          },
                        ),
                        SizedBox(height: size.height * 0.05),

                        // Login button
                        CustomButton(
                          text: 'Login Now',
                          onTap: _login,
                          isLoading: vm.isLoading,
                        ),

                        const SizedBox(height: 20),

                        // Sign up link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? ",
                                style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, '/role'),
                              child: const Text('Sign Up',
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1E3A8A))),
                            ),
                          ],
                        ),

                        // Ye Spacer content ko uper push karta hai aur footer ko niche
                        const Spacer(),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 20),
                          child: Row(
                            children: [
                              Expanded(child: Divider(color: Colors.grey.shade300)),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('IDENTITY VERIFIED',
                                    style: TextStyle(
                                        fontSize: 9,
                                        letterSpacing: 1.5,
                                        color: Color(0xFF9CA3AF))),
                              ),
                              Expanded(child: Divider(color: Colors.grey.shade300)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}