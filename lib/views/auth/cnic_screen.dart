import 'package:flutter/material.dart';
// Apni responsive file ka path yahan zaroor check kar lein
import '../../../core/utils/responsive.dart';

class CnicScreen extends StatefulWidget {
  const CnicScreen({super.key});

  @override
  State<CnicScreen> createState() => _CnicScreenState();
}

class _CnicScreenState extends State<CnicScreen> {
  int step = 1; // step 1 = front, step 2 = back
  bool captured = false;

  void capture() {
    if (step == 1) {
      setState(() => step = 2);
    } else {
      Navigator.pushReplacementNamed(context, '/role');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left,
              color: const Color(0xFF374151),
              size: Responsive.scaleWidth(context, 28)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'CNIC Verification',
          style: TextStyle(
              fontSize: Responsive.fontSize(context, 17),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E)),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Step info card - Responsive padding
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(Responsive.scaleWidth(context, 16)),
              color: const Color(0xFFEFF6FF),
              child: Row(
                children: [
                  Container(
                    width: Responsive.scaleWidth(context, 36),
                    height: Responsive.scaleWidth(context, 36),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDBEAFE),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.shield_outlined,
                        size: Responsive.scaleWidth(context, 20),
                        color: const Color(0xFF1E3A8A)),
                  ),
                  SizedBox(width: Responsive.scaleWidth(context, 12)),
                  Expanded( // Added Expanded to prevent text overflow
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          step == 1 ? 'CNIC Front Side' : 'CNIC Back Side',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 16),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1E3A8A),
                          ),
                        ),
                        Text(
                          step == 1
                              ? 'Place the front side inside the frame'
                              : 'Now place the back side inside the frame',
                          style: TextStyle(
                              fontSize: Responsive.fontSize(context, 12),
                              color: const Color(0xFF6B7280)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Step Indicator Row
            Padding(
              padding: EdgeInsets.fromLTRB(
                  Responsive.scaleWidth(context, 16),
                  Responsive.scaleHeight(context, 12),
                  Responsive.scaleWidth(context, 16), 0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFFBB700)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.circle, size: 8, color: Color(0xFFFBB700)),
                        const SizedBox(width: 6),
                        Text(
                          'Auto-detecting',
                          style: TextStyle(
                              fontSize: Responsive.fontSize(context, 12),
                              color: const Color(0xFFFBB700),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Step $step of 2',
                    style: TextStyle(
                        fontSize: Responsive.fontSize(context, 13),
                        color: const Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),

            // Camera View Area - Adjusted for different aspect ratios
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(Responsive.scaleWidth(context, 16)),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F2937),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ALIGN ID WITHIN FRAME',
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 11),
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                          backgroundColor: Colors.black45,
                        ),
                      ),
                      SizedBox(height: Responsive.scaleHeight(context, 20)),
                      // Frame painter using Responsive width/height
                      CustomPaint(
                        size: Size(
                            Responsive.scaleWidth(context, 260),
                            Responsive.scaleHeight(context, 160)
                        ),
                        painter: _FramePainter(),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Tips Box
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.scaleWidth(context, 16)),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, color: Color(0xFFFBB700), size: 18),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tip: Use a well-lit area and avoid glares for faster verification.',
                        style: TextStyle(
                            fontSize: Responsive.fontSize(context, 11),
                            color: const Color(0xFF6B7280)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: Responsive.scaleHeight(context, 20)),

            // Capture Button
            GestureDetector(
              onTap: capture,
              child: Column(
                children: [
                  Container(
                    width: Responsive.scaleWidth(context, 70),
                    height: Responsive.scaleWidth(context, 70),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFBB700),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                    ),
                    child: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 30),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'TAP TO CAPTURE',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 10),
                      letterSpacing: 1.2,
                      color: const Color(0xFF6B7280),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Responsive.scaleHeight(context, 24)),
          ],
        ),
      ),
    );
  }
}

class _FramePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFBB700)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    double corner = 24;

    // Corner painting logic remains same
    canvas.drawLine(Offset(0, corner), const Offset(0, 0), paint);
    canvas.drawLine(const Offset(0, 0), Offset(corner, 0), paint);
    canvas.drawLine(Offset(size.width - corner, 0), Offset(size.width, 0), paint);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, corner), paint);
    canvas.drawLine(Offset(0, size.height - corner), Offset(0, size.height), paint);
    canvas.drawLine(Offset(0, size.height), Offset(corner, size.height), paint);
    canvas.drawLine(Offset(size.width - corner, size.height), Offset(size.width, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height - corner), Offset(size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}