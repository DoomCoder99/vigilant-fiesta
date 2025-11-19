import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../controller/rental_duration_controller.dart';
import 'date_selection_drawer.dart';

class HourlyRentalSelector extends StatelessWidget {
  const HourlyRentalSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<RentalDurationController>();

    // Initialize rental date if not set
    if (controller.rentalDate.value == null) {
      controller.setRentalDate(DateTime.now());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date selector
          Obx(() => _buildDateSelector(context, controller)),
          const SizedBox(height: 24),

          // Time grid (AM times)
          _buildTimeGrid(controller, _getAMTimes()),
          const SizedBox(height: 16),

          // Time grid (PM times)
          _buildTimeGrid(controller, _getPMTimes()),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, RentalDurationController controller) {
    final date = controller.rentalDate.value ?? DateTime.now();
    final formattedDate = DateFormat('dd MMM yyyy').format(date);

    return GestureDetector(
      onTap: () => _showDatePicker(context, controller),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(
                Icons.calendar_today,
                size: 16,
                color: Color(0xFF7132F4),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'On date',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Color(0x99162028),
                    fontFamily: 'Figtree',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF162028),
                    fontFamily: 'Figtree',
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Text(
              'Change',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF7132F4),
                fontFamily: 'Figtree',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeGrid(RentalDurationController controller, List<String> times) {
    return Obx(() => Wrap(
      spacing: 12,
      runSpacing: 12,
      children: times.map((time) => _buildTimeCell(controller, time)).toList(),
    ));
  }

  Widget _buildTimeCell(RentalDurationController controller, String time) {
    final isSelected = controller.isTimeSelected(time);
    final isInRange = controller.isTimeInRange(time);

    Color backgroundColor = Colors.white;
    Color textColor = const Color(0xFF162028);
    Color borderColor = const Color(0xFFEBEBEB);
    FontWeight fontWeight = FontWeight.w400;

    if (isSelected) {
      backgroundColor = const Color(0xFF7132F4);
      textColor = Colors.white;
      borderColor = const Color(0xFF7132F4);
      fontWeight = FontWeight.w600;
    } else if (isInRange) {
      backgroundColor = const Color(0xFFEBEFF5);
      textColor = const Color(0xFF7132F4);
      borderColor = const Color(0xFF7132F4);
    }

    return GestureDetector(
      onTap: () => controller.selectHourlyTime(time),
      child: Container(
        width: 65,
        height: 36,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(
          child: Text(
            time,
            style: TextStyle(
              fontSize: 12,
              fontWeight: fontWeight,
              color: textColor,
              fontFamily: 'Figtree',
            ),
          ),
        ),
      ),
    );
  }

  void _showDatePicker(BuildContext context, RentalDurationController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DateSelectionDrawer(
        initialDate: controller.rentalDate.value ?? DateTime.now(),
        onDateSelected: (date) {
          controller.setRentalDate(date);
          Navigator.pop(context);
        },
      ),
    );
  }

  List<String> _getAMTimes() {
    return [
      '12:00',
      '01:00',
      '02:00',
      '03:00',
      '04:00',
      '05:00',
      '06:00',
      '07:00',
      '08:00',
      '09:00',
      '10:00',
      '11:00',
    ];
  }

  List<String> _getPMTimes() {
    return [
      '12:00',
      '01:00',
      '02:00',
      '03:00',
      '04:00',
      '05:00',
      '06:00',
      '07:00',
      '08:00',
      '09:00',
      '10:00',
      '11:00',
    ];
  }
}

