/// Subscription Plan Model
/// 
/// Represents a subscription plan (e.g., 1 Week, 1 Month, 6 Months).
/// Following WDI Flutter Coding Standards.
enum BillingCycle {
  weekly,
  monthly,
  quarterly,
  semiAnnual,
  annual,
}

class SubscriptionPlanModel {
  final String id;
  final String venueId;
  final String name; // e.g., "1 Week Plan", "1 Month Plan"
  final BillingCycle billingCycle;
  final double price;
  final String description;
  final int sessionsPerCycle;
  final bool isBestOption;
  final List<String> perks; // e.g., "Priority booking", "X sessions/month"

  SubscriptionPlanModel({
    required this.id,
    required this.venueId,
    required this.name,
    required this.billingCycle,
    required this.price,
    this.description = '',
    this.sessionsPerCycle = 0,
    this.isBestOption = false,
    this.perks = const [],
  });

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionPlanModel(
      id: json['id'] as String,
      venueId: json['venue_id'] as String,
      name: json['name'] as String,
      billingCycle: _parseBillingCycle(json['billing_cycle'] as String),
      price: (json['price'] as num).toDouble(),
      description: json['description'] as String? ?? '',
      sessionsPerCycle: json['sessions_per_cycle'] as int? ?? 0,
      isBestOption: json['is_best_option'] as bool? ?? false,
      perks: (json['perks'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );
  }

  static BillingCycle _parseBillingCycle(String cycle) {
    switch (cycle.toLowerCase()) {
      case 'weekly':
        return BillingCycle.weekly;
      case 'monthly':
        return BillingCycle.monthly;
      case 'quarterly':
        return BillingCycle.quarterly;
      case 'semi_annual':
      case 'semi-annual':
        return BillingCycle.semiAnnual;
      case 'annual':
        return BillingCycle.annual;
      default:
        return BillingCycle.monthly;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'venue_id': venueId,
      'name': name,
      'billing_cycle': billingCycle.name,
      'price': price,
      'description': description,
      'sessions_per_cycle': sessionsPerCycle,
      'is_best_option': isBestOption,
      'perks': perks,
    };
  }
}

