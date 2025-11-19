/// Subscription Category Model
/// 
/// Represents a subscription category (e.g., Sports & Fitness, Salon).
/// Following WDI Flutter Coding Standards.
class SubscriptionCategoryModel {
  final String id;
  final String name;
  final String? iconPath;
  final String? description;
  final int venueCount;

  SubscriptionCategoryModel({
    required this.id,
    required this.name,
    this.iconPath,
    this.description,
    this.venueCount = 0,
  });

  factory SubscriptionCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      iconPath: json['icon_path'] as String?,
      description: json['description'] as String?,
      venueCount: json['venue_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon_path': iconPath,
      'description': description,
      'venue_count': venueCount,
    };
  }
}

