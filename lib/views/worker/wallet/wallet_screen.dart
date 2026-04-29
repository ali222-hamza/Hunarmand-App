import 'package:flutter/material.dart';
// Apni responsive file ka path yahan zaroor check kar lein
import '../../../core/utils/responsive.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _selectedTab = 1;

  final List<Map<String, dynamic>> _transactions = [
    {
      'title': 'Job #4928 - Kitchen Repair',
      'time': 'Oct 24, 2:30 PM',
      'amount': '+ PKR 4,500',
      'status': 'COMPLETED',
      'isCredit': true,
    },
    {
      'title': 'Withdrawal to JazzCash',
      'time': 'Oct 23, 11:15 AM',
      'amount': '- PKR 12,000',
      'status': 'COMPLETED',
      'isCredit': false,
    },
    {
      'title': 'Job #4811 - AC Service',
      'time': 'Oct 22, 9:00 AM',
      'amount': '+ PKR 2,800',
      'status': 'COMPLETED',
      'isCredit': true,
    },
    {
      'title': 'Platform Bonus',
      'time': 'Oct 20, 4:00 PM',
      'amount': '+ PKR 500',
      'status': 'PENDING',
      'isCredit': true,
    },
  ];

  Color _statusColor(String status) {
    if (status == 'COMPLETED') return const Color(0xFF22C55E);
    if (status == 'PENDING') return const Color(0xFFFBB700);
    return const Color(0xFFEF4444);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'My Wallet',
          style: TextStyle(
              fontSize: Responsive.fontSize(context, 18),
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1A1A2E)),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Color(0xFF1E3A8A)),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(Responsive.scaleWidth(context, 16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Balance Card
                    _buildBalanceCard(context),

                    SizedBox(height: Responsive.scaleHeight(context, 24)),

                    // Linked Accounts Header
                    _buildSectionHeader(context, 'Linked Accounts', 'Manage'),
                    SizedBox(height: Responsive.scaleHeight(context, 12)),

                    Row(
                      children: [
                        _paymentCard(context, 'JazzCash', '0300 **** 782', true),
                        SizedBox(width: Responsive.scaleWidth(context, 12)),
                        _paymentCard(context, 'EasyPaisa', '0345 **** 119', false),
                      ],
                    ),

                    SizedBox(height: Responsive.scaleHeight(context, 24)),

                    // Activity Header
                    _buildSectionHeader(context, 'Recent Activity', 'View All'),
                    SizedBox(height: Responsive.scaleHeight(context, 12)),

                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _transactions.length,
                      itemBuilder: (context, index) => _TxTile(
                        tx: _transactions[index],
                        statusColor: _statusColor(_transactions[index]['status']),
                      ),
                    ),

                    SizedBox(height: Responsive.scaleHeight(context, 20)),

                    // Security Note
                    _buildSecurityNote(context),
                    SizedBox(height: Responsive.scaleHeight(context, 20)),
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

  Widget _buildBalanceCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.scaleWidth(context, 20)),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A8A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3A8A).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Available Balance',
                  style: TextStyle(fontSize: Responsive.fontSize(context, 13), color: Colors.white70)),
              _buildVerifiedBadge(context),
            ],
          ),
          SizedBox(height: Responsive.scaleHeight(context, 8)),
          Text(
            'PKR 48,250.00',
            style: TextStyle(
              fontSize: Responsive.fontSize(context, 28),
              fontWeight: FontWeight.w800,
              color: const Color(0xFFFBB700),
            ),
          ),
          SizedBox(height: Responsive.scaleHeight(context, 20)),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFBB700),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text('Withdraw Funds',
                      style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1A1A2E))),
                ),
              ),
              const SizedBox(width: 12),
              _circleIconBtn(Icons.qr_code_scanner),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, String action) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: TextStyle(
                fontSize: Responsive.fontSize(context, 16),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E))),
        Text(action,
            style: TextStyle(
                fontSize: Responsive.fontSize(context, 13),
                color: const Color(0xFF1E3A8A),
                fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildVerifiedBadge(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.verified, size: 12, color: Colors.white),
          const SizedBox(width: 4),
          Text('Verified',
              style: TextStyle(fontSize: Responsive.fontSize(context, 10), color: Colors.white)),
        ],
      ),
    );
  }

  Widget _circleIconBtn(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }

  Widget _paymentCard(BuildContext context, String name, String number, bool isDefault) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDefault ? const Color(0xFF1E3A8A) : const Color(0xFFE5E7EB),
            width: isDefault ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              name == 'JazzCash'
                  ? 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/JazzCash_logo.png/600px-JazzCash_logo.png'
                  : 'https://seeklogo.com/images/E/easypaisa-logo-45731D74E3-seeklogo.com.png',
              height: 20,
              errorBuilder: (c, e, s) => const Icon(Icons.account_balance, size: 20),
            ),
            const SizedBox(height: 12),
            Text(name,
                style: TextStyle(
                    fontSize: Responsive.fontSize(context, 14),
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1A1A2E))),
            Text(number,
                style: TextStyle(fontSize: Responsive.fontSize(context, 11), color: const Color(0xFF6B7280))),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityNote(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFEF3C7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.shield_outlined, color: Color(0xFFFBB700), size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Your funds are secured with 256-bit encryption. Settlements are processed daily through State Bank authorized gateways.',
              style: TextStyle(
                  fontSize: Responsive.fontSize(context, 11),
                  color: const Color(0xFF6B7280),
                  height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNav() {
    final items = [
      {'icon': Icons.home_outlined, 'label': 'Home'},
      {'icon': Icons.account_balance_wallet_outlined, 'label': 'Wallet'},
      {'icon': Icons.bar_chart_outlined, 'label': 'Performance'},
      {'icon': Icons.person_outline, 'label': 'Profile'},
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        children: List.generate(items.length, (i) {
          bool active = i == _selectedTab;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = i),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(items[i]['icon'] as IconData,
                        size: 24,
                        color: active ? const Color(0xFF1E3A8A) : const Color(0xFF9CA3AF)),
                    Text(items[i]['label'] as String,
                        style: TextStyle(
                            fontSize: 10,
                            color: active ? const Color(0xFF1E3A8A) : const Color(0xFF9CA3AF))),
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

class _TxTile extends StatelessWidget {
  final Map<String, dynamic> tx;
  final Color statusColor;
  const _TxTile({required this.tx, required this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: tx['isCredit'] ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
            radius: 18,
            child: Icon(
              tx['isCredit'] ? Icons.arrow_downward : Icons.arrow_upward,
              size: 16,
              color: tx['isCredit'] ? const Color(0xFF22C55E) : const Color(0xFFEF4444),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tx['title'],
                    style: TextStyle(
                        fontSize: Responsive.fontSize(context, 13),
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1A1A2E))),
                Text(tx['time'],
                    style: TextStyle(fontSize: Responsive.fontSize(context, 11), color: const Color(0xFF9CA3AF))),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(tx['amount'],
                  style: TextStyle(
                      fontSize: Responsive.fontSize(context, 13),
                      fontWeight: FontWeight.w800,
                      color: tx['isCredit'] ? const Color(0xFF22C55E) : const Color(0xFFEF4444))),
              Text(tx['status'],
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: statusColor)),
            ],
          ),
        ],
      ),
    );
  }
}