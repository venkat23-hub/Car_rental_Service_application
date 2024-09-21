import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/booking.dart';
import '../models/customer.dart';
import '../services/booking_service.dart'; // Ensure you have the correct import

class DisplayBookingDataScreen extends StatefulWidget {
  final String userId;

  DisplayBookingDataScreen({required this.userId});

  @override
  _DisplayBookingDataScreenState createState() => _DisplayBookingDataScreenState();
}

class _DisplayBookingDataScreenState extends State<DisplayBookingDataScreen> with SingleTickerProviderStateMixin {
  late Future<List<Booking>> _bookingsFuture;
  late Map<String, Customer> _customerMap;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _bookingsFuture = BookingService().getBookingsForUser(widget.userId);
    _customerMap = {}; // Initialize as empty
    _fetchCustomers(); // Fetch customers from Firebase

    // Set up animations
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.2), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  Future<void> _fetchCustomers() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('customers').get();
      final customers = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Customer.fromMap(data);
      }).toList();

      setState(() {
        _customerMap = {for (var customer in customers) customer.id: customer};
      });

      // Start animations
      _controller.forward();
    } catch (e) {
      print('Error retrieving customers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookings'),
        backgroundColor: Colors.blueAccent, // Optional: Color for the AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blueGrey[50]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FutureBuilder<List<Booking>>(
          future: _bookingsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No bookings found.'));
            } else {
              final bookings = snapshot.data!;
              return ListView.builder(
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  final customer = _customerMap[booking.customerId] ?? Customer(
                    id: 'unknown',
                    name: 'Unknown',
                    contact: 'N/A',
                    dlImage: 'assets/licence.jpeg', // Fallback image
                  );

                  return SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: customer.dlImage.isNotEmpty
                              ? Image.asset(customer.dlImage, width: 50, height: 50, fit: BoxFit.cover)
                              : null,
                          title: Text('Car ID: ${booking.carId}'),
                          subtitle: Text(
                            'Booked by: ${customer.name}\n'
                                'Start Date: ${booking.startDate.toLocal().toString().split(' ')[0]}\n'
                                'End Date: ${booking.endDate.toLocal().toString().split(' ')[0]}\n'
                                'Total Price: \$${booking.price}',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
