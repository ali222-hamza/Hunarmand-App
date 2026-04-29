import 'package:flutter/material.dart';
// Apni responsive file ka path yahan zaroor check kar lein
import '../../../core/utils/responsive.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  final List<double> weekEarnings = [2500, 4100, 2200, 5200, 5900, 7800, 3700];
  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  final List<Map<String, dynamic>> recentJobs = [
    {
      'service': 'Electrical Maintenance',
      'client': 'Ahmed Khan',
      'rating': 5.0,
      'date': 'Oct 24, 2023',
      'payout': 'Rs. 4,500',
    },
    {
      'service': 'AC Repair & Cleaning',
      'client': 'Zehra Batool',
      'rating': 4.0,
      'date': 'Oct 23, 2023',
      'payout': 'Rs. 3,200',
    },
    {
      'service': 'Plumbing Service',
      'client': 'Usman Ali',
      'rating': 5.0,
      'date': 'Oct 22, 2023',
      'payout': 'Rs. 2,800',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double maxVal = weekEarnings.reduce((a, b) => a > b ? a : b);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Performance',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 17),
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1A2E),
          ),
        ),
        centerTitle: false,
        actions: [
          Icon(Icons.warning_amber_rounded,
              color: Colors.red.shade400, size: Responsive.scaleWidth(context, 24)),
          SizedBox(width: Responsive.scaleWidth(context, 12)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(Responsive.scaleWidth(context, 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top two stat boxes
              Row(
                children: [
                  Expanded(
                    child: _StatBox(
                      label: 'WEEKLY INCOME',
                      value: 'Rs. 33,800',
                      sub: '+12.4% vs last week',
                      subColor: const Color(0xFF22C55E),
                    ),
                  ),
                  SizedBox(width: Responsive.scaleWidth(context, 12)),
                  Expanded(
                    child: _StatBox(
                      label: 'JOBS FINISHED',
                      value: '24 Tasks',
                      sub: 'Active Streak: 5 Days',
                      subColor: const Color(0xFFFBB700),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Responsive.scaleHeight(context, 20)),

              // Weekly bar chart card
              Container(
                padding: EdgeInsets.all(Responsive.scaleWidth(context, 16)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weekly Trend',
                                style: TextStyle(
                                  fontSize: Responsive.fontSize(context, 15),
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1A1A2E),
                                ),
                              ),
                              Text(
                                'Daily earnings in PKR',
                                style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 11), color: const Color(0xFF6B7280)),
                              ),
                            ],
                          ),
                        ),
                        _buildFilterBadge(context),
                      ],
                    ),

                    SizedBox(height: Responsive.scaleHeight(context, 24)),

                    // Bar chart area
                    SizedBox(
                      height: Responsive.scaleHeight(context, 140),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(days.length, (i) {
                          double barHeight = (weekEarnings[i] / maxVal) * 110;
                          bool isBest = weekEarnings[i] == maxVal;
                          // Dynamic width for bars to prevent overflow on thin screens
                          double barWidth = Responsive.scaleWidth(context, 28);

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              if (isBest)
                                Text(
                                  '${(weekEarnings[i] / 1000).toStringAsFixed(1)}k',
                                  style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 10),
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1E3A8A),
                                  ),
                                ),
                              const SizedBox(height: 4),
                              Container(
                                width: barWidth,
                                height: barHeight,
                                decoration: BoxDecoration(
                                  color: isBest
                                      ? const Color(0xFF1E3A8A)
                                      : const Color(0xFF93C5FD).withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                days[i],
                                style: TextStyle(
                                    fontSize: Responsive.fontSize(context, 10), color: const Color(0xFF9CA3AF)),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: Responsive.scaleHeight(context, 20)),

              // History Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent History',
                    style: TextStyle(
                      fontSize: Responsive.fontSize(context, 16),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View All',
                      style: TextStyle(
                        fontSize: Responsive.fontSize(context, 13),
                        color: const Color(0xFF1E3A8A),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              // Job history list
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: recentJobs.length,
                itemBuilder: (context, index) => _JobHistoryCard(job: recentJobs[index]),
              ),

              SizedBox(height: Responsive.scaleHeight(context, 16)),

              // Pro Tip - Using Responsive padding
              Container(
                padding: EdgeInsets.all(Responsive.scaleWidth(context, 14)),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.stars_rounded, color: Color(0xFF1E3A8A), size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Pro Tip: Complete 3 more high-rated jobs to qualify for Gold Badge!',
                        style: TextStyle(
                            fontSize: Responsive.fontSize(context, 13),
                            color: const Color(0xFF374151),
                            height: 1.4
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Responsive.scaleHeight(context, 30)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today_outlined, size: 12, color: Color(0xFF6B7280)),
          const SizedBox(width: 4),
          Text(
            '7 Days',
            style: TextStyle(fontSize: Responsive.fontSize(context, 11), color: const Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final String sub;
  final Color subColor;

  const _StatBox({required this.label, required this.value, required this.sub, required this.subColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.scaleWidth(context, 14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: Responsive.fontSize(context, 9), letterSpacing: 0.5, color: const Color(0xFF9CA3AF))),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: Responsive.fontSize(context, 17), fontWeight: FontWeight.w800, color: const Color(0xFF1E3A8A))),
          const SizedBox(height: 2),
          FittedBox(
            child: Text(sub, style: TextStyle(fontSize: Responsive.fontSize(context, 10), color: subColor, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _JobHistoryCard extends StatelessWidget {
  final Map<String, dynamic> job;
  const _JobHistoryCard({required this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(Responsive.scaleWidth(context, 14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job['service'], style: TextStyle(fontSize: Responsive.fontSize(context, 14), fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, size: 12, color: Color(0xFFFBB700)),
                    const SizedBox(width: 4),
                    Text('${job['rating']} • ${job['date']}',
                        style: TextStyle(fontSize: Responsive.fontSize(context, 11), color: const Color(0xFF6B7280))),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(job['payout'], style: TextStyle(fontSize: Responsive.fontSize(context, 14), fontWeight: FontWeight.w800, color: const Color(0xFF1E3A8A))),
              Text('Earned', style: TextStyle(fontSize: Responsive.fontSize(context, 10), color: const Color(0xFF22C55E), fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}