import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import

class Booking {
  final String id;
  final String carId;
  final String customerId;
  final DateTime startDate;
  final DateTime endDate;
  final double price;
  final Duration duration;
  final String status;
  final String paymentStatus;

  Booking({
    required this.id,
    required this.carId,
    required this.customerId,
    required this.startDate,
    required this.endDate,
    required this.price,
    required this.duration,
    required this.status,
    required this.paymentStatus,
  });

  // Example of a factory method to create a Booking from a map
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      carId: map['carId'],
      customerId: map['customerId'],
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      price: map['price'],
      duration: Duration(days: map['duration']),
      status: map['status'],
      paymentStatus: map['paymentStatus'],
    );
  }

  // Example of a method to convert a Booking to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'carId': carId,
      'customerId': customerId,
      'startDate': Timestamp.fromDate(startDate), // Convert DateTime to Timestamp
      'endDate': Timestamp.fromDate(endDate), // Convert DateTime to Timestamp
      'price': price,
      'duration': duration.inDays,
      'status': status,
      'paymentStatus': paymentStatus,
    };
  }
}
