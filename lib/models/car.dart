import 'package:google_maps_flutter/google_maps_flutter.dart';

class Car {
  final String id;
  final String make;
  final String model;
  final int year;
  final String licenceNumber;
  final double rentRate;
  final LatLng location;
  bool isAvailable; // Mutable to allow updating availability
  final double rating;

  Car({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.licenceNumber,
    required this.rentRate,
    required this.location,
    this.isAvailable = true,
    this.rating = 0.0,
  });

  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      id: map['id'],
      make: map['make'],
      model: map['model'],
      year: map['year'],
      licenceNumber: map['licenceNumber'],
      rentRate: map['rentRate'],
      location: LatLng(map['location']['lat'], map['location']['lng']),
      isAvailable: map['isAvailable'],
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'make': make,
      'model': model,
      'year': year,
      'licenceNumber': licenceNumber,
      'rentRate': rentRate,
      'location': {
        'lat': location.latitude,
        'lng': location.longitude,
      },
      'isAvailable': isAvailable,
      'rating': rating,
    };
  }
}
