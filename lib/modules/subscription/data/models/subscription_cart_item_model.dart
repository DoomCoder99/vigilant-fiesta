import '../models/subscription_plan_model.dart';
import '../models/subscription_venue_model.dart';
import '../models/subscription_slot_selection_model.dart';

/// Subscription Cart Item Model
/// 
/// Represents a subscription item in the cart.
/// Following WDI Flutter Coding Standards.
class SubscriptionCartItemModel {
  final String id;
  final SubscriptionVenueModel venue;
  final SubscriptionPlanModel plan;
  final SubscriptionSlotSelectionModel? slotSelection;
  final String? courtType; // e.g., "Clay Court", "Grass Court"
  final double price;
  final bool payMonthly; // Subscription mode toggle

  SubscriptionCartItemModel({
    required this.id,
    required this.venue,
    required this.plan,
    this.slotSelection,
    this.courtType,
    required this.price,
    this.payMonthly = false,
  });

  factory SubscriptionCartItemModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionCartItemModel(
      id: json['id'] as String,
      venue: SubscriptionVenueModel.fromJson(
          json['venue'] as Map<String, dynamic>),
      plan: SubscriptionPlanModel.fromJson(
          json['plan'] as Map<String, dynamic>),
      slotSelection: json['slot_selection'] != null
          ? SubscriptionSlotSelectionModel.fromJson(
              json['slot_selection'] as Map<String, dynamic>)
          : null,
      courtType: json['court_type'] as String?,
      price: (json['price'] as num).toDouble(),
      payMonthly: json['pay_monthly'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venue': venue.toJson(),
      'plan': plan.toJson(),
      'slot_selection': slotSelection?.toJson(),
      'court_type': courtType,
      'price': price,
      'pay_monthly': payMonthly,
    };
  }

  SubscriptionCartItemModel copyWith({
    String? id,
    SubscriptionVenueModel? venue,
    SubscriptionPlanModel? plan,
    SubscriptionSlotSelectionModel? slotSelection,
    String? courtType,
    double? price,
    bool? payMonthly,
  }) {
    return SubscriptionCartItemModel(
      id: id ?? this.id,
      venue: venue ?? this.venue,
      plan: plan ?? this.plan,
      slotSelection: slotSelection ?? this.slotSelection,
      courtType: courtType ?? this.courtType,
      price: price ?? this.price,
      payMonthly: payMonthly ?? this.payMonthly,
    );
  }
}

