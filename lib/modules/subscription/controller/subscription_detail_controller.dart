import 'package:get/get.dart';
import '../data/models/subscription_venue_model.dart';
import '../data/models/subscription_plan_model.dart';
import '../data/models/subscription_slot_selection_model.dart';
import '../data/models/subscription_cart_item_model.dart';
import '../data/repository/subscription_repository.dart';

/// Subscription Detail Controller
/// 
/// Manages state for Turf/Venue detail screen with plan and slot selection.
/// Following WDI Flutter Coding Standards (GetX).
class SubscriptionDetailController extends GetxController {
  final SubscriptionRepository _repository = SubscriptionRepository();

  // Venue details
  final Rxn<SubscriptionVenueModel> venue = Rxn<SubscriptionVenueModel>();

  // Plans
  final RxList<SubscriptionPlanModel> plans = <SubscriptionPlanModel>[].obs;

  // Selected plan
  final Rxn<SubscriptionPlanModel> selectedPlan = Rxn<SubscriptionPlanModel>();

  // Selected court type (for tennis/turf venues)
  final RxString selectedCourtType = 'Clay Court'.obs;

  // Selected slot
  final Rxn<SubscriptionSlotSelectionModel> selectedSlot = Rxn<SubscriptionSlotSelectionModel>();

  // Starting date
  final Rx<DateTime?> startDate = Rx<DateTime?>(null);

  // Loading states
  final RxBool isLoadingVenue = false.obs;
  final RxBool isLoadingPlans = false.obs;

  // Pay monthly toggle
  final RxBool payMonthly = false.obs;

  // Current image index (for carousel)
  final RxInt currentImageIndex = 0.obs;

  String? venueId;

  @override
  void onInit() {
    super.onInit();
    // Get venue ID from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    venueId = args?['venueId'] as String?;
    
    if (venueId != null) {
      loadVenueDetails();
      loadPlans();
    }

    // Set default start date to tomorrow
    startDate.value = DateTime.now().add(const Duration(days: 1));
  }

  /// Load venue details
  Future<void> loadVenueDetails() async {
    if (venueId == null) return;

    isLoadingVenue.value = true;
    try {
      final v = await _repository.getVenueDetails(venueId!);
      venue.value = v;
    } catch (e) {
      // Handle error
      // TODO: Implement proper error logging
    } finally {
      isLoadingVenue.value = false;
    }
  }

  /// Load plans for venue
  Future<void> loadPlans() async {
    if (venueId == null) return;

    isLoadingPlans.value = true;
    try {
      final ps = await _repository.getPlansForVenue(venueId!);
      plans.value = ps;
      
      // Select first plan by default (or best option if available)
      if (ps.isNotEmpty) {
        final bestPlan = ps.firstWhere(
          (p) => p.isBestOption,
          orElse: () => ps.first,
        );
        selectedPlan.value = bestPlan;
      }
    } catch (e) {
      // Handle error
      // TODO: Implement proper error logging
    } finally {
      isLoadingPlans.value = false;
    }
  }

  /// Select a plan
  void selectPlan(SubscriptionPlanModel plan) {
    selectedPlan.value = plan;
  }

  /// Select court type
  void selectCourtType(String courtType) {
    selectedCourtType.value = courtType;
  }

  /// Select time slot
  void selectTimeSlot(String timeRange) {
    selectedSlot.value = SubscriptionSlotSelectionModel(
      daysOfWeek: [1, 3, 5], // Default: Mon, Wed, Fri
      timeRange: timeRange,
      startDate: startDate.value ?? DateTime.now().add(const Duration(days: 1)),
    );
  }

  /// Update start date
  void updateStartDate(DateTime date) {
    startDate.value = date;
    // Update slot selection if exists
    if (selectedSlot.value != null) {
      selectedSlot.value = selectedSlot.value!.copyWith(startDate: date);
    }
  }

  /// Toggle pay monthly
  void togglePayMonthly() {
    payMonthly.value = !payMonthly.value;
  }

  /// Calculate total price
  double get totalPrice {
    if (selectedPlan.value == null) return 0.0;
    
    if (payMonthly.value && selectedPlan.value!.billingCycle == BillingCycle.semiAnnual) {
      // If 6 months plan with monthly payment, divide by 6
      return selectedPlan.value!.price / 6;
    }
    
    return selectedPlan.value!.price;
  }

  /// Check if can proceed to cart
  bool get canProceed {
    return selectedPlan.value != null &&
        selectedSlot.value != null &&
        startDate.value != null;
  }

  /// Create cart item
  SubscriptionCartItemModel? createCartItem() {
    if (venue.value == null || selectedPlan.value == null) return null;

    return SubscriptionCartItemModel(
      id: 'cart_${DateTime.now().millisecondsSinceEpoch}',
      venue: venue.value!,
      plan: selectedPlan.value!,
      slotSelection: selectedSlot.value,
      courtType: selectedCourtType.value,
      price: totalPrice,
      payMonthly: payMonthly.value,
    );
  }

  /// Copy slot selection with updated fields
  SubscriptionSlotSelectionModel? copySlotSelection({
    List<int>? daysOfWeek,
    String? timeRange,
    DateTime? startDate,
  }) {
    if (selectedSlot.value == null) return null;

    return SubscriptionSlotSelectionModel(
      daysOfWeek: daysOfWeek ?? selectedSlot.value!.daysOfWeek,
      timeRange: timeRange ?? selectedSlot.value!.timeRange,
      startDate: startDate ?? selectedSlot.value!.startDate,
      endDate: selectedSlot.value!.endDate,
      isRecurring: selectedSlot.value!.isRecurring,
    );
  }
}

// Extension to add copyWith to SubscriptionSlotSelectionModel
extension SubscriptionSlotSelectionExtension on SubscriptionSlotSelectionModel {
  SubscriptionSlotSelectionModel copyWith({
    List<int>? daysOfWeek,
    String? timeRange,
    DateTime? startDate,
    DateTime? endDate,
    bool? isRecurring,
  }) {
    return SubscriptionSlotSelectionModel(
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      timeRange: timeRange ?? this.timeRange,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isRecurring: isRecurring ?? this.isRecurring,
    );
  }
}

