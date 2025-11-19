class VehicleModel {
  final String id;
  final String name;
  final String category;
  final String brand;
  final double pricePerDay;
  final String imagePath;
  final double rating;
  final int totalBookings;
  final VehicleSpecs specs;
  final bool isVerified;
  final String? rentalAgency;

  VehicleModel({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.pricePerDay,
    required this.imagePath,
    required this.rating,
    required this.totalBookings,
    required this.specs,
    this.isVerified = true,
    this.rentalAgency,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? '',
      brand: json['brand'] ?? '',
      pricePerDay: (json['pricePerDay'] ?? 0).toDouble(),
      imagePath: json['imagePath'] ?? '',
      rating: (json['rating'] ?? 0).toDouble(),
      totalBookings: json['totalBookings'] ?? 0,
      specs: VehicleSpecs.fromJson(json['specs'] ?? {}),
      isVerified: json['isVerified'] ?? true,
      rentalAgency: json['rentalAgency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'brand': brand,
      'pricePerDay': pricePerDay,
      'imagePath': imagePath,
      'rating': rating,
      'totalBookings': totalBookings,
      'specs': specs.toJson(),
      'isVerified': isVerified,
      'rentalAgency': rentalAgency,
    };
  }
}

class VehicleSpecs {
  final int year;
  final int seats;
  final String transmission;
  final String fuelType;
  final String engineCapacity;
  final List<String> features;

  VehicleSpecs({
    required this.year,
    required this.seats,
    required this.transmission,
    required this.fuelType,
    required this.engineCapacity,
    this.features = const [],
  });

  factory VehicleSpecs.fromJson(Map<String, dynamic> json) {
    return VehicleSpecs(
      year: json['year'] ?? DateTime.now().year,
      seats: json['seats'] ?? 4,
      transmission: json['transmission'] ?? 'Manual',
      fuelType: json['fuelType'] ?? 'Petrol',
      engineCapacity: json['engineCapacity'] ?? '2000 Cc',
      features: json['features'] != null 
          ? List<String>.from(json['features']) 
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'seats': seats,
      'transmission': transmission,
      'fuelType': fuelType,
      'engineCapacity': engineCapacity,
      'features': features,
    };
  }
}

class VehicleCategoryModel {
  final String id;
  final String name;
  final String iconPath;
  final int vehicleCount;

  VehicleCategoryModel({
    required this.id,
    required this.name,
    required this.iconPath,
    required this.vehicleCount,
  });
}

