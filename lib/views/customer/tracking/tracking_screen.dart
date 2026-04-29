import 'package:flutter/material.dart';

// Tracking Screen - Screen 14 in design PDF
// Customer sees where the worker is on a map
class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  int _selectedTab = 2; // tracking tab is active

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left,
                        size: 28, color: Color(0xFF374151)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text(
                      'Tracking Worker',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border:
                      Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: const Text(
                      'Live',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF374151)),
                    ),
                  ),
                ],
              ),
            ),

            // Status pill
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 8)
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Electrician is on the way',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E)),
                  ),
                  Text(
                    'Arriving at 2:45 PM',
                    style: TextStyle(
                        fontSize: 12, color: Color(0xFF6B7280)),
                  ),
                ],
              ),
            ),

            // Map area (fake map with styled container)
            Expanded(
              child: Stack(
                children: [
                  // Map background
                  Container(
                    color: const Color(0xFFE8F0E9),
                    child: CustomPaint(
                      size: Size.infinite,
                      painter: _FakeMapPainter(),
                    ),
                  ),

                  // Route line drawn on map
                  CustomPaint(
                    size: Size.infinite,
                    painter: _RoutePainter(),
                  ),

                  // Worker marker
                  Positioned(
                    top: 120,
                    left: MediaQuery.of(context).size.width * 0.4,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 6)
                            ],
                          ),
                          child: const Text(
                            'Arshad is moving',
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1A1A2E)),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.bolt,
                              color: Color(0xFF1E3A8A), size: 20),
                        ),
                      ],
                    ),
                  ),

                  // Home marker
                  Positioned(
                    bottom: 40,
                    right: 50,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF1E3A8A),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.home,
                          color: Colors.white, size: 22),
                    ),
                  ),
                ],
              ),
            ),

            // Worker info card at bottom
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 26,
                            backgroundColor: const Color(0xFFE5E7EB),
                            child: Icon(Icons.person,
                                color: Colors.grey.shade500),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: const Color(0xFF22C55E),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 2),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Arshad Khan',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1A1A2E)),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.verified_user_outlined,
                                    size: 16, color: Color(0xFF1E3A8A)),
                              ],
                            ),
                            const Text(
                              'Expert Electrician • 4.98 Rating',
                              style: TextStyle(
                                  fontSize: 12, color: Color(0xFF6B7280)),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert,
                            color: Color(0xFF6B7280)),
                        onPressed: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // ETA and distance
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ESTIMATED ARRIVAL',
                                  style: TextStyle(
                                      fontSize: 10,
                                      letterSpacing: 1,
                                      color: Color(0xFF9CA3AF))),
                              SizedBox(height: 4),
                              Text(
                                '8 mins',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1A1A2E)),
                              ),
                            ],
                          ),
                        ),
                        VerticalDivider(color: Color(0xFFE5E7EB)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('DISTANCE',
                                  style: TextStyle(
                                      fontSize: 10,
                                      letterSpacing: 1,
                                      color: Color(0xFF1E3A8A))),
                              SizedBox(height: 4),
                              Text(
                                '1.2 km',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1E3A8A)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.phone_outlined,
                              size: 18, color: Colors.white),
                          label: const Text('Call Arshad',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E3A8A),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/chat'),
                          icon: const Icon(Icons.chat_bubble_outline,
                              size: 18, color: Color(0xFF1E3A8A)),
                          label: const Text('Chat',
                              style: TextStyle(
                                  color: Color(0xFF1E3A8A),
                                  fontWeight: FontWeight.w700)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Color(0xFF1E3A8A)),
                            padding:
                            const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bottom nav
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.search_outlined, 'label': 'Search'},
      {'icon': Icons.location_on_outlined, 'label': 'Tracking'},
      {'icon': Icons.history_outlined, 'label': 'History'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
    ];
    return Container(
      color: Colors.white,
      child: Row(
        children: List.generate(items.length, (i) {
          bool active = i == _selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = i),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Icon(items[i]['icon'] as IconData,
                      size: 22,
                      color: active
                          ? const Color(0xFF1E3A8A)
                          : const Color(0xFF9CA3AF)),
                  const SizedBox(height: 4),
                  Text(items[i]['label'] as String,
                      style: TextStyle(
                          fontSize: 11,
                          color: active
                              ? const Color(0xFF1E3A8A)
                              : const Color(0xFF9CA3AF))),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

// Draws simple road lines to simulate a map
class _FakeMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()
      ..color = Colors.white
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(0, size.height * 0.4),
        Offset(size.width, size.height * 0.4), road);
    canvas.drawLine(Offset(size.width * 0.5, 0),
        Offset(size.width * 0.5, size.height), road);
    canvas.drawLine(Offset(0, size.height * 0.7),
        Offset(size.width, size.height * 0.7), road);
    canvas.drawLine(Offset(size.width * 0.25, 0),
        Offset(size.width * 0.25, size.height), road);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// Draws a dashed route line from worker to home
class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final solid = Paint()
      ..color = const Color(0xFF1E3A8A)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final dashed = Paint()
      ..color = const Color(0xFF1E3A8A)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Solid line part (worker path so far)
    canvas.drawLine(
      Offset(size.width * 0.35, size.height * 0.1),
      Offset(size.width * 0.45, size.height * 0.45),
      solid,
    );

    // Dashed line (remaining path to home)
    double startY = size.height * 0.45;
    double endY = size.height * 0.75;
    double x1 = size.width * 0.45;
    double x2 = size.width * 0.75;
    double steps = 10;
    for (int i = 0; i < steps; i++) {
      double t1 = i / steps;
      double t2 = (i + 0.5) / steps;
      canvas.drawLine(
        Offset(x1 + (x2 - x1) * t1, startY + (endY - startY) * t1),
        Offset(x1 + (x2 - x1) * t2, startY + (endY - startY) * t2),
        dashed,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}