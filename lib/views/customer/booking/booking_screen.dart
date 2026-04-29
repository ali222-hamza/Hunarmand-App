import 'package:flutter/material.dart';

// Booking Calendar Screen - Screen 13 in design PDF
class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int selectedDay = 24;
  String selectedSlot = '10:30 AM';
  final _notesController = TextEditingController();

  // Time slots for morning, afternoon and evening
  final morningSlots = ['09:00 AM', '10:30 AM', '11:30 AM'];
  final afternoonSlots = ['01:00 PM', '02:30 PM', '04:00 PM'];
  final eveningSlots = ['05:30 PM', '07:00 PM'];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _confirmBooking() {
    Navigator.pushNamed(context, '/tracking');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Booking confirmed! Worker is being assigned.'),
        backgroundColor: Color(0xFF22C55E),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28, color: Color(0xFF374151)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Booking Calendar',
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E)),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Color(0xFF6B7280)),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Worker info card at top
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: const Color(0xFFDBEAFE),
                      child: Icon(Icons.person, color: Colors.grey.shade500),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Arshad Khan',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A1A2E)),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFBEB),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text('Verified',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Color(0xFFFBB700),
                                      fontWeight: FontWeight.w700)),
                            ),
                          ],
                        ),
                        const Text(
                          'Master Electrician · \$25/hr',
                          style: TextStyle(fontSize: 12, color: Color(0xFF1E3A8A)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Calendar section
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined,
                      color: Color(0xFF1E3A8A), size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Select Date',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E)),
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_left, color: Color(0xFF9CA3AF)),
                  const Text(
                    'October 2024',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A2E)),
                  ),
                  const Icon(Icons.chevron_right, color: Color(0xFF9CA3AF)),
                ],
              ),
              const SizedBox(height: 12),

              // Days of week header
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _DayHeader('S'), _DayHeader('M'), _DayHeader('T'),
                  _DayHeader('W'), _DayHeader('T'), _DayHeader('F'), _DayHeader('S'),
                ],
              ),
              const SizedBox(height: 8),

              // Calendar grid (October 2024 layout)
              ..._buildCalendarRows(),

              const SizedBox(height: 20),

              // Time slots
              Row(
                children: [
                  const Icon(Icons.access_time_outlined,
                      color: Color(0xFF1E3A8A), size: 20),
                  const SizedBox(width: 8),
                  const Text(
                    'Available Slots',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E)),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _slotGroup(Icons.wb_sunny_outlined, 'MORNING', morningSlots),
              const SizedBox(height: 12),
              _slotGroup(Icons.sunny, 'AFTERNOON', afternoonSlots),
              const SizedBox(height: 12),
              _slotGroup(Icons.nights_stay_outlined, 'EVENING', eveningSlots),

              const SizedBox(height: 20),

              // Notes field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Service Notes',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1A1A2E))),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F6),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: const Text('Optional',
                        style: TextStyle(fontSize: 11, color: Color(0xFF6B7280))),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _notesController,
                maxLines: 3,
                maxLength: 150,
                decoration: InputDecoration(
                  hintText: 'Ex: Please bring a ladder for high-ceiling lamp repair...',
                  hintStyle: const TextStyle(
                      fontSize: 13, color: Color(0xFF9CA3AF)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Color(0xFF1E3A8A), width: 1.5),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Booking summary box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBEB),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        color: Color(0xFF6B7280), size: 16),
                    const SizedBox(width: 8),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                            fontSize: 13, color: Color(0xFF6B7280)),
                        children: [
                          TextSpan(text: 'BOOKING SUMMARY\n'),
                          TextSpan(text: 'You are booking for '),
                          TextSpan(
                            text: '24 Oct',
                            style: TextStyle(
                                color: Color(0xFF1E3A8A),
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(text: ' at '),
                          TextSpan(
                            text: '10:30 AM',
                            style: TextStyle(
                                color: Color(0xFF1E3A8A),
                                fontWeight: FontWeight.w700),
                          ),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Confirm button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _confirmBooking,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3A8A),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text(
                    'Confirm Booking',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline,
                      size: 14, color: Color(0xFF9CA3AF)),
                  SizedBox(width: 6),
                  Text('Verified Professionals & Secure Payment',
                      style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildCalendarRows() {
    // October 2024 calendar - 1st is Tuesday
    List<int?> days = [
      null, null, 1, 2, 3, 4, 5,
      6, 7, 8, 9, 10, 11, 12,
      13, 14, 15, 16, 17, 18, 19,
      20, 21, 22, 23, 24, 25, 26,
      27, 28, 29, 30, 31, null, null,
    ];

    List<Widget> rows = [];
    for (int i = 0; i < days.length; i += 7) {
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(7, (j) {
            int? day = days[i + j];
            bool isSelected = day == selectedDay;
            return GestureDetector(
              onTap: day != null
                  ? () => setState(() => selectedDay = day)
                  : null,
              child: Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFFFBB700)
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    day != null ? '$day' : '',
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF374151),
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w400,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    }
    return rows;
  }

  Widget _slotGroup(IconData icon, String label, List<String> slots) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF9CA3AF)),
            const SizedBox(width: 6),
            Text(label,
                style: const TextStyle(
                    fontSize: 11,
                    letterSpacing: 1.2,
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 10,
          runSpacing: 8,
          children: slots.map((slot) {
            bool active = slot == selectedSlot;
            return GestureDetector(
              onTap: () => setState(() => selectedSlot = slot),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: active
                      ? const Color(0xFF1E3A8A)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: active
                        ? const Color(0xFF1E3A8A)
                        : const Color(0xFFE5E7EB),
                  ),
                ),
                child: Text(
                  slot,
                  style: TextStyle(
                    fontSize: 13,
                    color: active ? Colors.white : const Color(0xFF374151),
                    fontWeight: active ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _DayHeader extends StatelessWidget {
  final String letter;
  const _DayHeader(this.letter);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      child: Text(
        letter,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF9CA3AF),
            fontWeight: FontWeight.w500),
      ),
    );
  }
}