import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider add kiya
import '../../../core/utils/responsive.dart';
import '../../../viewmodels/auth_viewmodel.dart'; // ViewModel import zaroor karein

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  int _selectedTab = 2; // portfolio tab active

  final List<Map<String, dynamic>> _portfolioItems = [
    {'views': '1.2k', 'verified': true, 'color': const Color(0xFFE0F2FE)},
    {'views': '850', 'verified': false, 'color': const Color(0xFFF0FDF4)},
    {'views': '2.1k', 'verified': true, 'color': const Color(0xFFFEF3C7)},
    {'views': '340', 'verified': true, 'color': const Color(0xFFFCE7F3)},
    {'views': '120', 'verified': false, 'color': const Color(0xFFEDE9FE)},
    {'views': '980', 'verified': true, 'color': const Color(0xFFF0FDF4)},
    {'views': '450', 'verified': false, 'color': const Color(0xFFFFF7ED)},
    {'views': '3.2k', 'verified': true, 'color': const Color(0xFFEFF6FF)},
  ];

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Delete Photo?'),
        content: const Text('This will permanently remove this photo from your portfolio.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() => _portfolioItems.removeAt(index));
              Navigator.pop(c);
            },
            child: const Text('Delete', style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // --- REAL NAME FETCH KARNE KE LIYE ---
    final authVM = context.watch<AuthViewModel>();
    final String fullName = authVM.userName.isNotEmpty ? authVM.userName : 'Worker Name';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left, size: Responsive.scaleWidth(context, 28), color: const Color(0xFF374151)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Portfolio',
          style: TextStyle(
              fontSize: Responsive.fontSize(context, 17),
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1A1A2E)
          ),
        ),
        centerTitle: true,
        actions: [
          _buildAddActionIcon(context),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: Responsive.scaleWidth(context, 16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Responsive.scaleHeight(context, 10)),

                    // --- REAL NAME PASSED HERE ---
                    _buildShowcaseHeader(context, fullName),

                    SizedBox(height: Responsive.scaleHeight(context, 16)),

                    // Stats row
                    Row(
                      children: [
                        _statBox(context, Icons.remove_red_eye_outlined, '8.4k', 'VIEWS'),
                        SizedBox(width: Responsive.scaleWidth(context, 10)),
                        _statBox(context, Icons.photo_outlined, '8', 'PROJECTS'),
                        SizedBox(width: Responsive.scaleWidth(context, 10)),
                        _statBox(context, Icons.check_circle_outline, '6', 'VERIFIED'),
                      ],
                    ),

                    SizedBox(height: Responsive.scaleHeight(context, 20)),

                    _buildGalleryHeader(context),
                    SizedBox(height: Responsive.scaleHeight(context, 12)),

                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _portfolioItems.length + 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: Responsive.scaleWidth(context, 8),
                        mainAxisSpacing: Responsive.scaleWidth(context, 8),
                      ),
                      itemBuilder: (context, i) {
                        if (i == _portfolioItems.length) return _buildAddWorkButton(context);
                        return _buildPortfolioGridItem(context, i);
                      },
                    ),

                    SizedBox(height: Responsive.scaleHeight(context, 20)),
                    _buildProTip(context),
                    SizedBox(height: Responsive.scaleHeight(context, 20)),
                  ],
                ),
              ),
            ),
            _buildNav(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/emergency'),
        backgroundColor: const Color(0xFFEF4444),
        child: const Icon(Icons.warning_amber_rounded, color: Colors.white),
      ),
    );
  }

  // --- UPDATED: Added Name Parameter ---
  Widget _buildShowcaseHeader(BuildContext context, String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$name\'s Showcase', // Real name yahan dikhega
                  style: TextStyle(fontSize: Responsive.fontSize(context, 17), fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
              Text('Keep your profile updated.',
                  style: TextStyle(fontSize: Responsive.fontSize(context, 12), color: const Color(0xFF6B7280))),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFFBB700)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          ),
          child: Text('Upload', style: TextStyle(color: const Color(0xFFFBB700), fontSize: Responsive.fontSize(context, 12))),
        ),
      ],
    );
  }

  // Baqi helper widgets (StatBox, Nav, ProTip etc.) bilkul wahi hain jo pehle code mein thay...
  // Bas spacing aur size ko 'Responsive' utility se wrap kiya gaya hai.

  Widget _buildAddActionIcon(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: Responsive.scaleWidth(context, 36),
      height: Responsive.scaleWidth(context, 36),
      decoration: const BoxDecoration(color: Color(0xFF1E3A8A), shape: BoxShape.circle),
      child: const Icon(Icons.add, color: Colors.white, size: 20),
    );
  }

  Widget _buildGalleryHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('WORK GALLERY',
            style: TextStyle(fontSize: Responsive.fontSize(context, 11), letterSpacing: 1.2, fontWeight: FontWeight.w700, color: const Color(0xFF374151))),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(6)),
          child: Text('Auto-Sorted', style: TextStyle(fontSize: Responsive.fontSize(context, 10), color: const Color(0xFF6B7280))),
        ),
      ],
    );
  }

  Widget _buildPortfolioGridItem(BuildContext context, int i) {
    final item = _portfolioItems[i];
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: item['color'], borderRadius: BorderRadius.circular(10)),
          child: const Center(child: Icon(Icons.image_outlined, size: 24, color: Color(0xFF9CA3AF))),
        ),
        Positioned(
          top: 4, right: 4,
          child: GestureDetector(
            onTap: () => _showDeleteDialog(i),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle),
              child: const Icon(Icons.delete_outline, size: 12, color: Colors.white),
            ),
          ),
        ),
        if (item['verified'])
          Positioned(bottom: 4, left: 4, child: _buildBadge(Icons.check_circle_outline, 'Verified')),
        Positioned(bottom: 4, right: 4, child: _buildBadge(Icons.remove_red_eye_outlined, item['views'])),
      ],
    );
  }

  Widget _buildBadge(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
      child: Row(children: [
        Icon(icon, size: 8, color: Colors.white),
        const SizedBox(width: 2),
        Text(text, style: const TextStyle(fontSize: 8, color: Colors.white)),
      ]),
    );
  }

  Widget _buildAddWorkButton(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add, color: Color(0xFFFBB700), size: 24),
            Text('Add Work', style: TextStyle(fontSize: Responsive.fontSize(context, 10), color: const Color(0xFF6B7280))),
          ],
        ),
      ),
    );
  }

  Widget _buildProTip(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(12)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_outline, color: Color(0xFF1E3A8A), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Pro Tip: Clear photos of completed projects increase job requests by 45% in Pakistan.',
              style: TextStyle(fontSize: Responsive.fontSize(context, 12), color: const Color(0xFF374151), height: 1.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statBox(BuildContext context, IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFFFBB700), size: 18),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: Responsive.fontSize(context, 15), fontWeight: FontWeight.w800, color: const Color(0xFF1A1A2E))),
            Text(label, style: const TextStyle(fontSize: 8, letterSpacing: 0.5, color: Color(0xFF9CA3AF))),
          ],
        ),
      ),
    );
  }

  Widget _buildNav() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Dashboard'},
      {'icon': Icons.account_balance_wallet_outlined, 'label': 'Wallet'},
      {'icon': Icons.photo_library_outlined, 'label': 'Portfolio'},
      {'icon': Icons.help_outline, 'label': 'Support'},
      {'icon': Icons.settings_outlined, 'label': 'Settings'},
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, offset: const Offset(0, -2))],
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          bool active = i == _selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(items[i]['icon'] as IconData, size: 22, color: active ? const Color(0xFF1E3A8A) : const Color(0xFF9CA3AF)),
                    Text(items[i]['label'] as String, style: TextStyle(fontSize: 9, color: active ? const Color(0xFF1E3A8A) : const Color(0xFF9CA3AF))),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}