import 'package:flutter/material.dart';
// Apni responsive file ka path yahan zaroor check kar lein
import '../../../core/utils/responsive.dart';

class JobRequestScreen extends StatefulWidget {
  const JobRequestScreen({super.key});

  @override
  State<JobRequestScreen> createState() => _JobRequestScreenState();
}

class _JobRequestScreenState extends State<JobRequestScreen> {
  int _secondsLeft = 45;

  @override
  void initState() {
    super.initState();
    // countdown timer logic stays exactly as you provided
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return false;
      setState(() => _secondsLeft--);
      if (_secondsLeft <= 0) {
        Navigator.pop(context);
        return false;
      }
      return true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.scaleWidth(context, 20)),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9, // Screen se bahar na jaye
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView( // Scrollable for small screens
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Blue top section
                  _buildHeader(context),

                  // White bottom section
                  Padding(
                    padding: EdgeInsets.all(Responsive.scaleWidth(context, 20)),
                    child: Column(
                      children: [
                        _buildClientInfo(context),
                        SizedBox(height: Responsive.scaleHeight(context, 16)),

                        // Service info cards
                        _buildInfoTile(context, Icons.bolt_outlined, 'SERVICE NEEDED', 'AC Repair & Maintenance', const Color(0xFF1E3A8A)),
                        SizedBox(height: Responsive.scaleHeight(context, 10)),
                        _buildInfoTile(context, Icons.location_on_outlined, 'DISTANCE', '2.4 km (G-10/2, Islamabad)', const Color(0xFF6B7280)),
                        SizedBox(height: Responsive.scaleHeight(context, 10)),

                        // Payout card
                        _buildPayoutCard(context),
                        SizedBox(height: Responsive.scaleHeight(context, 16)),

                        // Buttons section
                        _buildActionButtons(context),
                        SizedBox(height: Responsive.scaleHeight(context, 12)),

                        _buildFooterNote(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.scaleWidth(context, 24)),
      decoration: const BoxDecoration(
        color: Color(0xFF1E3A8A),
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFBB700),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.access_time, size: 14, color: Colors.white),
                  const SizedBox(width: 4),
                  Text(
                    '${_secondsLeft}s REMAINING',
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          CircleAvatar(
            radius: Responsive.scaleWidth(context, 40),
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: Responsive.scaleWidth(context, 40), color: Colors.grey.shade400),
          ),
        ],
      ),
    );
  }

  Widget _buildClientInfo(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('M. Rizwan',
                style: TextStyle(fontSize: Responsive.fontSize(context, 20), fontWeight: FontWeight.w800, color: const Color(0xFF1A1A2E))),
            const SizedBox(width: 6),
            const Icon(Icons.verified_user_outlined, size: 18, color: Color(0xFF1E3A8A)),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.star, size: 14, color: Color(0xFFFBB700)),
            const SizedBox(width: 4),
            Text('4.9 (124 reviews)',
                style: TextStyle(fontSize: Responsive.fontSize(context, 12), color: const Color(0xFFFBB700), fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoTile(BuildContext context, IconData icon, String label, String value, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF8F9FA), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 9, letterSpacing: 1, color: Color(0xFF9CA3AF))),
                Text(value, style: TextStyle(fontSize: Responsive.fontSize(context, 14), fontWeight: FontWeight.w700, color: const Color(0xFF1A1A2E))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPayoutCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFF1E3A8A),
            radius: 18,
            child: Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('ESTIMATED PAYOUT', style: TextStyle(fontSize: 9, color: Color(0xFF1E3A8A))),
              Text('Rs. 2,450', style: TextStyle(fontSize: Responsive.fontSize(context, 18), fontWeight: FontWeight.w800, color: const Color(0xFF1E3A8A))),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
            child: const Text('Instant', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF1E3A8A))),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: Responsive.scaleHeight(context, 50),
          child: ElevatedButton(
            onPressed: () => Navigator.pushReplacementNamed(context, '/job_progress'),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF1E3A8A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: Text('Accept Job Request', style: TextStyle(fontSize: Responsive.fontSize(context, 15), fontWeight: FontWeight.bold, color: Colors.white)),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: const Text('Decline', style: TextStyle(color: Color(0xFF6B7280))),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF1E3A8A)),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: const Text('Ask Details', style: TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterNote(BuildContext context) {
    return Text(
      'Accepting this request commits you to the job. Use SOS for emergencies.',
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: Responsive.fontSize(context, 10), color: const Color(0xFF9CA3AF)),
    );
  }
}