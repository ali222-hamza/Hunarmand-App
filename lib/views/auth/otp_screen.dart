import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Apni responsive file ka path yahan zaroor check kar lein
import '../../../core/utils/responsive.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes =
  List.generate(4, (_) => FocusNode());

  int secondsLeft = 60;
  Timer? countdown;
  bool canResend = false;

  @override
  void initState() {
    super.initState();
    startCountdown();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) focusNodes[0].requestFocus();
    });
  }

  void startCountdown() {
    countdown?.cancel();
    countdown = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) { t.cancel(); return; }
      setState(() {
        if (secondsLeft > 0) {
          secondsLeft--;
        } else {
          canResend = true;
          t.cancel();
        }
      });
    });
  }

  void resendCode() {
    setState(() { secondsLeft = 60; canResend = false; });
    startCountdown();
    for (var c in controllers) c.clear();
    focusNodes[0].requestFocus();
  }

  void verify() {
    String otp = controllers.map((c) => c.text).join();
    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 4-digit code')),
      );
      return;
    }
    Navigator.pushNamed(context, '/cnic');
  }

  @override
  void dispose() {
    countdown?.cancel();
    for (var c in controllers) c.dispose();
    for (var f in focusNodes) f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final phone = ModalRoute.of(context)?.settings.arguments as String? ?? '+92 300 ••••••';

    // Responsive Box Calculation
    final double boxSize = Responsive.isSmallScreen(context)
        ? Responsive.scaleWidth(context, 55)
        : Responsive.scaleWidth(context, 65);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: Responsive.scaleWidth(context, 26), color: const Color(0xFF374151)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Verification',
            style: TextStyle(
                fontSize: Responsive.fontSize(context, 16),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E)
            )),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: Responsive.horizontalPadding(context)),
          child: Column(
            children: [
              SizedBox(height: Responsive.scaleHeight(context, 32)),
              Container(
                width: Responsive.scaleWidth(context, 72),
                height: Responsive.scaleWidth(context, 72),
                decoration: const BoxDecoration(color: Color(0xFFEFF6FF), shape: BoxShape.circle),
                child: Icon(Icons.verified_user_outlined, size: Responsive.scaleWidth(context, 34), color: const Color(0xFF1E3A8A)),
              ),
              SizedBox(height: Responsive.scaleHeight(context, 20)),
              Text('Enter 4-Digit Code',
                  style: TextStyle(
                      fontSize: Responsive.fontSize(context, 22),
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1A1A2E)
                  )),
              SizedBox(height: Responsive.scaleHeight(context, 8)),
              Text(
                "We've sent a 4-digit verification code to\nyour registered mobile number",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: Responsive.fontSize(context, 13),
                    color: const Color(0xFF6B7280),
                    height: 1.4
                ),
              ),
              const SizedBox(height: 6),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(phone,
                    style: TextStyle(
                        fontSize: Responsive.fontSize(context, 14),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A2E)
                    )),
              ),
              SizedBox(height: Responsive.scaleHeight(context, 28)),

              // OTP Boxes
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(4, (i) {
                  return Container(
                    width: boxSize,
                    height: boxSize,
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    child: TextFormField(
                      controller: controllers[i],
                      focusNode: focusNodes[i],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(
                          fontSize: Responsive.fontSize(context, 20),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A2E)),
                      decoration: InputDecoration(
                        counterText: '',
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFFE5E7EB))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 2)),
                      ),
                      onChanged: (v) {
                        if (v.isNotEmpty && i < 3) focusNodes[i + 1].requestFocus();
                        if (v.isEmpty && i > 0) focusNodes[i - 1].requestFocus();
                        setState(() {});
                      },
                    ),
                  );
                }),
              ),

              SizedBox(height: Responsive.scaleHeight(context, 24)),

              Text("Didn't receive the code?",
                  style: TextStyle(fontSize: Responsive.fontSize(context, 13), color: const Color(0xFF6B7280))),
              const SizedBox(height: 4),
              GestureDetector(
                onTap: canResend ? resendCode : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Resend in  ',
                        style: TextStyle(
                            fontSize: Responsive.fontSize(context, 13),
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A2E)
                        )),
                    Text(
                      canResend ? 'Resend Now' : '00:${secondsLeft.toString().padLeft(2, '0')}',
                      style: TextStyle(
                          fontSize: Responsive.fontSize(context, 13),
                          fontWeight: FontWeight.w700,
                          color: canResend ? const Color(0xFF1E3A8A) : const Color(0xFFFBB700)),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Responsive.scaleHeight(context, 28)),

              SizedBox(
                width: double.infinity,
                height: Responsive.scaleHeight(context, 50),
                child: ElevatedButton(
                  onPressed: verify,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Verify',
                      style: TextStyle(
                          fontSize: Responsive.fontSize(context, 15),
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                      )),
                ),
              ),

              SizedBox(height: Responsive.scaleHeight(context, 32)),

              GestureDetector(
                onTap: () {},
                child: Text('Having trouble? Contact Support',
                    style: TextStyle(
                        fontSize: Responsive.fontSize(context, 12),
                        color: const Color(0xFF1E3A8A),
                        decoration: TextDecoration.underline
                    )),
              ),
              const SizedBox(height: 10),
              Text('POWERED BY HUNARMAND SECURITY',
                  style: TextStyle(
                      fontSize: Responsive.fontSize(context, 9),
                      letterSpacing: 1.5,
                      color: const Color(0xFFD1D5DB)
                  )),
              SizedBox(height: Responsive.scaleHeight(context, 24)),
            ],
          ),
        ),
      ),
    );
  }
}