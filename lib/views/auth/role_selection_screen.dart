import 'package:flutter/material.dart';
// Apni responsive file ka path yahan zaroor check kar lein
import '../../../core/utils/responsive.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left,
              color: const Color(0xFF374151),
              size: Responsive.scaleWidth(context, 26)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Choose Your Role',
            style: TextStyle(
                fontSize: Responsive.fontSize(context, 16),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A2E))),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: Responsive.horizontalPadding(context),
              vertical: Responsive.scaleHeight(context, 16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'How would you like to use\nHUNARMAND?',
                style: TextStyle(
                    fontSize: Responsive.fontSize(context, 22),
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1E3A8A),
                    height: 1.3),
              ),
              SizedBox(height: Responsive.scaleHeight(context, 6)),
              Text(
                'Select the role that best describes your needs. You can always change this later.',
                style: TextStyle(
                    fontSize: Responsive.fontSize(context, 13),
                    color: const Color(0xFF6B7280),
                    height: 1.4),
              ),
              SizedBox(height: Responsive.scaleHeight(context, 24)),

              // Worker card
              _RoleCard(
                icon: Icons.handyman_outlined,
                badge: 'Service Provider',
                title: "I'm a Worker",
                subtitle: 'I want to offer my professional skills and earn a reliable income.',
                features: const [
                  'Access thousands of verified jobs',
                  'Set your own flexible working hours',
                  'Secure and instant digital payments'
                ],
                onTap: () => Navigator.pushNamed(context, '/register', arguments: 'worker'),
              ),

              SizedBox(height: Responsive.scaleHeight(context, 14)),

              // Customer card
              _RoleCard(
                icon: Icons.search_rounded,
                badge: 'Client',
                title: "I'm a Customer",
                subtitle: 'I want to hire skilled professionals for my home or business tasks.',
                features: const [
                  'Browse top-rated local experts',
                  'Get multiple competitive quotes',
                  'Secure job completion guarantees'
                ],
                onTap: () => Navigator.pushNamed(context, '/register', arguments: 'customer'),
              ),

              SizedBox(height: Responsive.scaleHeight(context, 24)),

              Center(
                child: Column(
                  children: [
                    Text('Already have an account?',
                        style: TextStyle(fontSize: Responsive.fontSize(context, 13), color: const Color(0xFF6B7280))),
                    SizedBox(height: Responsive.scaleHeight(context, 8)),
                    SizedBox(
                      width: double.infinity,
                      height: Responsive.scaleHeight(context, 48),
                      child: OutlinedButton(
                        onPressed: () => Navigator.pushNamed(context, '/login'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1E3A8A)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: Text('Log In Instead',
                            style: TextStyle(
                                fontSize: Responsive.fontSize(context, 14),
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF1E3A8A))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String badge;
  final String title;
  final String subtitle;
  final List<String> features;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon, required this.badge, required this.title,
    required this.subtitle, required this.features, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.scaleWidth(context, 16)),
      decoration: BoxDecoration(
        color: const Color(0xFF1E3A8A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Responsive.scaleWidth(context, 40),
                height: Responsive.scaleWidth(context, 40),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(icon, color: const Color(0xFFFBB700), size: Responsive.scaleWidth(context, 22)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFFBB700), borderRadius: BorderRadius.circular(20)),
                child: Text(badge,
                    style: TextStyle(
                        fontSize: Responsive.fontSize(context, 11),
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1A1A2E))),
              ),
            ],
          ),
          SizedBox(height: Responsive.scaleHeight(context, 12)),
          Text(title,
              style: TextStyle(
                  fontSize: Responsive.fontSize(context, 18),
                  fontWeight: FontWeight.w800,
                  color: Colors.white)),
          SizedBox(height: Responsive.scaleHeight(context, 4)),
          Text(subtitle,
              style: TextStyle(
                  fontSize: Responsive.fontSize(context, 12),
                  color: Colors.white.withOpacity(0.75),
                  height: 1.3)),
          SizedBox(height: Responsive.scaleHeight(context, 12)),

          // Features with Expanded/Flexible fix
          ...features.map((f) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle_outline,
                    color: const Color(0xFFFBB700),
                    size: Responsive.scaleWidth(context, 16)),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(f,
                    style: TextStyle(
                        fontSize: Responsive.fontSize(context, 12),
                        color: Colors.white.withOpacity(0.9)),
                  ),
                ),
              ],
            ),
          )),

          SizedBox(height: Responsive.scaleHeight(context, 12)),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFBB700),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.scaleWidth(context, 20),
                    vertical: Responsive.scaleHeight(context, 10)),
              ),
              child: Text('Select Role  >',
                  style: TextStyle(
                      fontSize: Responsive.fontSize(context, 13),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1A1A2E))),
            ),
          ),
        ],
      ),
    );
  }
}