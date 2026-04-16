import 'dart:async';
import 'package:flutter/material.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<TextEditingController> controllers =
      List.generate(6, (_) => TextEditingController());

  List<FocusNode> nodes = List.generate(6, (_) => FocusNode());

  String? errorText;

  Timer? timer;
  int seconds = 60;

  String? verificationId;

  final String phoneNumber = "+201065466184";

  // ✅ الكود الثابت
  final String testCode = "123456";

  @override
  void initState() {
    super.initState();
    startTimer();
    sendOTP(phoneNumber);
  }

  @override
  void dispose() {
    timer?.cancel();

    for (var c in controllers) {
      c.dispose();
    }

    for (var n in nodes) {
      n.dispose();
    }

    super.dispose();
  }

  // 🔥 FAKE SEND OTP
  Future<void> sendOTP(String phone) async {
    print("🚀 Fake OTP sent to: $phone");

    setState(() {
      verificationId = "test_verification_id";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Test OTP is: $testCode"),
        backgroundColor: Colors.green,
      ),
    );
  }

  // ⏱ TIMER
  void startTimer() {
    timer?.cancel();

    setState(() {
      seconds = 60;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (seconds == 0) {
        t.cancel();
        return;
      }

      setState(() {
        seconds--;
      });
    });
  }

  // 🔥 VERIFY (MANUAL)
  void verify() async {
    String code = controllers.map((e) => e.text).join();

    print("🔐 Entered code: $code");

    if (code.length < 6) {
      setState(() => errorText = "Please enter full code");
      return;
    }

    if (verificationId == null) {
      setState(() => errorText = "OTP not sent yet ❌");
      return;
    }

    if (code == testCode) {
      setState(() => errorText = "Verified successfully ✅");

      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        Navigator.pushReplacementNamed(context, '/main');
      }
    } else {
      setState(() {
        errorText = "Invalid code ❌";
      });
    }
  }

  // 🔁 RESEND
  void resend() {
    for (var c in controllers) {
      c.clear();
    }

    FocusScope.of(context).requestFocus(nodes[0]);
    setState(() => errorText = null);

    startTimer();
    sendOTP(phoneNumber);
  }

  Widget otpBox(int i) {
    return Container(
      width: 45,
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 237, 239, 250),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF766BAF)),
      ),
      child: TextField(
        controller: controllers[i],
        focusNode: nodes[i],
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (v) {
          setState(() => errorText = null);

          if (v.isNotEmpty && i < 5) {
            FocusScope.of(context).requestFocus(nodes[i + 1]);
          }

          if (v.isEmpty && i > 0) {
            FocusScope.of(context).requestFocus(nodes[i - 1]);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2249),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E9F6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.verified_user,
                        size: 50,
                        color: Color(0xFF3F3387),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Enter verification code",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "We sent a code to your phone.",
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(6, otpBox),
                      ),
                      const SizedBox(height: 15),
                      if (errorText != null)
                        Text(
                          errorText!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: verify,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3F3387),
                          ),
                          child: const Text(
                            "Verify",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      seconds > 0
                          ? Text(
                              "Didn’t receive code? 00:${seconds.toString().padLeft(2, '0')}",
                            )
                          : GestureDetector(
                              onTap: resend,
                              child: const Text(
                                "Resend code",
                                style: TextStyle(
                                  color: Color(0xFF3F3387),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ],
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
