import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/rental_duration_controller.dart';

class DayWiseRentalSelector extends StatelessWidget {
  const DayWiseRentalSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RentalDurationController>();

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Weekday headers
          _buildWeekdayHeaders(),
          const SizedBox(height: 16),

          // Calendar months
          Obx(() => _buildCalendarMonths(controller)),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeaders() {
    const weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: weekdays.map((day) => SizedBox(
        width: 40,
        child: Center(
          child: Text(
            day,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color(0xFF162028),
              fontFamily: 'Figtree',
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildCalendarMonths(RentalDurationController controller) {
    // Show current month and next month
    final currentMonth = controller.currentMonth.value;
    final nextMonth = DateTime(currentMonth.year, currentMonth.month + 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildMonthCalendar(controller, currentMonth),
        const SizedBox(height: 24),
        _buildMonthCalendar(controller, nextMonth),
      ],
    );
  }

  Widget _buildMonthCalendar(RentalDurationController controller, DateTime month) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month label
        Text(
          DateFormat('MMMM yyyy').format(month),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF162028),
            fontFamily: 'Figtree',
          ),
        ),
        const SizedBox(height: 16),

        // Calendar grid
        _buildCalendarGrid(controller, month),
      ],
    );
  }

  Widget _buildCalendarGrid(RentalDurationController controller, DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);
    final startWeekday = firstDayOfMonth.weekday % 7; // 0 = Sunday

    // Calculate previous month's trailing days
    final prevMonthLastDay = DateTime(month.year, month.month, 0);
    final List<DateTime?> days = [];

    // Add trailing days from previous month (grayed out)
    for (int i = startWeekday - 1; i >= 0; i--) {
      days.add(DateTime(prevMonthLastDay.year, prevMonthLastDay.month, prevMonthLastDay.day - i));
    }

    // Add current month's days
    for (int day = 1; day <= lastDayOfMonth.day; day++) {
      days.add(DateTime(month.year, month.month, day));
    }

    // Add leading days from next month to complete the grid (optional)
    final remainingCells = 7 - (days.length % 7);
    if (remainingCells < 7) {
      for (int i = 1; i <= remainingCells; i++) {
        days.add(DateTime(month.year, month.month + 1, i));
      }
    }

    // Build grid
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
                    _buildDayCell(controller, days[row * 7 + col], month)
                  else
                    const SizedBox(width: 40, height: 40),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildDayCell(RentalDurationController controller, DateTime? date, DateTime currentMonth) {
    if (date == null) {
      return const SizedBox(width: 40, height: 40);
    }

    final isCurrentMonth = date.month == currentMonth.month;
    final isSelected = controller.isDateSelected(date);
    final isInRange = controller.isDateInRange(date);
    final isToday = _isToday(date);
    final isPast = date.isBefore(DateTime.now().subtract(const Duration(days: 1)));

    Color backgroundColor = Colors.transparent;
    Color textColor = const Color(0xFF162028);
    FontWeight fontWeight = FontWeight.w600;

    if (!isCurrentMonth) {
      textColor = const Color(0x66162028); // 40% opacity
      fontWeight = FontWeight.w400;
    }

    if (isSelected) {
      backgroundColor = const Color(0xFF7132F4);
      textColor = Colors.white;
      fontWeight = FontWeight.w600;
    } else if (isInRange) {
      backgroundColor = const Color(0xFFEBEFF5);
      textColor = const Color(0xFF7132F4);
    }

    if (isPast && !isSelected) {
      textColor = const Color(0x40162028); // Dimmed for past dates
    }

    return GestureDetector(
      onTap: (isPast && !isCurrentMonth) ? null : () {
        controller.selectDayWiseDate(date);
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

  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year && date.month == now.month && date.day == now.day;
  }
}

