class AddonModel {
  final String id;
  final String name;
  final double price;
  final String imagePath;
  final double rating;
  final int quantity;

  AddonModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.rating,
    this.quantity = 0,
  });

  factory AddonModel.fromJson(Map<String, dynamic> json) {
    return AddonModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      imagePath: json['imagePath'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'rating': rating,
      'quantity': quantity,
    };
  }

  AddonModel copyWith({
    String? id,
    String? name,
    double? price,
    String? imagePath,
    double? rating,
    int? quantity,
  }) {
    return AddonModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
    );
  }
}

