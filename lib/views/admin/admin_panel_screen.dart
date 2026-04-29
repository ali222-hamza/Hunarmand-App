import 'package:flutter/material.dart';
import '../../../data/local/database_helper.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/booking_model.dart';
// Apni responsive file ka path yahan zaroor check kar lein
import '../../../core/utils/responsive.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int _selectedTab = 0; // 0=dashboard, 1=users, 2=bookings
  final DatabaseHelper _db = DatabaseHelper.instance;

  List<UserModel> _users = [];
  List<BookingModel> _bookings = [];
  bool _loading = true;

  // quick summary stats
  int _totalWorkers = 0;
  int _totalCustomers = 0;
  int _totalBookings = 0;
  int _pendingBookings = 0;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    if (!mounted) return;
    setState(() => _loading = true);

    _users = await _db.getAllUsers();
    _bookings = await _db.getAllBookings();

    _totalWorkers = _users.where((u) => u.role == 'worker').length;
    _totalCustomers = _users.where((u) => u.role == 'customer').length;
    _totalBookings = _bookings.length;
    _pendingBookings = _bookings.where((b) => b.status == 'pending').length;

    if (!mounted) return;
    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Admin top bar - Responsive
            Container(
              color: const Color(0xFF1E3A8A),
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.horizontalPadding(context),
                  vertical: Responsive.scaleHeight(context, 14)),
              child: Row(
                children: [
                  Icon(Icons.admin_panel_settings_outlined,
                      color: const Color(0xFFFBB700),
                      size: Responsive.scaleWidth(context, 26)),
                  SizedBox(width: Responsive.scaleWidth(context, 10)),
                  Text(
                    'HUNARMAND Admin',
                    style: TextStyle(
                        fontSize: Responsive.fontSize(context, 18),
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _loadData,
                    child: Icon(Icons.refresh,
                        color: Colors.white,
                        size: Responsive.scaleWidth(context, 22)),
                  ),
                ],
              ),
            ),

            // Tab bar - Responsive
            Container(
              color: const Color(0xFF1E3A8A),
              child: Row(
                children: [
                  _adminTab('Dashboard', 0, Icons.dashboard_outlined),
                  _adminTab('Users', 1, Icons.people_outline),
                  _adminTab('Bookings', 2, Icons.book_outlined),
                ],
              ),
            ),

            // Body
            Expanded(
              child: _loading
                  ? const Center(
                  child: CircularProgressIndicator(
                      color: Color(0xFF1E3A8A)))
                  : _buildTabContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _adminTab(String label, int index, IconData icon) {
    bool active = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: Responsive.scaleHeight(context, 12)),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: active ? const Color(0xFFFBB700) : Colors.transparent,
                width: 3,
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon,
                  size: Responsive.scaleWidth(context, 18),
                  color: active ? const Color(0xFFFBB700) : Colors.white60),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  fontSize: Responsive.fontSize(context, 11),
                  color: active ? const Color(0xFFFBB700) : Colors.white60,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    if (_selectedTab == 0) return _dashboardTab();
    if (_selectedTab == 1) return _usersTab();
    return _bookingsTab();
  }

  Widget _dashboardTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(Responsive.scaleWidth(context, 16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(
                fontSize: Responsive.fontSize(context, 18),
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1A1A2E)),
          ),
          SizedBox(height: Responsive.scaleHeight(context, 14)),

          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: Responsive.isSmallScreen(context) ? 1.1 : 1.4,
            children: [
              _statCard('Total Workers', '$_totalWorkers',
                  Icons.handyman_outlined, const Color(0xFF1E3A8A)),
              _statCard('Total Customers', '$_totalCustomers',
                  Icons.people_outline, const Color(0xFF059669)),
              _statCard('Total Bookings', '$_totalBookings',
                  Icons.book_outlined, const Color(0xFF7C3AED)),
              _statCard('Pending', '$_pendingBookings',
                  Icons.pending_outlined, const Color(0xFFFBB700)),
            ],
          ),

          SizedBox(height: Responsive.scaleHeight(context, 20)),

          Text(
            'Quick Actions',
            style: TextStyle(
                fontSize: Responsive.fontSize(context, 16),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E)),
          ),
          SizedBox(height: Responsive.scaleHeight(context, 12)),

          _actionTile(
            Icons.person_add_outlined,
            'View All Users',
            '${_users.length} registered users',
                () => setState(() => _selectedTab = 1),
          ),
          SizedBox(height: Responsive.scaleHeight(context, 8)),
          _actionTile(
            Icons.list_alt_outlined,
            'View All Bookings',
            '${_bookings.length} total bookings',
                () => setState(() => _selectedTab = 2),
          ),
          SizedBox(height: Responsive.scaleHeight(context, 8)),
          _actionTile(
            Icons.bar_chart_outlined,
            'Platform Stats',
            'Workers, jobs, earnings overview',
                () {},
          ),
          SizedBox(height: Responsive.scaleHeight(context, 8)),
          _actionTile(
            Icons.verified_user_outlined,
            'Verify Workers',
            'Review CNIC verification requests',
                () {},
          ),
        ],
      ),
    );
  }

  Widget _usersTab() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(Responsive.scaleWidth(context, 12)),
          child: Row(
            children: [
              Icon(Icons.people_outline,
                  size: Responsive.scaleWidth(context, 16), color: const Color(0xFF6B7280)),
              const SizedBox(width: 6),
              Text(
                '${_users.length} total users in database',
                style: TextStyle(
                    fontSize: Responsive.fontSize(context, 13), color: const Color(0xFF6B7280)),
              ),
              const Spacer(),
              Icon(Icons.filter_list,
                  size: Responsive.scaleWidth(context, 18), color: const Color(0xFF1E3A8A)),
            ],
          ),
        ),
        Expanded(
          child: _users.isEmpty
              ? _emptyState(Icons.people_outline, 'No users found')
              : ListView.builder(
            padding: EdgeInsets.all(Responsive.scaleWidth(context, 12)),
            itemCount: _users.length,
            itemBuilder: (context, i) {
              final user = _users[i];
              return _userCard(user);
            },
          ),
        ),
      ],
    );
  }

  Widget _bookingsTab() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: EdgeInsets.all(Responsive.scaleWidth(context, 12)),
          child: Row(
            children: [
              Icon(Icons.book_outlined,
                  size: Responsive.scaleWidth(context, 16), color: const Color(0xFF6B7280)),
              const SizedBox(width: 6),
              Text(
                '${_bookings.length} total bookings in database',
                style: TextStyle(
                    fontSize: Responsive.fontSize(context, 13), color: const Color(0xFF6B7280)),
              ),
            ],
          ),
        ),
        Expanded(
          child: _bookings.isEmpty
              ? _emptyState(Icons.book_outlined, 'No bookings found')
              : ListView.builder(
            padding: EdgeInsets.all(Responsive.scaleWidth(context, 12)),
            itemCount: _bookings.length,
            itemBuilder: (context, i) {
              final b = _bookings[i];
              return _bookingCard(b);
            },
          ),
        ),
      ],
    );
  }

  // --- Sub-widgets with FIXED Responsive Logic ---

  Widget _statCard(String title, String value, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(Responsive.scaleWidth(context, 12)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: Responsive.scaleWidth(context, 20)),
          const Spacer(),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(
                  fontSize: Responsive.fontSize(context, 24),
                  fontWeight: FontWeight.w800,
                  color: color),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: Responsive.fontSize(context, 11), color: const Color(0xFF6B7280)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userCard(UserModel user) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.scaleWidth(context, 44),
            height: Responsive.scaleWidth(context, 44),
            decoration: BoxDecoration(
              color: user.role == 'worker' ? const Color(0xFFEFF6FF) : const Color(0xFFF0FDF4),
              shape: BoxShape.circle,
            ),
            child: Icon(user.role == 'worker' ? Icons.handyman_outlined : Icons.person_outline, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.fullName, style: TextStyle(fontSize: Responsive.fontSize(context, 14), fontWeight: FontWeight.bold)),
                Text(user.email, style: TextStyle(fontSize: Responsive.fontSize(context, 12), color: Colors.grey)),
              ],
            ),
          ),
          _roleBadge(user.role),
        ],
      ),
    );
  }

  Widget _bookingCard(BookingModel b) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(b.serviceType, style: TextStyle(fontSize: Responsive.fontSize(context, 14), fontWeight: FontWeight.bold)),
              _statusBadge(b.status),
            ],
          ),
          Text('Worker: ${b.workerName}', style: TextStyle(fontSize: Responsive.fontSize(context, 12))),
          Text('PKR ${b.amount}', style: TextStyle(fontSize: Responsive.fontSize(context, 14), fontWeight: FontWeight.bold, color: Colors.blue)),
        ],
      ),
    );
  }

  Widget _actionTile(IconData icon, String title, String sub, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            Icon(icon, color: const Color(0xFF1E3A8A), size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: Responsive.fontSize(context, 14), fontWeight: FontWeight.bold)),
                  Text(sub, style: TextStyle(fontSize: Responsive.fontSize(context, 12), color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _emptyState(IconData icon, String msg) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 48, color: Colors.grey),
          Text(msg, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _roleBadge(String role) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: Colors.blue.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(role.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blue)),
    );
  }

  Widget _statusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(status.toUpperCase(), style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.amber)),
    );
  }
}