import 'package:flutter/material.dart';

// Emergency Screen - Screen 30 in design PDF
// Worker presses SOS here to alert security and share location
class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen>
    with SingleTickerProviderStateMixin {
  bool _sosActivated = false;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Support contacts list
  final List<Map<String, dynamic>> _contacts = [
    {
      'icon': Icons.local_police_outlined,
      'iconBg': const Color(0xFFFEE2E2),
      'iconColor': const Color(0xFFEF4444),
      'title': 'Local Police (Emergency)',
      'sub': 'Direct response for civil issues',
      'number': '15',
    },
    {
      'icon': Icons.shield_outlined,
      'iconBg': const Color(0xFFEFF6FF),
      'iconColor': const Color(0xFF1E3A8A),
      'title': 'Company Security Team',
      'sub': 'Internal rapid deployment',
      'number': '+92 300 1234567',
    },
    {
      'icon': Icons.support_agent_outlined,
      'iconBg': const Color(0xFFFFFBEB),
      'iconColor': const Color(0xFFFBB700),
      'title': 'Worker Support Hotline',
      'sub': 'Job-related guidance & help',
      'number': '0800-SAFE-WORK',
    },
  ];

  @override
  void initState() {
    super.initState();
    // pulsing animation for SOS button glow
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _activateSos() {
    setState(() => _sosActivated = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('SOS ACTIVATED - Security team has been alerted!'),
        backgroundColor: Color(0xFFEF4444),
        duration: Duration(seconds: 4),
      ),
    );
  }

  void _cancelEmergency() {
    setState(() => _sosActivated = false);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left,
              size: 28, color: Color(0xFF374151)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Emergency SOS',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E)),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.warning_amber_rounded,
                color: Color(0xFFEF4444), size: 18),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Live tracking badge
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'LIVE TRACKING ACTIVE',
                      style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF374151)),
                    ),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 14, color: Color(0xFF1E3A8A)),
                        SizedBox(width: 4),
                        Text(
                          'LHR-District-4',
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF1E3A8A),
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),

              // SOS button with pulse animation
              ScaleTransition(
                scale: _pulseAnimation,
                child: GestureDetector(
                  onLongPress: _activateSos,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Hold the button for 3 seconds to activate SOS')),
                    );
                  },
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _sosActivated
                          ? const Color(0xFFB91C1C)
                          : const Color(0xFFEF4444),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFEF4444).withOpacity(0.35),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shield_outlined,
                            color: Colors.white, size: 40),
                        const SizedBox(height: 8),
                        Text(
                          _sosActivated ? 'ACTIVATED' : 'SOS',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                        Text(
                          _sosActivated ? 'HELP IS ON THE WAY' : 'HOLD FOR 3S',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Colors.white70,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                _sosActivated
                    ? 'Alert sent! Security team and your location have been shared.'
                    : 'This will alert local security and share\nyour live location.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: _sosActivated
                      ? const Color(0xFFEF4444)
                      : const Color(0xFF6B7280),
                  height: 1.5,
                  fontWeight: _sosActivated ? FontWeight.w600 : FontWeight.w400,
                ),
              ),

              const SizedBox(height: 32),

              // Immediate support section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Immediate Support',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text(
                      'Verified Numbers',
                      style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6B7280),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // Contact cards
              ..._contacts.map(
                    (c) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border:
                    Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: c['iconBg'],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(c['icon'] as IconData,
                            color: c['iconColor'] as Color, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              c['title'],
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A2E)),
                            ),
                            Text(
                              c['sub'],
                              style: const TextStyle(
                                  fontSize: 11,
                                  color: Color(0xFF6B7280)),
                            ),
                            Text(
                              c['number'],
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: c['iconColor'] as Color),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF3F4F6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.phone_outlined,
                            color: Color(0xFF374151), size: 18),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Safety tip
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.access_time_outlined,
                        color: Color(0xFFFBB700), size: 18),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Safety Tip',
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A1A2E)),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Always keep your phone charged and mobile data enabled during late-night jobs. Your location is being monitored for your safety.',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                                height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'FOR NON-EMERGENCY SUPPORT, USE THE CHAT FEATURE.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 1.2,
                    color: Color(0xFF9CA3AF)),
              ),

              const SizedBox(height: 20),

              // Cancel button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: _cancelEmergency,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Cancel Emergency Mode',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E3A8A)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}