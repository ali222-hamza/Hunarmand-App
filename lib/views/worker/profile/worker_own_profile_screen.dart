import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider add kiya
import '../../../core/utils/responsive.dart';
import '../../../viewmodels/auth_viewmodel.dart'; // ViewModel import karein

class WorkerOwnProfileScreen extends StatelessWidget {
  const WorkerOwnProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // --- REAL NAME FETCH KARNE KE LIYE ---
    final authVM = context.watch<AuthViewModel>();
    final String fullName = authVM.userName.isNotEmpty ? authVM.userName : 'Worker Name';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Blue header
                    Container(
                      width: double.infinity,
                      color: const Color(0xFF1E3A8A),
                      padding: EdgeInsets.fromLTRB(
                          Responsive.horizontalPadding(context),
                          Responsive.scaleHeight(context, 16),
                          Responsive.horizontalPadding(context),
                          Responsive.scaleHeight(context, 28)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Icon(Icons.chevron_left,
                                    color: Colors.white,
                                    size: Responsive.scaleWidth(context, 28)),
                                onPressed: () => Navigator.pop(context),
                              ),
                              Container(
                                width: Responsive.scaleWidth(context, 36),
                                height: Responsive.scaleWidth(context, 36),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.warning_amber_rounded,
                                    color: Colors.white, size: 20),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.scaleHeight(context, 8)),

                          // Profile Image
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              CircleAvatar(
                                radius: Responsive.scaleWidth(context, 48),
                                backgroundColor: Colors.white,
                                child: Icon(Icons.person,
                                    size: Responsive.scaleWidth(context, 48),
                                    color: Colors.grey.shade400),
                              ),
                              Container(
                                width: Responsive.scaleWidth(context, 26),
                                height: Responsive.scaleWidth(context, 26),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFBB700),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.verified_user,
                                    size: 14, color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.scaleHeight(context, 12)),

                          // --- REAL NAME SHOWING HERE ---
                          Text(
                            fullName, // Arshad Khan ki jagah enter kiya hua name
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: Responsive.fontSize(context, 22),
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          ),

                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on_outlined,
                                  size: 14, color: Colors.white60),
                              const SizedBox(width: 4),
                              Text('Gulberg III, Lahore',
                                  style: TextStyle(
                                      fontSize: Responsive.fontSize(context, 13),
                                      color: Colors.white60)),
                            ],
                          ),
                          SizedBox(height: Responsive.scaleHeight(context, 16)),

                          // Stats bar
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Responsive.scaleHeight(context, 14)),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _ProfileStat(context, value: '4.9', label: 'RATING'),
                                Container(height: 30, width: 1, color: Colors.white30),
                                _ProfileStat(context, value: '154', label: 'JOBS DONE'),
                                Container(height: 30, width: 1, color: Colors.white30),
                                _ProfileStat(context, value: '6 yrs', label: 'EXPERIENCE'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Message / Hire buttons
                    Padding(
                      padding: EdgeInsets.all(Responsive.scaleWidth(context, 16)),
                      child: Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => Navigator.pushNamed(context, '/chat'),
                              icon: const Icon(Icons.chat_bubble_outline,
                                  size: 16, color: Color(0xFF1A1A2E)),
                              label: FittedBox(
                                child: Text('Message',
                                    style: TextStyle(
                                        fontSize: Responsive.fontSize(context, 14),
                                        color: const Color(0xFF1A1A2E),
                                        fontWeight: FontWeight.w700)),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFBB700),
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                    vertical: Responsive.scaleHeight(context, 14)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, '/booking'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1E3A8A),
                                elevation: 0,
                                padding: EdgeInsets.symmetric(
                                    vertical: Responsive.scaleHeight(context, 14)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: FittedBox(
                                child: Text('Hire Now',
                                    style: TextStyle(
                                        fontSize: Responsive.fontSize(context, 14),
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // About section
                    _section(
                      context: context,
                      icon: Icons.business_center_outlined,
                      title: 'About Specialist',
                      child: Text(
                        'Certified Master Electrician with over 6 years of experience in residential and commercial wiring.',
                        style: TextStyle(
                            fontSize: Responsive.fontSize(context, 13),
                            color: const Color(0xFF374151),
                            height: 1.5),
                      ),
                    ),

                    // Skills section
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.scaleWidth(context, 16)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Specialized Skills',
                              style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 16),
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1A1A2E))),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              'Home Wiring',
                              'Smart CCTV',
                              'AC Repair',
                              'Solar',
                              'Panel Upgrade'
                            ].map((s) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: const Color(0xFFE5E7EB)),
                                ),
                                child: Text(s,
                                    style: TextStyle(
                                        fontSize: Responsive.fontSize(context, 12),
                                        color: const Color(0xFF374151))),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Responsive.scaleHeight(context, 20)),

                    // Recent projects
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.scaleWidth(context, 16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Recent Projects',
                              style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 16),
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1A1A2E))),
                          const Icon(Icons.chevron_right, size: 16, color: Color(0xFF1E3A8A)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: Responsive.scaleHeight(context, 100),
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: Responsive.scaleWidth(context, 16)),
                        scrollDirection: Axis.horizontal,
                        children: [
                          _projectCard(context, 'SOLAR ARRAY', const Color(0xFF0F172A)),
                          const SizedBox(width: 10),
                          _projectCard(context, 'SMART PANEL', const Color(0xFF1E3A8A)),
                        ],
                      ),
                    ),

                    SizedBox(height: Responsive.scaleHeight(context, 20)),

                    // Verification card
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.scaleWidth(context, 16)),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBEB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFFDE68A)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.workspace_premium_outlined,
                                    color: Color(0xFFFBB700), size: 24),
                                const SizedBox(width: 10),
                                Text('Verified Pro',
                                    style: TextStyle(
                                        fontSize: Responsive.fontSize(context, 15),
                                        fontWeight: FontWeight.bold)),
                                const Spacer(),
                                _tierBadge(context),
                              ],
                            ),
                            const SizedBox(height: 12),
                            GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              childAspectRatio: 4,
                              children: const [
                                _VerifyItem(label: 'CNIC Verified'),
                                _VerifyItem(label: 'Security Check'),
                                _VerifyItem(label: 'Skill Tested'),
                                _VerifyItem(label: 'Insurance'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            _buildNav(context),
          ],
        ),
      ),
    );
  }

  // --- Helper Methods (Stay same as original) ---

  Widget _section({required BuildContext context, required IconData icon, required String title, required Widget child}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, Responsive.scaleHeight(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: const Color(0xFF1E3A8A)),
              const SizedBox(width: 8),
              Text(title, style: TextStyle(fontSize: Responsive.fontSize(context, 16), fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _projectCard(BuildContext context, String label, Color bg) {
    return Container(
      width: Responsive.scaleWidth(context, 160),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Text(label, style: TextStyle(fontSize: Responsive.fontSize(context, 11), fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _tierBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFF1E3A8A), borderRadius: BorderRadius.circular(6)),
      child: Text('GOLD TIER', style: TextStyle(fontSize: Responsive.fontSize(context, 9), color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildNav(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Responsive.scaleHeight(context, 10)),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Color(0xFFE5E7EB)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.home_outlined, size: Responsive.scaleWidth(context, 22), color: Colors.grey),
          Icon(Icons.wallet_outlined, size: Responsive.scaleWidth(context, 22), color: Colors.grey),
          Icon(Icons.settings_outlined, size: Responsive.scaleWidth(context, 22), color: Colors.grey),
        ],
      ),
    );
  }

  Widget _ProfileStat(BuildContext context, {required String value, required String label}) {
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: Responsive.fontSize(context, 18), fontWeight: FontWeight.w800, color: Colors.white)),
        Text(label, style: TextStyle(fontSize: Responsive.fontSize(context, 9), color: Colors.white60)),
      ],
    );
  }
}

class _VerifyItem extends StatelessWidget {
  final String label;
  const _VerifyItem({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle, size: 14, color: Color(0xFF1E3A8A)),
        const SizedBox(width: 4),
        Flexible(child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF1E3A8A)))),
      ],
    );
  }
}