import 'package:flutter/material.dart';

// Worker Profile Screen - Screen 12 in design PDF
class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left, size: 28),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(
                    child: Text('Worker Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700)),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Banner + avatar
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Banner image
                        Container(
                          height: 140,
                          width: double.infinity,
                          color: const Color(0xFF374151),
                          child: const Icon(Icons.image,
                              size: 48, color: Colors.white30),
                        ),
                        Positioned(
                          bottom: -30,
                          left: 20,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: const Color(0xFFE5E7EB),
                                child: Icon(Icons.person,
                                    size: 40, color: Colors.grey.shade500),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFBB700),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.verified_user,
                                      size: 12, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: -30,
                          right: 20,
                          child: OutlinedButton.icon(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/chat'),
                            icon: const Icon(Icons.chat_bubble_outline,
                                size: 16),
                            label: const Text('Chat'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF1E3A8A),
                              side: const BorderSide(
                                  color: Color(0xFF1E3A8A)),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Rahul Sharma',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1A1A2E),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFBEB),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'Verified',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFFBB700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Master Electrician • 8 years exp.',
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF6B7280)),
                          ),

                          const SizedBox(height: 14),

                          // Stats row
                          Row(
                            children: [
                              _statChip(Icons.star, '4.9 (124)'),
                              const SizedBox(width: 8),
                              _statChip(Icons.business_center_outlined, '482 Jobs'),
                              const SizedBox(width: 8),
                              _statChip(Icons.access_time_outlined, '98% On-time'),
                            ],
                          ),

                          const SizedBox(height: 20),
                          const Text('About Rahul',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A2E))),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: const Color(0xFFE5E7EB)),
                            ),
                            child: const Text(
                              'Expert in residential and commercial electrical systems. Specializing in smart home automation, panel upgrades, and energy-efficient lighting solutions. Committed to safety and quality excellence since 2016.',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF374151),
                                  height: 1.5),
                            ),
                          ),

                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Recent Projects',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1A1A2E))),
                              const Text('View All',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF1E3A8A),
                                      fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Project images row
                          SizedBox(
                            height: 100,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _projectCard('Kitchen Rewire', 'Oct 2023'),
                                const SizedBox(width: 10),
                                _projectCard('Panel Upgrade', 'Sep 2023'),
                                const SizedBox(width: 10),
                                _projectCard('Smart Home', 'Aug 2023'),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),
                          const Text('Qualifications',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A2E))),
                          const SizedBox(height: 10),
                          _qualCard(Icons.workspace_premium_outlined,
                              'Licensed Master Electrician',
                              'Reg #IND-88293-SH'),
                          const SizedBox(height: 8),
                          _qualCard(Icons.check_circle_outline,
                              'Full Background Verified',
                              'Certified by HUNARMAND Trust'),

                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('What Customers Say',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1A1A2E))),
                              Row(
                                children: [
                                  const Icon(Icons.star,
                                      size: 14, color: Color(0xFFFBB700)),
                                  const SizedBox(width: 2),
                                  const Text('4.9',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xFF1A1A2E))),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _reviewCard('Priya Mukherjee', '2 days ago', 5,
                              'Rahul was extremely professional. He fixed our complex fuse box issue in no time and even checked the other outlets for free. Highly recommended!'),
                          const SizedBox(height: 8),
                          _reviewCard('Amit Khanna', '1 week ago', 5,
                              'Excellent smart light installation. Tidy work and very patient explaining how to use the app.'),

                          const SizedBox(height: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom book bar
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('STARTING FROM',
                          style: TextStyle(
                              fontSize: 10,
                              letterSpacing: 1,
                              color: Color(0xFF6B7280))),
                      const Text(
                        '\$45/hr',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/booking'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
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

  Widget _statChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF6B7280)),
          const SizedBox(width: 4),
          Text(text,
              style: const TextStyle(
                  fontSize: 12, color: Color(0xFF374151))),
        ],
      ),
    );
  }

  Widget _projectCard(String title, String date) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 130,
          height: 80,
          decoration: BoxDecoration(
            color: const Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.image, color: Color(0xFF9CA3AF)),
        ),
        const SizedBox(height: 4),
        Text(title,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A2E))),
        Text(date,
            style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
      ],
    );
  }

  Widget _qualCard(IconData icon, String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E3A8A), size: 22),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E))),
              Text(sub,
                  style: const TextStyle(
                      fontSize: 12, color: Color(0xFF6B7280))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reviewCard(
      String name, String time, int stars, String review) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFFE5E7EB),
                  child: Icon(Icons.person, color: Colors.grey.shade500, size: 18)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E))),
                  Text(time,
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xFF9CA3AF))),
                ],
              ),
              const Spacer(),
              Row(
                children: List.generate(
                    stars,
                        (_) => const Icon(Icons.star,
                        size: 14, color: Color(0xFFFBB700))),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(review,
              style: const TextStyle(
                  fontSize: 12, color: Color(0xFF374151), height: 1.5)),
        ],
      ),
    );
  }
}