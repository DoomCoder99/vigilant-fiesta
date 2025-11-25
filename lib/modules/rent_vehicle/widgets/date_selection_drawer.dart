import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateSelectionDrawer extends StatefulWidget {
  final DateTime initialDate;
  final Function(DateTime) onDateSelected;

  const DateSelectionDrawer({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  @override
  State<DateSelectionDrawer> createState() => _DateSelectionDrawerState();
}

class _DateSelectionDrawerState extends State<DateSelectionDrawer> {
  late DateTime selectedDate;
  late DateTime currentMonth;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    currentMonth = DateTime(selectedDate.year, selectedDate.month);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Date',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF162028),
                      fontFamily: 'Figtree',
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      'assets/rent_vehicle/icons/close_small.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Month navigation
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: _previousMonth,
                    child: Image.asset(
                      'assets/rent_vehicle/icons/chevron_backward.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                  Text(
                    DateFormat('MMMM yyyy').format(currentMonth),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF162028),
                      fontFamily: 'Figtree',
                      letterSpacing: 0.24,
                    ),
                  ),
                  GestureDetector(
                    onTap: _nextMonth,
                    child: Image.asset(
                      'assets/rent_vehicle/icons/chevron_forward.png',
                      width: 20,
                      height: 20,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Calendar grid
              _buildCalendarGrid(),
              const SizedBox(height: 24),

              // Set Date button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => widget.onDateSelected(selectedDate),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7132F4),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Set Date',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Figtree',
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        'assets/rent_vehicle/icons/chevron_forward.png',
                        width: 20,
                        height: 20,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final firstDayOfMonth = DateTime(currentMonth.year, currentMonth.month, 1);
    final lastDayOfMonth = DateTime(currentMonth.year, currentMonth.month + 1, 0);
    final startWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday

    final List<DateTime?> days = [];

    // Add trailing days from previous month (hidden/transparent)
    for (int i = startWeekday - 1; i >= 0; i--) {
      days.add(null); // We'll render empty cells
    }

    // Add current month's days
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      days.add(DateTime(currentMonth.year, currentMonth.month, day));
    }

    // Add leading days to complete the grid
    final remainingCells = 7 - (days.length % 7);
    if (remainingCells < 7) {
      for (int i = 0; i < remainingCells; i++) {
        days.add(null);
      }
    }

    return Column(
      children: [
        for (int row = 0; row < (days.length / 7).ceil(); row++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int col = 0; col < 7; col++)
                  if (row * 7 + col < days.length)
                    _buildDayCell(days[row * 7 + col])
                  else
                    const SizedBox(width: 40, height: 40),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDayCell(DateTime? date) {
    if (date == null) {
      return const SizedBox(width: 40, height: 40);
    }

    final isSelected = _isSameDay(date, selectedDate);
    final isPast = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

    Color backgroundColor = Colors.transparent;
    Color textColor = const Color(0xFF162028);
    FontWeight fontWeight = FontWeight.w600;

    if (isSelected) {
      backgroundColor = const Color(0xFF7132F4);
      textColor = Colors.white;
      fontWeight = FontWeight.w600;
    }

    if (isPast && !isSelected) {
      textColor = const Color(0x66162028); // 40% opacity
      fontWeight = FontWeight.w400;
    }

    return GestureDetector(
      onTap: isPast ? null : () {
        setState(() {
          selectedDate = date;
        });
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            date.day.toString().padLeft(2, '0'),
            style: TextStyle(
              fontSize: 10,
              fontWeight: fontWeight,
              color: textColor,
              fontFamily: 'Figtree',
            ),
          ),
        ),
      ),
    );
  }

  void _previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    });
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

