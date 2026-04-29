import 'package:flutter/material.dart';

// Help & Support Screen - Screen 28
class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});
  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  String _searchText = '';
  String _selectedFilter = 'All';
  int? _expandedIndex;

  final List<String> _filters = ['All', 'Payments', 'Safety', 'Account'];

  final List<Map<String, String>> _faqs = [
    {'q': 'How do I withdraw earnings to JazzCash?', 'a': 'Go to the Wallet screen, select "Withdraw", choose JazzCash as your provider, and enter your mobile number. Funds usually arrive within 2 hours.'},
    {'q': 'What if a client is being disrespectful?', 'a': 'Use the SOS button immediately and contact our support team. All workers are protected under our community guidelines. You can also cancel the job without penalty in such cases.'},
    {'q': 'Is there a limit on daily withdrawals?', 'a': 'Yes, the daily withdrawal limit is PKR 50,000 for JazzCash and PKR 25,000 for EasyPaisa. Contact support to increase your limits after account verification.'},
    {'q': 'How to update my verified phone number?', 'a': 'Go to Settings > Account & Security > Change Phone. You will need to verify your CNIC again for security purposes.'},
    {'q': 'Emergency contacts in Pakistan?', 'a': 'Police: 15 | Rescue: 1122 | Worker Support: 0800-SAFE-WORK | Our 24/7 helpline: +92 300 1234567'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28, color: Color(0xFF374151)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Help & Support', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
        centerTitle: true,
        actions: [Icon(Icons.warning_amber_rounded, color: Colors.red.shade400), const SizedBox(width: 12)],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
              Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xFFE5E7EB))),
                child: TextField(
                  onChanged: (v) => setState(() => _searchText = v),
                  decoration: const InputDecoration(
                    hintText: 'Search help topics...',
                    hintStyle: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
                    prefixIcon: Icon(Icons.search, color: Color(0xFF9CA3AF), size: 20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Filter chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _filters.map((f) {
                    bool active = f == _selectedFilter;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedFilter = f),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: active ? const Color(0xFF1E3A8A) : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: active ? const Color(0xFF1E3A8A) : const Color(0xFFE5E7EB)),
                        ),
                        child: Text(f, style: TextStyle(fontSize: 13, color: active ? Colors.white : const Color(0xFF6B7280), fontWeight: active ? FontWeight.w700 : FontWeight.w400)),
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 20),

              // FAQs
              const Row(
                children: [
                  Icon(Icons.help_outline, size: 18, color: Color(0xFF1E3A8A)),
                  SizedBox(width: 8),
                  Text('Frequently Asked Questions', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
                ],
              ),
              const SizedBox(height: 12),

              ..._faqs.asMap().entries.map((e) {
                int i = e.key;
                Map<String, String> faq = e.value;
                bool expanded = _expandedIndex == i;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE5E7EB))),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => setState(() => _expandedIndex = expanded ? null : i),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              Expanded(child: Text(faq['q']!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E)))),
                              Icon(expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: const Color(0xFF6B7280)),
                            ],
                          ),
                        ),
                      ),
                      if (expanded)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                          child: Text(faq['a']!, style: const TextStyle(fontSize: 13, color: Color(0xFF374151), height: 1.5)),
                        ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 20),

              // Still need help
              const Text('Still Need Help?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _helpOption(Icons.chat_bubble_outline, 'Live Chat', 'Response in 5m', () {})),
                  const SizedBox(width: 12),
                  Expanded(child: _helpOption(Icons.phone_outlined, 'Call Support', '24/7 Helpline', () {})),
                ],
              ),

              const SizedBox(height: 12),

              GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/terms'),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE5E7EB))),
                  child: const Row(
                    children: [
                      Icon(Icons.shield_outlined, color: Color(0xFF1E3A8A), size: 20),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Privacy & Terms', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
                          Text('Legal documentation', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                        ],
                      ),
                      Spacer(),
                      Icon(Icons.open_in_new, color: Color(0xFF9CA3AF), size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(10)),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.shield_outlined, color: Color(0xFFFBB700), size: 18),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Security Reminder', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
                          SizedBox(height: 4),
                          Text('Our team will never ask for your password or JazzCash/EasyPaisa PIN. Never share OTPs with anyone claiming to be from support.', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _helpOption(IconData icon, String title, String sub, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE5E7EB))),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: const Color(0xFF1E3A8A), size: 22),
            ),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
            Text(sub, style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
          ],
        ),
      ),
    );
  }
}

// Terms & Privacy Screen - Screen 29
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
        title: const Text('Terms & Privacy', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
        centerTitle: true,
        actions: [Icon(Icons.warning_amber_rounded, color: Colors.red.shade400), const SizedBox(width: 12)],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Version badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(6), border: Border.all(color: const Color(0xFFFDE68A))),
                          child: const Text('v2.4.0', style: TextStyle(fontSize: 11, color: Color(0xFFFBB700), fontWeight: FontWeight.w700)),
                        ),
                        const Text('Effective: Oct 24, 2023', style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text('Legal Compliance &\nUser Agreement', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF1E3A8A), height: 1.2)),
                    const SizedBox(height: 8),
                    const Text('Please read these terms carefully before using the Worker Management platform. Your continued use indicates your acceptance.', style: TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.5)),

                    const SizedBox(height: 20),
                    _sectionTitle(Icons.balance, 'Terms of Service'),
                    const SizedBox(height: 10),
                    const Text('These terms govern your access to and use of our services, including our mobile applications and websites in Pakistan.', style: TextStyle(fontSize: 13, color: Color(0xFF374151), height: 1.5)),
                    const SizedBox(height: 12),
                    _clause('CLAUSE 1.1: ELIGIBILITY', 'You must be at least 18 years of age and possess a valid CNIC to register as a service provider on this platform.'),
                    const SizedBox(height: 8),
                    _clause('CLAUSE 2.4: SERVICE FEES', 'Our platform reserves the right to deduct a standard 5% administrative fee from all successful job completions.'),
                    const SizedBox(height: 8),
                    _clause('CLAUSE 3.0: CONDUCT', 'Workers are expected to maintain professional standards and adhere to the scheduled timings provided by the client.'),

                    const SizedBox(height: 20),
                    _sectionTitle(Icons.lock_outline, 'Privacy Policy'),
                    const SizedBox(height: 10),
                    const Text('We take your privacy seriously. This section outlines how we collect, use, and protect your personal data and wallet information.', style: TextStyle(fontSize: 13, color: Color(0xFF374151), height: 1.5)),
                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10)),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.verified_user_outlined, size: 16, color: Color(0xFF1E3A8A)),
                              SizedBox(width: 6),
                              Text('Data Protection', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1E3A8A))),
                            ],
                          ),
                          SizedBox(height: 6),
                          Text('All personal data, including JazzCash/EasyPaisa credentials, are encrypted using industry-standard AES-256 protocols.', style: TextStyle(fontSize: 12, color: Color(0xFF374151))),
                        ],
                      ),
                    ),

                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(child: _miniCard(Icons.location_on_outlined, 'Location Tracking', 'Used only for active job navigation and safety.')),
                        const SizedBox(width: 10),
                        Expanded(child: _miniCard(Icons.person_outline, 'Verified ID', 'Biometric data is processed for account security.')),
                      ],
                    ),

                    const SizedBox(height: 16),
                    _expandableTile('Community Guidelines'),
                    const SizedBox(height: 8),
                    _expandableTile('Safety Protocols (Urdu)'),
                    const SizedBox(height: 20),

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
                            child: Text('I acknowledge that I have read and agree to the Terms of Service and Privacy Policy.', style: TextStyle(fontSize: 13, color: Color(0xFF374151), height: 1.4)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
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
                  child: const Text('Continue to Dashboard', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12),
              child: Text('Last updated October 2023. © 2023 Worker Management Pakistan.', style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF))),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
      ],
    );
  }

  Widget _clause(String title, String body) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 10, letterSpacing: 1, fontWeight: FontWeight.w700, color: Color(0xFFFBB700))),
          const SizedBox(height: 4),
          Text(body, style: const TextStyle(fontSize: 12, color: Color(0xFF374151), height: 1.4)),
        ],
      ),
    );
  }

  Widget _miniCard(IconData icon, String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: const Color(0xFF6B7280)),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
          Text(sub, style: const TextStyle(fontSize: 10, color: Color(0xFF9CA3AF), height: 1.3)),
        ],
      ),
    );
  }

  Widget _expandableTile(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Row(
        children: [
          const Icon(Icons.description_outlined, size: 18, color: Color(0xFF6B7280)),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E)))),
          const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF), size: 20),
        ],
      ),
    );
  }
}