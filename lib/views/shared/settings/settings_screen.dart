import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodels/auth_viewmodel.dart';

// Settings Screen - Screen 26 in design PDF
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotifs = true;
  int _selectedTab = 4;

  void _logout() {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(c);
              await context.read<AuthViewModel>().logout();
              if (mounted) Navigator.pushReplacementNamed(context, '/');
            },
            child: const Text('Log Out', style: TextStyle(color: Color(0xFFEF4444))),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E))),
                  Icon(Icons.warning_amber_rounded, color: Colors.red.shade400, size: 24),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Profile card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 28,
                                    backgroundColor: const Color(0xFFE5E7EB),
                                    child: Icon(Icons.person, size: 28, color: Colors.grey.shade500),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 16,
                                      height: 16,
                                      decoration: const BoxDecoration(color: Color(0xFF22C55E), shape: BoxShape.circle),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 14),
                              const Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('Arshad Khan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))),
                                        SizedBox(width: 6),
                                        Icon(Icons.check_circle, size: 16, color: Color(0xFFFBB700)),
                                      ],
                                    ),
                                    Text('Master Electrician • Islamabad', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                                    Text('⭐ 4.9  •  124 Jobs Done', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          const Divider(color: Color(0xFFE5E7EB)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(Icons.person_outline, size: 16),
                                  label: const Text('Edit Profile'),
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Color(0xFFE5E7EB)),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFBEB),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: const Color(0xFFFDE68A)),
                                ),
                                child: const Text('PRO', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFFFBB700))),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Account & Security section
                    _sectionLabel('ACCOUNT & SECURITY'),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          _settingsTile(Icons.lock_outline, 'Change Password', 'Last updated 45 days ago', () {}),
                          const Divider(height: 1, indent: 56, color: Color(0xFFE5E7EB)),
                          _settingsTile(Icons.credit_card_outlined, 'Withdrawal Accounts', 'JazzCash: 0300****123', () {}),
                          const Divider(height: 1, indent: 56, color: Color(0xFFE5E7EB)),
                          _settingsTileWithBadge(Icons.shield_outlined, 'Two-Factor Auth', 'Enhanced security enabled', 'ACTIVE'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Preferences
                    _sectionLabel('PREFERENCES'),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          // Push notifications with toggle
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(Icons.notifications_outlined, color: Color(0xFF1E3A8A), size: 20),
                                ),
                                const SizedBox(width: 14),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Push Notifications', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
                                      Text('Job alerts and payment updates', style: TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                                    ],
                                  ),
                                ),
                                Switch(value: _pushNotifs, onChanged: (v) => setState(() => _pushNotifs = v), activeColor: const Color(0xFF1E3A8A)),
                              ],
                            ),
                          ),
                          const Divider(height: 1, indent: 56, color: Color(0xFFE5E7EB)),
                          _settingsTile(Icons.translate_outlined, 'Language / زبان', 'Current: English (Urdu available)', () => Navigator.pushNamed(context, '/language')),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Support & Info
                    _sectionLabel('SUPPORT & INFO'),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          _settingsTile(Icons.help_outline, 'Help & FAQ', 'Safety tips and payment guides', () => Navigator.pushNamed(context, '/help')),
                          const Divider(height: 1, indent: 56, color: Color(0xFFE5E7EB)),
                          _settingsTile(Icons.description_outlined, 'Terms & Privacy', '', () => Navigator.pushNamed(context, '/terms')),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Logout button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _logout,
                        icon: const Icon(Icons.logout, color: Color(0xFFEF4444), size: 18),
                        label: const Text('Log Out', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFFEF4444))),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFFEE2E2)),
                          backgroundColor: const Color(0xFFFFF5F5),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    const Text('WorkerApp v2.4.1 (Islamabad Node)', style: TextStyle(fontSize: 11, color: Color(0xFFD1D5DB))),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _buildNav(),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontSize: 11, letterSpacing: 1.2, fontWeight: FontWeight.w600, color: Color(0xFF9CA3AF))),
    );
  }

  Widget _settingsTile(IconData icon, String title, String sub, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
                  if (sub.isNotEmpty) Text(sub, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _settingsTileWithBadge(IconData icon, String title, String sub, String badge) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
                Text(sub, style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280))),
              ],
            ),
          ),
          Text(badge, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF374151), letterSpacing: 0.5)),
        ],
      ),
    );
  }

  Widget _buildNav() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.account_balance_wallet_outlined, 'label': 'Wallet'},
      {'icon': Icons.bar_chart_outlined, 'label': 'Analytics'},
      {'icon': Icons.notifications_outlined, 'label': 'Alerts'},
      {'icon': Icons.settings_outlined, 'label': 'Settings'},
    ];
    return Container(
      color: Colors.white,
      child: Row(
        children: List.generate(items.length, (i) {
          bool active = i == _selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedTab = i);
                if (i == 0) Navigator.pushReplacementNamed(context, '/worker_home');
                if (i == 1) Navigator.pushNamed(context, '/wallet');
                if (i == 3) Navigator.pushNamed(context, '/notifications');
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