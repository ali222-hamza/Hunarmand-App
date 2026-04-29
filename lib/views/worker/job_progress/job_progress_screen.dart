import 'dart:async';
import 'dart:ui'; // For FontFeature
import 'package:flutter/material.dart';
// Apni responsive file ka path yahan zaroor check kar lein
import '../../../core/utils/responsive.dart';

class JobProgressScreen extends StatefulWidget {
  const JobProgressScreen({super.key});

  @override
  State<JobProgressScreen> createState() => _JobProgressScreenState();
}

class _JobProgressScreenState extends State<JobProgressScreen> {
  int _elapsedSeconds = 2535; // 42 mins 15 secs in seconds
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (mounted) setState(() => _elapsedSeconds++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int secs) {
    int h = secs ~/ 3600;
    int m = (secs % 3600) ~/ 60;
    int s = secs % 60;
    return '${h.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void _finishJob() {
    _timer?.cancel();
    Navigator.pushReplacementNamed(context, '/review');
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
              size: Responsive.scaleWidth(context, 28), color: const Color(0xFF374151)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Job in Progress',
          style: TextStyle(
              fontSize: Responsive.fontSize(context, 17),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E)),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/emergency'),
            child: Container(
              margin: EdgeInsets.only(right: Responsive.scaleWidth(context, 12)),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFEE2E2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'SOS',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFEF4444)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Estimated completion banner
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.scaleWidth(context, 16),
                  vertical: Responsive.scaleHeight(context, 10)),
              color: const Color(0xFF1E3A8A),
              child: Row(
                children: [
                  const Icon(Icons.access_time, color: Colors.white, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Est. Completion: 12:45 PM',
                    style: TextStyle(
                        fontSize: Responsive.fontSize(context, 13),
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'On Track',
                      style: TextStyle(
                          fontSize: Responsive.fontSize(context, 11),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1E3A8A)),
                    ),
                  ),
                ],
              ),
            ),

            // Map area
            Expanded(
              child: Stack(
                children: [
                  Container(
                    color: const Color(0xFFE8F0E9),
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: _SimpleMapPainter(),
                    ),
                  ),

                  // Timer Card - Responsive sizing
                  Positioned(
                    top: Responsive.scaleHeight(context, 16),
                    left: Responsive.scaleWidth(context, 16),
                    right: Responsive.scaleWidth(context, 16),
                    child: Container(
                      padding: EdgeInsets.all(Responsive.scaleWidth(context, 16)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'LIVE TRACKING',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 11),
                              letterSpacing: 1.5,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                          SizedBox(height: Responsive.scaleHeight(context, 6)),
                          Text(
                            _formatTime(_elapsedSeconds),
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 36),
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF1A1A2E),
                              fontFeatures: const [FontFeature.tabularFigures()],
                            ),
                          ),
                          Text(
                            'DURATION OF SERVICE',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 10),
                              letterSpacing: 1.5,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Pins (Bottom references)
                  Positioned(
                    bottom: Responsive.scaleHeight(context, 40),
                    right: Responsive.scaleWidth(context, 60),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFBB700),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('Client', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                        const Icon(Icons.location_on, size: 32, color: Color(0xFFFBB700)),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Client Info Bottom Card
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(Responsive.scaleWidth(context, 16)),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: Responsive.scaleWidth(context, 24),
                        backgroundColor: const Color(0xFFE5E7EB),
                        child: Icon(Icons.person, color: Colors.grey.shade500),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Zubair Ahmed',
                              style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 15),
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1A1A2E)),
                            ),
                            Text('Plumbing Repair',
                                style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 12),
                                    color: const Color(0xFF6B7280))),
                          ],
                        ),
                      ),
                      _circleActionButton(Icons.phone_outlined),
                    ],
                  ),

                  SizedBox(height: Responsive.scaleHeight(context, 12)),

                  // Address box
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 18, color: Color(0xFFFBB700)),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('SERVICE ADDRESS',
                                  style: TextStyle(
                                      fontSize: Responsive.fontSize(context, 9),
                                      letterSpacing: 1,
                                      color: const Color(0xFF9CA3AF))),
                              Text(
                                'House 42-B, Sector Z, DHA Phase 6',
                                style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 13),
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF1A1A2E)),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Responsive.scaleHeight(context, 12)),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFFE5E7EB)),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text('Call Client', style: TextStyle(fontSize: Responsive.fontSize(context, 13), color: const Color(0xFF374151))),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFBB700),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          child: Text('Navigate', style: TextStyle(fontSize: Responsive.fontSize(context, 13), color: const Color(0xFF1A1A2E), fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: Responsive.scaleHeight(context, 12)),

                  SizedBox(
                    width: double.infinity,
                    height: Responsive.scaleHeight(context, 50),
                    child: ElevatedButton.icon(
                      onPressed: _finishJob,
                      icon: const Icon(Icons.check_circle_outline, color: Colors.white, size: 20),
                      label: Text('Finish Job',
                          style: TextStyle(
                              fontSize: Responsive.fontSize(context, 16),
                              fontWeight: FontWeight.w700,
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _circleActionButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
    );
  }
}

class _SimpleMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = Colors.white
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.5), p);
    canvas.drawLine(Offset(size.width * 0.4, 0), Offset(size.width * 0.4, size.height), p);
    canvas.drawLine(Offset(size.width * 0.7, 0), Offset(size.width * 0.7, size.height), p);
  }
  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}