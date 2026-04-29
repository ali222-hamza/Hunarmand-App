import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/responsive.dart';
import '../../../viewmodels/auth_viewmodel.dart';


class WorkerDashboardScreen extends StatefulWidget {
  const WorkerDashboardScreen({super.key});
  @override
  State<WorkerDashboardScreen> createState() => _WorkerDashboardScreenState();
}

class _WorkerDashboardScreenState extends State<WorkerDashboardScreen> {
  bool _isOnline = true;
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _payouts = [
    {'name': 'Ali Ahmed', 'service': 'AC Maintenance', 'amount': '+Rs. 1,500', 'time': '2 hours ago'},
    {'name': 'Sana Malik', 'service': 'Electrical Repair', 'amount': '+Rs. 850', 'time': '5 hours ago'},
    {'name': 'Usman Khan', 'service': 'Plumbing Checkup', 'amount': '+Rs. 1,200', 'time': 'Yesterday'},
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AuthViewModel>();
    final String workerName = vm.userName;
    final String firstName = workerName.isNotEmpty ? workerName.split(' ').first : 'Worker';

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // --- Responsive Top Bar ---
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.horizontalPadding(context),
                vertical: Responsive.scaleHeight(context, 12),
              ),
              child: Row(
                children: [
                  Container(
                    width: Responsive.scaleWidth(context, 32),
                    height: Responsive.scaleWidth(context, 32),
                    decoration: BoxDecoration(color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.bolt, color: const Color(0xFFFBB700), size: Responsive.scaleWidth(context, 18)),
                  ),
                  SizedBox(width: Responsive.scaleWidth(context, 8)),
                  Expanded(
                    child: Text(
                      "Hi, $firstName!",
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 16),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A2E),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.warning_amber_rounded, color: Colors.red.shade400, size: Responsive.scaleWidth(context, 22)),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(Responsive.scaleWidth(context, 14)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- Online Toggle ---
                    Container(
                      padding: EdgeInsets.all(Responsive.scaleWidth(context, 14)),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: Responsive.scaleWidth(context, 38),
                            height: Responsive.scaleWidth(context, 38),
                            decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(10)),
                            child: Icon(Icons.power_settings_new, color: const Color(0xFF374151), size: Responsive.scaleWidth(context, 20)),
                          ),
                          SizedBox(width: Responsive.scaleWidth(context, 10)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_isOnline ? "You're Online" : "You're Offline",
                                    style: TextStyle(fontSize: Responsive.fontSize(context, 14), fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                                Text(_isOnline ? 'Receiving new job requests' : 'Not receiving jobs',
                                    style: TextStyle(fontSize: Responsive.fontSize(context, 11), color: const Color(0xFF6B7280))),
                              ],
                            ),
                          ),
                          Switch(
                            value: _isOnline,
                            onChanged: (v) => setState(() => _isOnline = v),
                            activeColor: const Color(0xFF1E3A8A),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.scaleHeight(context, 14)),

                    // --- Upcoming Job Card ---
                    Container(
                      padding: EdgeInsets.all(Responsive.scaleWidth(context, 14)),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: Responsive.scaleWidth(context, 8), vertical: Responsive.scaleHeight(context, 3)),
                                decoration: BoxDecoration(color: const Color(0xFFFBB700), borderRadius: BorderRadius.circular(5)),
                                child: Text('IN 25 MINS', style: TextStyle(fontSize: Responsive.fontSize(context, 10), fontWeight: FontWeight.w700, color: Colors.white)),
                              ),
                              Icon(Icons.access_time, color: const Color(0xFFFBB700), size: Responsive.scaleWidth(context, 20)),
                            ],
                          ),
                          SizedBox(height: Responsive.scaleHeight(context, 8)),
                          Text('Plumbing Service - Emergency',
                              style: TextStyle(fontSize: Responsive.fontSize(context, 15), fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                          SizedBox(height: Responsive.scaleHeight(context, 3)),
                          Row(children: [
                            Icon(Icons.location_on_outlined, size: Responsive.scaleWidth(context, 13), color: const Color(0xFF6B7280)),
                            const SizedBox(width: 3),
                            Flexible(child: Text('Gulshan-e-Iqbal, Block 4, Karachi', style: TextStyle(fontSize: Responsive.fontSize(context, 11), color: const Color(0xFF6B7280)), overflow: TextOverflow.ellipsis)),
                          ]),
                          SizedBox(height: Responsive.scaleHeight(context, 12)),
                          SizedBox(
                            width: double.infinity,
                            height: Responsive.scaleHeight(context, 44),
                            child: ElevatedButton(
                              onPressed: () => Navigator.pushNamed(context, '/job_progress'),
                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E3A8A), elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                              child: Text('Start Job Journey', style: TextStyle(fontSize: Responsive.fontSize(context, 13), fontWeight: FontWeight.w700, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.scaleHeight(context, 16)),

                    // --- Earning Insights ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Icon(Icons.trending_up, size: Responsive.scaleWidth(context, 16), color: const Color(0xFF1A1A2E)),
                          SizedBox(width: Responsive.scaleWidth(context, 6)),
                          Text('Earning Insights', style: TextStyle(fontSize: Responsive.fontSize(context, 15), fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                        ]),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, '/performance'),
                          child: Text('View History', style: TextStyle(fontSize: Responsive.fontSize(context, 12), color: const Color(0xFF1E3A8A), fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.scaleHeight(context, 10)),

                    Row(
                      children: [
                        _buildEarningCard("TODAY'S TOTAL", "Rs. 4,250", "+12% from yesterday", true),
                        SizedBox(width: Responsive.scaleWidth(context, 10)),
                        _buildEarningCard("THIS MONTH", "Rs. 84,120", "+5.4% target", false),
                      ],
                    ),
                    SizedBox(height: Responsive.scaleHeight(context, 16)),

                    // --- Quick Actions ---
                    Text('Quick Actions', style: TextStyle(fontSize: Responsive.fontSize(context, 15), fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                    SizedBox(height: Responsive.scaleHeight(context, 10)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _QuickAction(Icons.calendar_today_outlined, 'Schedule', const Color(0xFFEFF6FF)),
                        _QuickAction(Icons.location_on_outlined, 'Hotzones', const Color(0xFFFFF7ED)),
                        _QuickAction(Icons.bolt_outlined, 'Incentives', const Color(0xFFFFFBEB)),
                        _QuickAction(Icons.notifications_outlined, 'Notifs', const Color(0xFFF5F3FF)),
                      ],
                    ),
                    SizedBox(height: Responsive.scaleHeight(context, 16)),

                    Text('Recent Job Payouts', style: TextStyle(fontSize: Responsive.fontSize(context, 15), fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
                    SizedBox(height: Responsive.scaleHeight(context, 10)),

                    ..._payouts.map((p) => _PayoutTile(p: p)),

                    SizedBox(
                      width: double.infinity,
                      height: Responsive.scaleHeight(context, 44),
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFE5E7EB)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text('Load More Activity', style: TextStyle(fontSize: Responsive.fontSize(context, 13), color: const Color(0xFF6B7280))),
                      ),
                    ),
                    SizedBox(height: Responsive.scaleHeight(context, 16)),
                  ],
                ),
              ),
            ),

            _buildWorkerNav(),
          ],
        ),
      ),
    );
  }

  // --- Helper Earning Card ---
  Widget _buildEarningCard(String title, String amount, String subtitle, bool isPrimary) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(Responsive.scaleWidth(context, 14)),
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFF1E3A8A) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary ? null : Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: Responsive.fontSize(context, 9), color: isPrimary ? Colors.white60 : const Color(0xFF9CA3AF), letterSpacing: 0.8)),
            SizedBox(height: Responsive.scaleHeight(context, 4)),
            FittedBox(child: Text(amount, style: TextStyle(fontSize: Responsive.fontSize(context, 18), fontWeight: FontWeight.w800, color: isPrimary ? Colors.white : const Color(0xFF1A1A2E)))),
            SizedBox(height: Responsive.scaleHeight(context, 2)),
            Text(subtitle, style: TextStyle(fontSize: Responsive.fontSize(context, 10), color: isPrimary ? const Color(0xFFFBB700) : const Color(0xFF22C55E))),
          ],
        ),
      ),
    );
  }

  // --- Bottom Navigation ---
  Widget _buildWorkerNav() {
    final items = [
      {'icon': Icons.grid_view_outlined, 'label': 'Home'},
      {'icon': Icons.account_balance_wallet_outlined, 'label': 'Wallet'},
      {'icon': Icons.bar_chart_outlined, 'label': 'Stats'},
      {'icon': Icons.notifications_outlined, 'label': 'Alerts'},
      {'icon': Icons.settings_outlined, 'label': 'Menu'},
    ];
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, -2))]),
      child: Row(
        children: List.generate(items.length, (i) {
          bool active = i == _selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedTab = i);
                if (i == 1) Navigator.pushNamed(context, '/wallet');
                if (i == 2) Navigator.pushNamed(context, '/performance');
                if (i == 3) Navigator.pushNamed(context, '/notifications');
                if (i == 4) Navigator.pushNamed(context, '/settings');
              },
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                SizedBox(height: Responsive.scaleHeight(context, 10)),
                Icon(items[i]['icon'] as IconData, size: Responsive.scaleWidth(context, 22), color: active ? const Color(0xFF1E3A8A) : const Color(0xFF9CA3AF)),
                SizedBox(height: Responsive.scaleHeight(context, 3)),
                Text(items[i]['label'] as String, style: TextStyle(fontSize: Responsive.fontSize(context, 10), color: active ? const Color(0xFF1E3A8A) : const Color(0xFF9CA3AF))),
                SizedBox(height: Responsive.scaleHeight(context, 10)),
              ]),
            ),
          );
        }),
      ),
    );
  }
}

// --- Quick Action Component ---
class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bg;
  const _QuickAction(this.icon, this.label, this.bg);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Responsive.scaleWidth(context, 52),
          height: Responsive.scaleWidth(context, 52),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14)),
          child: Icon(icon, color: const Color(0xFF374151), size: Responsive.scaleWidth(context, 22)),
        ),
        SizedBox(height: Responsive.scaleHeight(context, 5)),
        Text(label, style: TextStyle(fontSize: Responsive.fontSize(context, 11), color: const Color(0xFF6B7280))),
      ],
    );
  }
}

// --- Payout Tile Component ---
class _PayoutTile extends StatelessWidget {
  final Map<String, dynamic> p;
  const _PayoutTile({required this.p});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.scaleHeight(context, 8)),
      padding: EdgeInsets.symmetric(horizontal: Responsive.scaleWidth(context, 12), vertical: Responsive.scaleHeight(context, 10)),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: const Color(0xFFE5E7EB))),
      child: Row(
        children: [
          CircleAvatar(
            radius: Responsive.scaleWidth(context, 20),
            backgroundColor: const Color(0xFFE5E7EB),
            child: Icon(Icons.person, color: Colors.grey.shade500, size: Responsive.scaleWidth(context, 20)),
          ),
          SizedBox(width: Responsive.scaleWidth(context, 10)),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(p['name'], style: TextStyle(fontSize: Responsive.fontSize(context, 13), fontWeight: FontWeight.w600, color: const Color(0xFF1A1A2E))),
              Text(p['service'], style: TextStyle(fontSize: Responsive.fontSize(context, 11), color: const Color(0xFF6B7280))),
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(p['amount'], style: TextStyle(fontSize: Responsive.fontSize(context, 13), fontWeight: FontWeight.w700, color: const Color(0xFF22C55E))),
            Text(p['time'], style: TextStyle(fontSize: Responsive.fontSize(context, 10), color: const Color(0xFF9CA3AF))),
          ]),
        ],
      ),
    );
  }
}