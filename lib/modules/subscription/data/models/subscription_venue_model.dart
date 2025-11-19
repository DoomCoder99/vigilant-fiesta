/// Subscription Venue Model
/// 
/// Represents a venue that offers subscriptions (e.g., Turf, Tennis Court, Salon).
/// Following WDI Flutter Coding Standards.
class SubscriptionVenueModel {
  final String id;
  final String name;
  final String categoryId;
  final String location;
  final double rating;
  final int bookingCount;
  final List<String> imagePaths;
  final String? earliestAvailability;
  final bool isVerified;
  final String? description;
  final Map<String, dynamic>? metadata; // Size, rates, etc.

  SubscriptionVenueModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.location,
    this.rating = 0.0,
    this.bookingCount = 0,
    this.imagePaths = const [],
    this.earliestAvailability,
    this.isVerified = false,
    this.description,
    this.metadata,
  });

  factory SubscriptionVenueModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionVenueModel(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['category_id'] as String,
      location: json['location'] as String,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      bookingCount: json['booking_count'] as int? ?? 0,
      imagePaths: (json['image_paths'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      earliestAvailability: json['earliest_availability'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      description: json['description'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category_id': categoryId,
      'location': location,
      'rating': rating,
      'booking_count': bookingCount,
      'image_paths': imagePaths,
      'earliest_availability': earliestAvailability,
      'is_verified': isVerified,
      'description': description,
      'metadata': metadata,
    };
  }
}

