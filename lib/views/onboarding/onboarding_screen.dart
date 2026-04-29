import 'package:flutter/material.dart';

// Onboarding screen - 3 slides before user picks a role
// Fixed: images now show properly, no overflow on any screen size
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  final PageController pageController = PageController();

  final List<Map<String, dynamic>> slides = [
    {
      'image': 'assets/images/onboard1.JPG',
      'label': 'IMPACT JOURNEY',
      'titleBlue1': 'Empowering',
      'titleYellow': 'Skilled',
      'titleBlue2': 'Pakistan',
      'desc':
      'Every connection on Hunarmand helps build a more prosperous Pakistan by connecting local talent with global opportunities.',
      'btnText': 'Learn More',
      'sub': 'Join 50,000+ workers contributing to the local economy',
    },
    {
      'image': 'assets/images/onboard2.JPG',
      'badge': 'Social Impact',
      'label': '',
      'titleBlue1': 'Skill Development',
      'titleYellow': 'for a',
      'titleBlue2': 'Better Future',
      'desc':
      'We connect thousands of talented individuals in Pakistan with professional training and sustainable income opportunities.',
      'btnText': 'Continue',
      'sub': 'EMPOWERING THE LOCAL WORKFORCE',
      'feat1': 'Professional Certification',
      'feat1sub': 'Industry-standard verified skills',
      'feat2': 'Economic Growth',
      'feat2sub': 'Avg. 40% increase in worker income',
    },
    {
      'image': 'assets/images/onboard3.JPG',
      'label': '',
      'titleBlue1': 'Building a Better',
      'titleYellow': 'Pakistan,',
      'titleBlue2': 'Together',
      'desc':
      'Every connection made on Hunarmand strengthens our local economy. Join thousands of users creating sustainable growth and dignified work opportunities.',
      'btnText': 'Get Started',
      'sub':
      'By continuing, you agree to our terms of service.',
      'feat1': 'Community First',
      'feat1sub': 'Supporting over 50,000+ local families.',
      'feat2': 'Local Expertise',
      'feat2sub': 'Empowering indigenous talent through digital inclusion.',
    },
  ];

  void goNext() {
    if (currentPage < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/role');
    }
  }

  void skip() => Navigator.pushReplacementNamed(context, '/role');

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen height for responsive layout
    final double sh = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar - back and skip buttons
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (currentPage > 0)
                    GestureDetector(
                      onTap: () => pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: const Icon(Icons.chevron_left,
                          size: 28, color: Color(0xFF374151)),
                    )
                  else
                    const SizedBox(width: 28),
                  GestureDetector(
                    onTap: skip,
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                          fontSize: 15, color: Color(0xFF6B7280)),
                    ),
                  ),
                ],
              ),
            ),

            // Page content - takes remaining space
            Expanded(
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (i) => setState(() => currentPage = i),
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  final s = slides[index];
                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        // Image section
                        Stack(
                          children: [
                            // The actual image - uses Image.asset with error fallback
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: Image.asset(
                                s['image'],
                                width: double.infinity,
                                height: sh * 0.32,
                                fit: BoxFit.cover,
                                // This shows a nice placeholder if image file is missing
                                errorBuilder: (ctx, err, stack) {
                                  return Container(
                                    height: sh * 0.32,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF3F4F6),
                                      borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.image_outlined,
                                          size: 48,
                                          color: Color(0xFF9CA3AF),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Add ${s['image']} to assets/images/',
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: Color(0xFF9CA3AF),
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Badge on slide 2 (Social Impact)
                            if (s['badge'] != null)
                              Positioned(
                                top: 14,
                                left: 14,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFBB700),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    s['badge'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),

                        // Text content
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Column(
                            children: [
                              // Title with 3 color parts
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '${s['titleBlue1']}\n',
                                      style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1E3A8A),
                                        height: 1.2,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${s['titleYellow']} ',
                                      style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFFFBB700),
                                      ),
                                    ),
                                    TextSpan(
                                      text: s['titleBlue2'],
                                      style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w800,
                                        color: Color(0xFF1E3A8A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                s['desc'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF374151),
                                  height: 1.5,
                                ),
                              ),

                              // Feature rows for slides 2 and 3
                              if (s['feat1'] != null) ...[
                                const SizedBox(height: 14),
                                _featureRow(
                                  Icons.workspace_premium_outlined,
                                  s['feat1'],
                                  s['feat1sub'],
                                ),
                                const SizedBox(height: 8),
                                _featureRow(
                                  Icons.trending_up,
                                  s['feat2'],
                                  s['feat2sub'],
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom section - dots and button
            // This is fixed at the bottom and never overflows
            Container(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Page dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(3, (i) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: i == currentPage ? 28 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: i == currentPage
                              ? const Color(0xFF1E3A8A)
                              : const Color(0xFFD1D5DB),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 14),

                  // Main action button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: goNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFBB700),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        '${slides[currentPage]['btnText']}  →',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Sub label below button
                  Text(
                    slides[currentPage]['sub'] ?? '',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureRow(IconData icon, String title, String sub) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF1E3A8A), size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                Text(
                  sub,
                  style: const TextStyle(
                      fontSize: 11, color: Color(0xFF6B7280)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}