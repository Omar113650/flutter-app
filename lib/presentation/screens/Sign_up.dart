import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ===================== AppLogo =====================
class AppLogo extends StatelessWidget {
  final double size;
  final bool decorated;

  const AppLogo({super.key, this.size = 64, this.decorated = true});

  @override
  Widget build(BuildContext context) {
    final borderRadius = size * 0.25;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: decorated
            ? const LinearGradient(
                colors: [Color(0xFF3F3387), Color(0xFF766BAF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Center(
        child: Icon(
          Icons.hexagon_outlined,
          color: Colors.white,
          size: size * 0.5,
        ),
      ),
    );
  }
}

// ===================== RegisterScreen =====================
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const cPrimary = Color(0xFF3F3387);
  static const cDark = Color(0xFF2D2249);
  static const cAccent = Color(0xFF766BAF);
  static const cSurface = Color(0xFFB3B5E1);
  static const cWhite = Color(0xFFFBFBFB);

  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  bool _obscurePass = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon, {
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: cSurface, fontSize: 14),
      prefixIcon: Icon(icon, color: cAccent, size: 20),
      suffixIcon: suffix,
      filled: true,
      fillColor: cWhite,
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: cPrimary,
          ),
        ),
      );

  // ===================== Firebase Register =====================
 void _register() async {
  if (!_formKey.currentState!.validate()) return;

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailCtrl.text.trim(),
      password: _passCtrl.text.trim(),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: cPrimary,
        ),
      );
    }

    await Future.delayed(const Duration(milliseconds: 1200));

    if (mounted) {
      Navigator.pushReplacementNamed(context, '/verification');
    }
  }

  // ✅ أخطاء Firebase المعروفة
  on FirebaseAuthException catch (e) {
    print("🔥 Firebase Error Code: ${e.code}");
    print("🔥 Firebase Error Message: ${e.message}");

    if (!mounted) return;

    String message = 'Something went wrong';

    switch (e.code) {
      case 'email-already-in-use':
        message = 'This email is already in use';
        break;
      case 'invalid-email':
        message = 'Invalid email address';
        break;
      case 'weak-password':
        message = 'Password is too weak (use at least 6 characters)';
        break;
      case 'operation-not-allowed':
        message = 'Email/Password registration is not enabled';
        break;
      case 'network-request-failed':
        message = 'Check your internet connection';
        break;
      default:
        message = e.message ?? 'Registration failed';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  // ❗ أي Error تاني (زي اللي عندك)
  catch (e) {
    print("🔥 ERROR TYPE: ${e.runtimeType}");
    print("🔥 ERROR DETAILS: $e");

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cDark,
      body: SafeArea(
        child: Column(
          children: [
            /// Header
            Container(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: Column(
                children: [
                  const AppLogo(size: 60),
                  const SizedBox(height: 12),
                  const Text(
                    'Create New Account',
                    style: TextStyle(
                      color: cWhite,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Sign up and start your journey with us',
                    style: TextStyle(
                      color: cSurface.withValues(alpha: 0.8),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

            /// Form
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Container(
                  decoration: const BoxDecoration(
                    color: cWhite,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(28)),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _label('Full Name'),
                        TextFormField(
                          controller: _nameCtrl,
                          decoration: _inputDecoration(
                            'Enter your full name',
                            Icons.person_outline,
                          ),
                          validator: (v) =>
                              v!.isEmpty ? 'Enter your name' : null,
                        ),
                        const SizedBox(height: 16),

                        _label('Email Address'),
                        TextFormField(
                          controller: _emailCtrl,
                          decoration: _inputDecoration(
                            'example@email.com',
                            Icons.email_outlined,
                          ),
                          validator: (v) =>
                              v!.contains('@') ? null : 'Invalid email',
                        ),
                        const SizedBox(height: 16),

                        _label('Phone Number'),
                        TextFormField(
                          controller: _phoneCtrl,
                          decoration: _inputDecoration(
                            '01x xxxx xxxx',
                            Icons.phone_outlined,
                          ),
                          validator: (v) =>
                              v!.length < 11 ? 'Invalid phone number' : null,
                        ),
                        const SizedBox(height: 16),

                        _label('Password'),
                        TextFormField(
                          controller: _passCtrl,
                          obscureText: _obscurePass,
                          decoration: _inputDecoration(
                            '••••••••',
                            Icons.lock_outline,
                            suffix: IconButton(
                              icon: Icon(
                                _obscurePass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () => setState(
                                  () => _obscurePass = !_obscurePass),
                            ),
                          ),
                          validator: (v) =>
                              v!.length < 8 ? 'Minimum 8 characters' : null,
                        ),
                        const SizedBox(height: 16),

                        _label('Confirm Password'),
                        TextFormField(
                          controller: _confirmCtrl,
                          obscureText: _obscureConfirm,
                          decoration: _inputDecoration(
                            '••••••••',
                            Icons.lock_outline,
                            suffix: IconButton(
                              icon: Icon(
                                _obscureConfirm
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () => setState(() =>
                                  _obscureConfirm = !_obscureConfirm),
                            ),
                          ),
                          validator: (v) =>
                              v != _passCtrl.text ? 'Passwords do not match' : null,
                        ),

                        const SizedBox(height: 32),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 109, 94, 192),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Register',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Flexible(
                                child: Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 13,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 4),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/sign_in');
                                },
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(
                                    color: Color(0xFF3F3387),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}