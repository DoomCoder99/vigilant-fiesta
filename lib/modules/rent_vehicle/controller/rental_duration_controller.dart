import 'package:get/get.dart';
import 'rent_vehicle_controller.dart';
import 'rent_cart_controller.dart';

enum RentalType { dayWise, hourly }

class RentalDurationController extends GetxController {
  // Current rental type (tab selection)
  final Rx<RentalType> rentalType = RentalType.dayWise.obs;

  // Day-wise rental state
  final Rxn<DateTime> startDate = Rxn<DateTime>();
  final Rxn<DateTime> endDate = Rxn<DateTime>();

  // Hourly rental state
  final Rxn<String> startHour = Rxn<String>();
  final Rxn<String> endHour = Rxn<String>();
  final Rxn<DateTime> rentalDate = Rxn<DateTime>();

  // Calendar navigation
  final Rx<DateTime> currentMonth = DateTime.now().obs;

  // Getters for computed values
  int? get totalDays {
    if (startDate.value != null && endDate.value != null) {
      return endDate.value!.difference(startDate.value!).inDays + 1;
    }
    return null;
  }

  int? get totalHours {
    if (startHour.value != null && endHour.value != null) {
      final start = _parseTimeString(startHour.value!);
      final end = _parseTimeString(endHour.value!);
      
      int diff = end - start;
      if (diff < 0) {
        diff += 24; // Handle overnight rentals
      }
      return diff;
    }
    return null;
  }

  bool get canApply {
    if (rentalType.value == RentalType.dayWise) {
      return startDate.value != null && endDate.value != null;
    } else {
      return startHour.value != null && endHour.value != null && rentalDate.value != null;
    }
  }

  // Methods
  void switchRentalType(RentalType type) {
    rentalType.value = type;
  }

  void selectDayWiseDate(DateTime date) {
    if (startDate.value == null || (startDate.value != null && endDate.value != null)) {
      // Start new selection
      startDate.value = date;
      endDate.value = null;
    } else if (startDate.value != null && endDate.value == null) {
      // Complete the range
      if (date.isBefore(startDate.value!)) {
        // If selected date is before start, swap them
        endDate.value = startDate.value;
        startDate.value = date;
      } else {
        endDate.value = date;
      }
    }
  }

  bool isDateSelected(DateTime date) {
    if (startDate.value == null) return false;
    
    if (endDate.value == null) {
      return _isSameDay(date, startDate.value!);
    }
    
    return _isSameDay(date, startDate.value!) || _isSameDay(date, endDate.value!);
  }

  bool isDateInRange(DateTime date) {
    if (startDate.value == null || endDate.value == null) return false;
    
    return date.isAfter(startDate.value!.subtract(const Duration(days: 1))) &&
           date.isBefore(endDate.value!.add(const Duration(days: 1)));
  }

  void selectHourlyTime(String time) {
    if (startHour.value == null || (startHour.value != null && endHour.value != null)) {
      // Start new selection
      startHour.value = time;
      endHour.value = null;
    } else if (startHour.value != null && endHour.value == null) {
      // Complete the range
      endHour.value = time;
    }
  }

  bool isTimeSelected(String time) {
    return time == startHour.value || time == endHour.value;
  }

  bool isTimeInRange(String time) {
    if (startHour.value == null || endHour.value == null) return false;
    
    final current = _parseTimeString(time);
    final start = _parseTimeString(startHour.value!);
    final end = _parseTimeString(endHour.value!);
    
    if (start < end) {
      return current > start && current < end;
    } else {
      // Handle overnight range
      return current > start || current < end;
    }
  }

  void setRentalDate(DateTime date) {
    rentalDate.value = date;
  }

  void previousMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month - 1,
    );
  }

  void nextMonth() {
    currentMonth.value = DateTime(
      currentMonth.value.year,
      currentMonth.value.month + 1,
    );
  }

  void clearSelection() {
    startDate.value = null;
    endDate.value = null;
    startHour.value = null;
    endHour.value = null;
  }

  void apply() {
    if (!canApply) return;
    
    // Save rental details to cart controller
    final cartController = Get.find<RentCartController>();
    final vehicleController = Get.find<RentVehicleController>();
    
    cartController.setRentalDetails(
      vehicle: vehicleController.selectedVehicle.value,
      start: rentalType.value == RentalType.dayWise ? startDate.value : rentalDate.value,
      end: rentalType.value == RentalType.dayWise ? endDate.value : rentalDate.value,
      location: cartController.pickupLocation.value,
    );
    
    Get.back(result: {
      'type': rentalType.value,
      'startDate': startDate.value,
      'endDate': endDate.value,
      'startHour': startHour.value,
      'endHour': endHour.value,
      'rentalDate': rentalDate.value,
    });
  }

  // Helper methods
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int _parseTimeString(String time) {
    // Parse time string like "08:00" or "03:00 pm"
    final cleanTime = time.toLowerCase().replaceAll(' ', '');
    
    int hour;
    if (cleanTime.contains('pm') || cleanTime.contains('am')) {
      final isPM = cleanTime.contains('pm');
      final timeStr = cleanTime.replaceAll('pm', '').replaceAll('am', '');
      hour = int.parse(timeStr.split(':')[0]);
      if (isPM && hour != 12) hour += 12;
      if (!isPM && hour == 12) hour = 0;
    } else {
      hour = int.parse(time.split(':')[0]);
    }
    
    return hour;
  }

  @override
  void onClose() {
    clearSelection();
    super.onClose();
  }
}

