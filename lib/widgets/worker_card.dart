import 'package:flutter/material.dart';
// Apni responsive file ka path yahan zaroor check kar lein
import '../../../core/utils/responsive.dart';

class WorkerCard extends StatelessWidget {
  final String name;
  final String title;
  final String rating;
  final String reviews;
  final bool isOnline;
  final VoidCallback onProfile;

  const WorkerCard({
    super.key,
    required this.name,
    required this.title,
    required this.rating,
    required this.reviews,
    required this.isOnline,
    required this.onProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Responsive.scaleHeight(context, 10)),
      padding: EdgeInsets.all(Responsive.scaleWidth(context, 14)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          // Avatar with online status
          _buildAvatar(context),

          SizedBox(width: Responsive.scaleWidth(context, 12)),

          // Information section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 15),
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    _buildVerifiedBadge(),
                  ],
                ),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: Responsive.fontSize(context, 12),
                    color: const Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 4),
                _buildRatingRow(context),
              ],
            ),
          ),

          SizedBox(width: Responsive.scaleWidth(context, 8)),

          // Profile Button
          _buildButton(context),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          radius: Responsive.scaleWidth(context, 24),
          backgroundColor: const Color(0xFFF3F4F6),
          child: Icon(Icons.person, size: 24, color: Colors.grey.shade400),
        ),
        if (isOnline)
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildVerifiedBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2FE), // Blueish tint for verified
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Icon(Icons.verified, size: 10, color: Color(0xFF1E3A8A)),
    );
  }

  Widget _buildRatingRow(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, size: 14, color: Color(0xFFFBB700)),
        const SizedBox(width: 4),
        Text(
          '$rating ($reviews)',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 11),
            fontWeight: FontWeight.w600,
            color: const Color(0xFF374151),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return SizedBox(
      height: Responsive.scaleHeight(context, 36),
      child: ElevatedButton(
        onPressed: onProfile,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1E3A8A),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          'Profile',
          style: TextStyle(
            fontSize: Responsive.fontSize(context, 12),
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}