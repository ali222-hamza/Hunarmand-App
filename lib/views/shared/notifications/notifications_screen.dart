import 'package:flutter/material.dart';

// Notifications Screen - Screen 25 in design PDF
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedTab = 0; // 0 = services, 1 = payments

  final List<Map<String, dynamic>> _serviceNotifs = [
    {
      'icon': Icons.notifications_outlined,
      'iconBg': const Color(0xFFEFF6FF),
      'iconColor': const Color(0xFF1E3A8A),
      'title': 'New Job Request',
      'time': '2 mins ago',
      'body': 'Electrician needed in Gulberg III for immediate AC repair service.',
      'isNew': true,
    },
    {
      'icon': Icons.chat_bubble_outline,
      'iconBg': const Color(0xFFF3F4F6),
      'iconColor': const Color(0xFF374151),
      'title': 'Message from Client',
      'time': '5 hours ago',
      'body': 'Ahmed: "I have shared the location pin, please check."',
      'isNew': false,
    },
    {
      'icon': Icons.security_outlined,
      'iconBg': const Color(0xFFF3F4F6),
      'iconColor': const Color(0xFF374151),
      'title': 'Security Alert',
      'time': 'Yesterday',
      'body': 'A new login was detected from a different device in Karachi.',
      'isNew': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(8)),
                    child: const Icon(Icons.bolt, color: Color(0xFFFBB700), size: 18),
                  ),
                  const SizedBox(width: 8),
                  const Text('Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
                  const Spacer(),
                  IconButton(icon: const Icon(Icons.more_vert, color: Color(0xFF6B7280)), onPressed: () {}),
                ],
              ),
            ),

            // Tabs
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    _tab('Services', 0, true),
                    _tab('Payments', 1, false),
                  ],
                ),
              ),
            ),

            // Notifications list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _serviceNotifs.length,
                itemBuilder: (context, i) {
                  final n = _serviceNotifs[i];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFE5E7EB)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(color: n['iconBg'], borderRadius: BorderRadius.circular(10)),
                              child: Icon(n['icon'] as IconData, color: n['iconColor'] as Color, size: 22),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(n['title'], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
                                  Text(n['time'], style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(n['body'], style: const TextStyle(fontSize: 13, color: Color(0xFF374151), height: 1.4)),
                        if (n['isNew']) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(color: const Color(0xFFFBB700), borderRadius: BorderRadius.circular(6)),
                                child: const Text('New', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => Navigator.pushNamed(context, '/job_request'),
                                child: const Text('View Details >', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A))),
                              ),
                            ],
                          ),
                        ],
                        if (!n['isNew'] && n['title'] == 'Message from Client') ...[
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/chat'),
                            child: const Text('Reply >', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A))),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),

            // End of updates
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Icon(Icons.access_time_outlined, color: Color(0xFFD1D5DB), size: 22),
                  SizedBox(height: 6),
                  Text('END OF RECENT UPDATES', style: TextStyle(fontSize: 10, letterSpacing: 1.5, color: Color(0xFFD1D5DB))),
                ],
              ),
            ),

            // Bottom nav
            _buildNav(context),
          ],
        ),
      ),

      // SOS button
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/emergency'),
        backgroundColor: const Color(0xFFEF4444),
        child: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      ),
    );
  }

  Widget _tab(String label, int index, bool hasDot) {
    bool active = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                index == 0 ? Icons.notifications_outlined : Icons.account_balance_wallet_outlined,
                size: 16,
                color: active ? const Color(0xFF1E3A8A) : const Color(0xFF9CA3AF),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                  color: active ? const Color(0xFF1E3A8A) : const Color(0xFF9CA3AF),
                ),
              ),
              const SizedBox(width: 4),
              Container(width: 6, height: 6, decoration: const BoxDecoration(color: Color(0xFFFBB700), shape: BoxShape.circle)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNav(BuildContext context) {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Dashboard'},
      {'icon': Icons.account_balance_wallet_outlined, 'label': 'Wallet'},
      {'icon': Icons.bar_chart_outlined, 'label': 'Analytics'},
      {'icon': Icons.notifications_outlined, 'label': 'Alerts'},
      {'icon': Icons.settings_outlined, 'label': 'Settings'},
    ];
    return Container(
      color: Colors.white,
      child: Row(
        children: List.generate(items.length, (i) {
          bool active = i == 3;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                if (i == 0) Navigator.pushReplacementNamed(context, '/worker_home');
                if (i == 1) Navigator.pushNamed(context, '/wallet');
                if (i == 4) Navigator.pushNamed(context, '/settings');
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Icon(items[i]['icon'] as IconData, size: 22, color: active ? const Color(0xFF1E3A8A) : const Color(0xFF9CA3AF)),
                  const SizedBox(height: 4),
                  Text(items[i]['label'] as String, style: TextStyle(fontSize: 10, color: active ? const Color(0xFF1E3A8A) : const Color(0xFF9CA3AF))),
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