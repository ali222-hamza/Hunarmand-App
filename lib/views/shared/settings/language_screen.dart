import 'package:flutter/material.dart';

// Language Settings Screen - Screen 27
class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLang = 'English';

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
        title: const Text('Language Settings', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
        centerTitle: true,
        actions: [
          Icon(Icons.warning_amber_rounded, color: Colors.red.shade400),
          const SizedBox(width: 12),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Choose your language', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E))),
              const SizedBox(height: 8),
              const Text(
                'Select the language you prefer for the interface, notifications, and customer support.',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.5),
              ),
              const SizedBox(height: 28),

              // English option
              _langOption(
                icon: Icons.language,
                iconBg: const Color(0xFF1E3A8A),
                title: 'English',
                subtitle: 'English — Standard Business English',
                lang: 'English',
              ),
              const SizedBox(height: 12),

              // Urdu option
              _langOption(
                icon: Icons.text_fields,
                iconBg: const Color(0xFFF3F4F6),
                title: 'اردو',
                subtitle: 'Urdu — Nastaliq Script & Roman',
                lang: 'Urdu',
                badge: 'POPULAR',
              ),

              const SizedBox(height: 20),

              // Info box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.info_outline, size: 18, color: Color(0xFF6B7280)),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Interface Update', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
                          SizedBox(height: 4),
                          Text('The app will automatically update all menus, job requests, and support chat to your selected language.', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.4)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Language set to $_selectedLang')));
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Continue  >', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text('YOU CAN CHANGE THIS ANYTIME IN SETTINGS', style: TextStyle(fontSize: 10, letterSpacing: 1.2, color: Color(0xFF9CA3AF))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _langOption({required IconData icon, required Color iconBg, required String title, required String subtitle, required String lang, String? badge}) {
    bool active = _selectedLang == lang;
    return GestureDetector(
      onTap: () => setState(() => _selectedLang = lang),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFEFF6FF) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: active ? const Color(0xFF1E3A8A) : const Color(0xFFE5E7EB), width: active ? 2 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
              child: Icon(icon, color: active ? Colors.white : const Color(0xFF374151), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(color: const Color(0xFFFFFBEB), borderRadius: BorderRadius.circular(4), border: Border.all(color: const Color(0xFFFBB700))),
                          child: Text(badge, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: Color(0xFFFBB700))),
                        ),
                      ],
                    ],
                  ),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: active ? const Color(0xFF1E3A8A) : const Color(0xFFD1D5DB), width: 2),
                color: active ? const Color(0xFF1E3A8A) : Colors.transparent,
              ),
              child: active ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
            ),
          ],
        ),
      ),
    );
  }
}