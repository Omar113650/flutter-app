import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './presentation/screens/splash_screen.dart';
import './presentation/screens/sign_in.dart';
import './presentation/screens/Sign_up.dart';
import './presentation/screens/verification_screen.dart';
import './presentation/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Management',
      theme: ThemeData(
        primaryColor: const Color(0xFF3F3387),
        scaffoldBackgroundColor: const Color(0xFF050507),
      ),
      home: const AuthGate(), // ← غيرنا initialRoute إلى AuthGate
      routes: {
        '/sign_in': (context) => const LoginScreen(),
        '/sign_up': (context) => const RegisterScreen(),
        '/verification': (context) => VerificationScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const MainScreen();
        }

        return const SplashScreen();
      },
    );
  }
}
