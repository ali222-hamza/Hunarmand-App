import 'package:flutter/material.dart';

// Review Screen - Screen 15 in design PDF
// Shown after a job is completed, customer rates the worker
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _stars = 0;
  final _commentController = TextEditingController();

  final List<String> _labels = ['', 'Poor', 'Fair', 'Good', 'Great', 'Excellent!'];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_stars == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please give a star rating first')),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Review submitted! Thank you.'),
        backgroundColor: Color(0xFF22C55E),
      ),
    );
    Navigator.pushReplacementNamed(context, '/customer_home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Job Complete',
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A2E)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: Color(0xFF6B7280)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              // Big checkmark
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color(0xFF1A1A2E), width: 3),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check,
                    size: 40, color: Color(0xFF1A1A2E)),
              ),

              const SizedBox(height: 16),

              const Text(
                'Thank You!',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E3A8A),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Your electrical maintenance request has been successfully completed.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
                    height: 1.5),
              ),

              const SizedBox(height: 24),

              // Worker info card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: const Color(0xFFE5E7EB),
                          child: Icon(Icons.person,
                              size: 28, color: Colors.grey.shade500),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Arjun Singh',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1A1A2E)),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFFBEB),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'Verified',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFFFBB700)),
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              'PROFESSIONAL ELECTRICIAN',
                              style: TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 1,
                                  color: Color(0xFF9CA3AF)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    const Divider(color: Color(0xFFE5E7EB)),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined,
                            size: 16, color: Color(0xFF6B7280)),
                        const SizedBox(width: 6),
                        const Text('Oct 24, 2023',
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF374151))),
                        const SizedBox(width: 20),
                        const Icon(Icons.access_time_outlined,
                            size: 16, color: Color(0xFF6B7280)),
                        const SizedBox(width: 6),
                        const Text('10:30 AM - 12:15 PM',
                            style: TextStyle(
                                fontSize: 13, color: Color(0xFF374151))),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Rating
              Row(
                children: [
                  const Icon(Icons.thumb_up_outlined,
                      size: 18, color: Color(0xFF1E3A8A)),
                  const SizedBox(width: 8),
                  const Text(
                    'How would you rate the service?',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E)),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (i) {
                  return GestureDetector(
                    onTap: () => setState(() => _stars = i + 1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(
                        _stars > i ? Icons.star : Icons.star_border,
                        size: 40,
                        color: const Color(0xFFFBB700),
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 8),

              Text(
                _stars > 0 ? _labels[_stars] : 'Tap to rate',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF6B7280)),
              ),

              const SizedBox(height: 24),

              // Comment box
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          size: 16, color: Color(0xFF1E3A8A)),
                      SizedBox(width: 8),
                      Text(
                        'Additional Comments',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1A1A2E)),
                      ),
                    ],
                  ),
                  const Text('OPTIONAL',
                      style: TextStyle(
                          fontSize: 10,
                          letterSpacing: 1,
                          color: Color(0xFF9CA3AF))),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _commentController,
                maxLines: 4,
                onChanged: (v) => setState(() {}),
                decoration: InputDecoration(
                  hintText: 'Share your experience with Arjun Singh...',
                  hintStyle: const TextStyle(
                      fontSize: 13, color: Color(0xFF9CA3AF)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                    const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: Color(0xFF1E3A8A), width: 1.5),
                  ),
                  suffix: Text(
                    '${_commentController.text.length} characters',
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFFFBB700)),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const Icon(Icons.send_outlined,
                      size: 18, color: Colors.white),
                  label: const Text(
                    'Submit Review',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}