import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/responsive.dart';
import '../../../viewmodels/auth_viewmodel.dart';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  int _selectedTab = 0;
  final _searchController = TextEditingController();

  final List<Map<String, dynamic>> categories = [
    {'label': 'Electrician', 'count': '124 Pros', 'icon': Icons.bolt},
    {'label': 'Plumber', 'count': '89 Pros', 'icon': Icons.water_drop_outlined},
    {'label': 'Painter', 'count': '56 Pros', 'icon': Icons.brush_outlined},
    {'label': 'Carpenter', 'count': '72 Pros', 'icon': Icons.handyman_outlined},
  ];

  final List<Map<String, dynamic>> workers = [
    {'name': 'Ahmed Raza', 'title': 'Expert Electrician', 'rating': '4.9', 'reviews': '128', 'online': true},
    {'name': 'Sajid Khan', 'title': 'Master Plumber', 'rating': '4.8', 'reviews': '94', 'online': true},
    {'name': 'Bilal Malik', 'title': 'Fine Carpenter', 'rating': '4.7', 'reviews': '63', 'online': false},
    {'name': 'Zain Ali', 'title': 'Wall Painter', 'rating': '5', 'reviews': '42', 'online': true},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final vm = context.watch<AuthViewModel>();
    final String realUserName = vm.userName.isNotEmpty ? vm.userName : "User";

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar - Responsive padding
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.horizontalPadding(context),
                  vertical: Responsive.scaleHeight(context, 14)
              ),
              child: Row(
                children: [
                  Container(
                    width: Responsive.scaleWidth(context, 36),
                    height: Responsive.scaleWidth(context, 36),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A2E),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.bolt,
                        color: const Color(0xFFFBB700),
                        size: Responsive.scaleWidth(context, 20)),
                  ),
                  SizedBox(width: Responsive.scaleWidth(context, 10)),
                  Text(
                    'HUNARMAND',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 18),
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.settings_outlined,
                        color: const Color(0xFF6B7280),
                        size: Responsive.scaleWidth(context, 22)),
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(Responsive.scaleWidth(context, 20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- UPDATED GREETING WITH REAL NAME ---
                    Text(
                      'Hello, ${realUserName.split(' ').first}', // Pehla naam dikhayega (e.g. "Salman")
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 24),
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1A1A2E),
                      ),
                    ),
                    Text(
                      'Which service do you need today?',
                      style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          color: const Color(0xFF6B7280)),
                    ),
                    SizedBox(height: Responsive.scaleHeight(context, 16)),

                    // Search bar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              style: TextStyle(fontSize: Responsive.fontSize(context, 14)),
                              decoration: InputDecoration(
                                hintText: 'Search for electricians...',
                                hintStyle: TextStyle(
                                    fontSize: Responsive.fontSize(context, 14),
                                    color: const Color(0xFF9CA3AF)),
                                prefixIcon: Icon(Icons.search,
                                    color: const Color(0xFF9CA3AF),
                                    size: Responsive.scaleWidth(context, 22)),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: Responsive.scaleWidth(context, 36),
                            height: Responsive.scaleWidth(context, 36),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E3A8A),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.filter_alt_outlined, color: Colors.white, size: 18),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Responsive.scaleHeight(context, 24)),

                    // Categories Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Service Categories',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 18),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'View All',
                            style: TextStyle(
                              fontSize: Responsive.fontSize(context, 13),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E3A8A),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.scaleHeight(context, 14)),

                    // GridView
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: Responsive.isSmallScreen(context) ? 1.2 : 1.4,
                      ),
                      itemBuilder: (context, i) {
                        return _buildCategoryCard(categories[i]);
                      },
                    ),

                    SizedBox(height: Responsive.scaleHeight(context, 24)),

                    // Verified Workers Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Verified Workers',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 18),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1A1A2E),
                          ),
                        ),
                        Text(
                          'Near You >',
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 13),
                            color: const Color(0xFF1E3A8A),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.scaleHeight(context, 12)),

                    ...workers.map((w) => _WorkerTile(worker: w)),

                    SizedBox(height: Responsive.scaleHeight(context, 16)),
                    _buildPromoBanner(),
                    SizedBox(height: Responsive.scaleHeight(context, 16)),
                  ],
                ),
              ),
            ),

            // Bottom Nav
            _BottomNav(
              selected: _selectedTab,
              onTap: (i) => setState(() => _selectedTab = i),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Helpers remain same but using Responsive ---
  Widget _buildCategoryCard(Map<String, dynamic> cat) {
    return Container(
      padding: EdgeInsets.all(Responsive.scaleWidth(context, 12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(cat['icon'], color: const Color(0xFF1E3A8A), size: Responsive.scaleWidth(context, 24)),
          SizedBox(height: Responsive.scaleHeight(context, 8)),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(cat['label'],
                style: TextStyle(fontSize: Responsive.fontSize(context, 15), fontWeight: FontWeight.w700)),
          ),
          Text(cat['count'],
              style: TextStyle(fontSize: Responsive.fontSize(context, 11), color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.scaleWidth(context, 16)),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A8A),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('First Booking?',
                    style: TextStyle(fontSize: Responsive.fontSize(context, 16), fontWeight: FontWeight.bold, color: Colors.white)),
                Text('Get 20% off now.',
                    style: TextStyle(fontSize: Responsive.fontSize(context, 12), color: Colors.white70)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(color: const Color(0xFFFBB700), borderRadius: BorderRadius.circular(8)),
            child: Text('FIRST20',
                style: TextStyle(fontSize: Responsive.fontSize(context, 10), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _WorkerTile extends StatelessWidget {
  final Map<String, dynamic> worker;
  const _WorkerTile({required this.worker});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(Responsive.scaleWidth(context, 12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Responsive.scaleWidth(context, 24),
            backgroundColor: const Color(0xFFE5E7EB),
            child: const Icon(Icons.person, color: Colors.grey),
          ),
          SizedBox(width: Responsive.scaleWidth(context, 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(worker['name'],
                      style: TextStyle(fontSize: Responsive.fontSize(context, 15), fontWeight: FontWeight.bold)),
                ),
                Text(worker['title'],
                    style: TextStyle(fontSize: Responsive.fontSize(context, 12), color: Colors.grey)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E3A8A),
              padding: EdgeInsets.symmetric(horizontal: Responsive.scaleWidth(context, 12)),
            ),
            child: Text('Profile', style: TextStyle(fontSize: Responsive.fontSize(context, 12), color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final int selected;
  final Function(int) onTap;
  const _BottomNav({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Responsive.scaleHeight(context, 8)),
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(context, Icons.home, "Home", 0),
          _navItem(context, Icons.explore, "Explore", 1),
          _navItem(context, Icons.location_on, "Track", 2),
          _navItem(context, Icons.person, "Profile", 4),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, IconData icon, String label, int index) {
    bool active = selected == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: active ? const Color(0xFF1E3A8A) : Colors.grey, size: Responsive.scaleWidth(context, 22)),
          Text(label, style: TextStyle(fontSize: Responsive.fontSize(context, 10), color: active ? const Color(0xFF1E3A8A) : Colors.grey)),
        ],
      ),
    );
  }
}