// apartment_model.dart
import 'dart:convert';

class ApartmentModel {
  final int id;
  final String title;
  final String description;
  final String governorate;
  final String city;
  final String address;
  final double pricePerDay;
  final int roomsCount;
  final int apartmentSize;
  final double avgRating;
  final List<String> imageUrls;
  bool isFavorite;
  final String ownerName;

  ApartmentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.governorate,
    required this.city,
    required this.address,
    required this.pricePerDay,
    required this.roomsCount,
    required this.apartmentSize,
    required this.avgRating,
    required this.imageUrls,
    required this.isFavorite,
    required this.ownerName,
  });

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    List<String> parsedImages = [];
    if (json["images"] != null) {
      try {
        if (json["images"] is String) {
          var decoded = jsonDecode(json["images"]);
          parsedImages = List<String>.from(decoded);
        } else if (json["images"] is List) {
          parsedImages = List<String>.from(json["images"]);
        }
      } catch (e) {}
    }
    double rating = 0.0;
    if (json["avg_rating"] != null) {
      rating = double.tryParse(json["avg_rating"].toString()) ?? 0.0;
    }
    return ApartmentModel(
      id: json["id"] ?? 0,
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      governorate: json["governorate"] ?? "",
      city: json["city"] ?? "",
      address: json["address"] ?? "",
      pricePerDay: double.tryParse(json["price_per_day"].toString()) ?? 0.0,
      roomsCount: int.tryParse(json["rooms_count"].toString()) ?? 0,
      apartmentSize: int.tryParse(json["apartment_size"].toString()) ?? 0,
      avgRating: rating,
      imageUrls: parsedImages,
      isFavorite: json["is_favorite"] == true || json["is_favorite"] == 1,
      ownerName: json["owner"] != null ? json["owner"]["name"] ?? "Unknown" : "Unknown",
    );
  }
}
