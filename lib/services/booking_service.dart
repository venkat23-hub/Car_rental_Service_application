import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/booking.dart';

class BookingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a booking to Firestore
  Future<void> addBooking(Booking booking) async {
    try {
      await _firestore.collection('bookings').doc(booking.id).set(booking.toMap());
    } catch (e) {
      print('Error adding booking: $e');
    }
  }

  // Get bookings for a specific user
  Future<List<Booking>> getBookingsForUser(String userId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('bookings')
          .where('customerId', isEqualTo: userId)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Booking.fromMap(data);
      }).toList();
    } catch (e) {
      print('Error retrieving bookings: $e');
      return [];
    }
  }
}
