import 'package:flutter/material.dart';

// Terms and Privacy Screen - Screen 29 in design PDF
// Shows legal terms, privacy policy and user must agree before continuing
class TermsScreen extends StatefulWidget {
  const TermsScreen({super.key});

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  bool _agreed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28, color: Color(0xFF374151)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Terms & Privacy',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
        centerTitle: true,
        actions: [
          // FIXED: Removed const because .shade400 is not a constant value
          Icon(Icons.warning_amber_rounded, color: Colors.red.shade400, size: 22),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Version and date row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFBEB),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: const Color(0xFFFDE68A)),
                          ),
                          child: const Text(
                            'v2.4.0',
                            style: TextStyle(
                              fontSize: 11,
                              color: Color(0xFFFBB700),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const Text(
                          'Effective: Oct 24, 2023',
                          style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'Legal Compliance &\nUser Agreement',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E3A8A),
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Please read these terms carefully before using the Worker Management platform. Your continued use indicates your acceptance.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF6B7280),
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFFE5E7EB)),
                    const SizedBox(height: 16),

                    // Terms of Service section
                    const _SectionHeader(icon: Icons.balance, title: 'Terms of Service'),
                    const SizedBox(height: 10),
                    const Text(
                      'These terms govern your access to and use of our services, including our mobile applications and websites in Pakistan.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF374151),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    const _ClauseBox(
                      title: 'CLAUSE 1.1: ELIGIBILITY',
                      body: 'You must be at least 18 years of age and possess a valid CNIC to register as a service provider on this platform.',
                    ),
                    const SizedBox(height: 8),

                    const _ClauseBox(
                      title: 'CLAUSE 2.4: SERVICE FEES',
                      body: 'Our platform reserves the right to deduct a standard 5% administrative fee from all successful job completions.',
                    ),
                    const SizedBox(height: 8),

                    const _ClauseBox(
                      title: 'CLAUSE 3.0: CONDUCT',
                      body: 'Workers are expected to maintain professional standards and adhere to the scheduled timings provided by the client.',
                    ),

                    const SizedBox(height: 20),
                    const Divider(color: Color(0xFFE5E7EB)),
                    const SizedBox(height: 16),

                    // Privacy Policy section
                    const _SectionHeader(icon: Icons.lock_outline, title: 'Privacy Policy'),
                    const SizedBox(height: 10),
                    const Text(
                      'We take your privacy seriously. This section outlines how we collect, use, and protect your personal data and wallet information.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF374151),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Data protection box
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.verified_user_outlined, size: 16, color: Color(0xFF1E3A8A)),
                              SizedBox(width: 6),
                              Text(
                                'Data Protection',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1E3A8A),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 6),
                          Text(
                            'All personal data, including JazzCash/EasyPaisa credentials, are encrypted using industry-standard AES-256 protocols.',
                            style: TextStyle(fontSize: 12, color: Color(0xFF374151)),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Location and ID tracking mini cards
                    const Row(
                      children: [
                        Expanded(
                          child: _MiniInfoCard(
                            icon: Icons.location_on_outlined,
                            title: 'Location Tracking',
                            body: 'Used only for active job navigation and safety.',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _MiniInfoCard(
                            icon: Icons.person_outline,
                            title: 'Verified ID',
                            body: 'Biometric data is processed for account security.',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Community guidelines tile
                    const _ExpandTile(title: 'Community Guidelines'),
                    const SizedBox(height: 8),
                    const _ExpandTile(title: 'Safety Protocols (Urdu)'),

                    const SizedBox(height: 20),

                    // Agree checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: _agreed,
                          onChanged: (v) => setState(() => _agreed = v ?? false),
                          activeColor: const Color(0xFF1E3A8A),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        const Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 12),
                            child: Text(
                              'I acknowledge that I have read and agree to the Terms of Service and Privacy Policy.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xFF374151),
                                height: 1.4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),

            // Continue button at bottom
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _agreed ? () => Navigator.pop(context) : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _agreed ? const Color(0xFF1E3A8A) : const Color(0xFFD1D5DB),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Continue to Dashboard',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Text(
                'Last updated October 2023. © 2023 Worker Management Pakistan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Section title with icon
class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
          ),
        ),
      ],
    );
  }
}

// Clause highlight box with yellow title
class _ClauseBox extends StatelessWidget {
  final String title;
  final String body;
  const _ClauseBox({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFBB700),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            body,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF374151),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// Small info card used for location tracking and verified ID
class _MiniInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;
  const _MiniInfoCard({required this.icon, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF6B7280)),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            body,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF9CA3AF),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// Expandable tile for community guidelines etc.
class _ExpandTile extends StatelessWidget {
  final String title;
  const _ExpandTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          const Icon(Icons.description_outlined, size: 18, color: Color(0xFF6B7280)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A2E),
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF), size: 20),
        ],
      ),
    );
  }
}