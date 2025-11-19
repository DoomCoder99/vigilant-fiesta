import '../models/subscription_category_model.dart';
import '../models/subscription_venue_model.dart';
import '../models/subscription_plan_model.dart';

/// Subscription Repository
/// 
/// Handles API calls for subscription-related data.
/// Following WDI Flutter Coding Standards.
/// 
/// TODO: Replace stub methods with actual API calls using ApiService pattern.
class SubscriptionRepository {
  // TODO: Replace with actual base URL
  static const String baseUrl = "https://api.example.com/subscriptions/";

  /// Get all subscription categories
  Future<List<SubscriptionCategoryModel>> getCategories() async {
    // TODO: Implement actual API call
    // final response = await ApiService.callApi(
    //   endpoint: 'categories',
    //   type: ApiType.get,
    // );
    // return (response['data'] as List)
    //     .map((e) => SubscriptionCategoryModel.fromJson(e))
    //     .toList();

    // Stub implementation
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      SubscriptionCategoryModel(
        id: 'sports_fitness',
        name: 'Sports & Fitness',
        iconPath: 'assets/subscriptions/sports/category_icon.png',
        venueCount: 248,
      ),
      SubscriptionCategoryModel(
        id: 'salon',
        name: 'Salon',
        iconPath: 'assets/subscriptions/salon/category_icon.png',
        venueCount: 0,
      ),
    ];
  }

  /// Get venues by category
  Future<List<SubscriptionVenueModel>> getVenuesByCategory(
      String categoryId) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500));

    if (categoryId == 'sports_fitness') {
      return [
        SubscriptionVenueModel(
          id: 'wimbledon_tennis',
          name: 'Wimbledon Tennis Club',
          categoryId: categoryId,
          location: 'Muscat',
          rating: 5.0,
          bookingCount: 248,
          imagePaths: ['assets/subscriptions/turf/wimbledon_hero.png'],
          earliestAvailability: '10:20 AM',
          isVerified: true,
        ),
        SubscriptionVenueModel(
          id: 'rolland_garos',
          name: 'Rolland Garos Club',
          categoryId: categoryId,
          location: 'Seeb',
          rating: 5.0,
          bookingCount: 248,
          imagePaths: ['assets/subscriptions/turf/rolland_hero.png'],
          earliestAvailability: '10:20 AM',
          isVerified: true,
        ),
        SubscriptionVenueModel(
          id: 'el_dorado_football',
          name: 'El Dorado Football Academy',
          categoryId: categoryId,
          location: 'Salalah',
          rating: 5.0,
          bookingCount: 248,
          imagePaths: ['assets/subscriptions/turf/el_dorado_hero.png'],
          earliestAvailability: '10:20 AM',
          isVerified: true,
        ),
        SubscriptionVenueModel(
          id: 'centre_court_football',
          name: 'Centre Court Football Club',
          categoryId: categoryId,
          location: 'Muscat',
          rating: 5.0,
          bookingCount: 248,
          imagePaths: ['assets/subscriptions/turf/centre_court_hero.png'],
          earliestAvailability: '10:20 AM',
          isVerified: true,
        ),
      ];
    }

    return [];
  }

  /// Get venue details
  Future<SubscriptionVenueModel> getVenueDetails(String venueId) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Stub implementation
    return SubscriptionVenueModel(
      id: venueId,
      name: 'Wimbledon Tennis Club',
      categoryId: 'sports_fitness',
      location: 'Muscat',
      rating: 5.0,
      bookingCount: 248,
      imagePaths: [
        'assets/subscriptions/turf/wimbledon_hero.png',
        'assets/subscriptions/turf/wimbledon_1.png',
        'assets/subscriptions/turf/wimbledon_2.png',
      ],
      earliestAvailability: '10:20 AM',
      isVerified: true,
      description:
          'Premium tennis facility with multiple court types and professional coaching.',
      metadata: {
        'size': '250 Sq.M',
        'weekday_rates': 'OMR 24/Hr',
        'weekend_rates': 'OMR 28/Hr',
      },
    );
  }

  /// Get subscription plans for a venue
  Future<List<SubscriptionPlanModel>> getPlansForVenue(
      String venueId) async {
    // TODO: Implement actual API call
    await Future.delayed(const Duration(milliseconds: 500));

    // Stub implementation
    return [
      SubscriptionPlanModel(
        id: 'plan_1_week',
        venueId: venueId,
        name: '1 Week Plan',
        billingCycle: BillingCycle.weekly,
        price: 100.0,
        description: 'Book your slots for one week stretch',
        sessionsPerCycle: 7,
      ),
      SubscriptionPlanModel(
        id: 'plan_1_month',
        venueId: venueId,
        name: '1 Month Plan',
        billingCycle: BillingCycle.monthly,
        price: 100.0,
        description: 'Sports enthusiast!',
        sessionsPerCycle: 30,
        isBestOption: true,
        perks: ['Priority booking', '30 sessions/month'],
      ),
      SubscriptionPlanModel(
        id: 'plan_6_months',
        venueId: venueId,
        name: '6 Months Plan',
        billingCycle: BillingCycle.semiAnnual,
        price: 600.0,
        description: 'Plan it like a professional',
        sessionsPerCycle: 180,
      ),
    ];
  }

  /// Create subscription from cart
  Future<Map<String, dynamic>> createSubscription({
    required String planId,
    required String venueId,
    required Map<String, dynamic> slotSelection,
    required String paymentMethodId,
  }) async {
    // TODO: Implement actual API call
    // final response = await ApiService.callApi(
    //   endpoint: 'subscriptions',
    //   type: ApiType.post,
    //   body: {
    //     'plan_id': planId,
    //     'venue_id': venueId,
    //     'slot_selection': slotSelection,
    //     'payment_method_id': paymentMethodId,
    //   },
    // );
    // return response;

    await Future.delayed(const Duration(milliseconds: 1000));
    return {
      'success': true,
      'subscription_id': 'sub_${DateTime.now().millisecondsSinceEpoch}',
      'message': 'Subscription created successfully',
    };
  }
}

