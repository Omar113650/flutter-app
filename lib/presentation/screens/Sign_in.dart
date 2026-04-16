import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' as math;
import 'logo.dart';

class AppColors {
  static const Color mainPurple = Color(0xFF3F3387);
  static const Color darkPurple = Color(0xFF2D2249);
  static const Color secondary = Color(0xFF766BAF);
  static const Color softSection = Color(0xFFB3B5E1);
  static const Color whitePanel = Color(0xFFFBFBFB);
  static const Color trueDark = Color(0xFF050507);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool obscure = true;
  bool rememberMe = false;

  Future<void> signin() async {
    setState(() => isLoading = true);

    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushReplacementNamed(context, '/verification');

    } on FirebaseAuthException catch (e) {
      if (!mounted) return;

      String message = 'An error occurred. Please try again.';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An unexpected error occurred.')),
      );

    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final logoSize = math.min(90.0, width * 0.14);

    return Scaffold(
      backgroundColor: AppColors.darkPurple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              const SizedBox(height: 40),

              /// Header
              Column(
                children: [
                  AppLogo(size: logoSize),
                  const SizedBox(height: 12),
                  const Text(
                    "Welcome back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Sign in to continue",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// Form Card
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 18),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBFBFB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text("Email address",
                        style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 6),

                    TextField(
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined,
                            color: Colors.white54),
                        filled: true,
                        fillColor: AppColors.mainPurple,
                        hintText: "you@example.com",
                        hintStyle:
                            const TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text("Password",
                        style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 6),

                    TextField(
                      controller: passwordController,
                      obscureText: obscure,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outline,
                            color: Colors.white54),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white54,
                          ),
                          onPressed: () =>
                              setState(() => obscure = !obscure),
                        ),
                        filled: true,
                        fillColor: AppColors.mainPurple,
                        hintText: "Enter your password",
                        hintStyle:
                            const TextStyle(color: Colors.white54),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: rememberMe,
                              onChanged: (v) => setState(
                                  () => rememberMe = v ?? false),
                              activeColor: AppColors.secondary,
                            ),
                            const Text("Remember me",
                                style: TextStyle(
                                    color: AppColors.mainPurple,
                                    fontSize: 12)),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/forgetPassword');
                          },
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: AppColors.mainPurple,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : signin, 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : const Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: const [
                  Expanded(child: Divider(color: Colors.white24)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "or continue with",
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.white24)),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(child: buildSocial("Google")),
                  const SizedBox(width: 10),
                  Expanded(child: buildSocial("Apple")),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(
                        color: Colors.white60, fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/sign_up');
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
  

  Widget buildSocial(String label) {
    return Container(
      height: 46,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (label == "Google")
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 12,
                child: Text(
                  'G',
                  style: TextStyle(
                    color: AppColors.mainPurple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            else
              const Icon(Icons.apple, color: Colors.white),

            const SizedBox(width: 6),

            Text(
              label,
              style: const TextStyle(
                  color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}