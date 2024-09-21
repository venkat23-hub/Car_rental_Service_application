import 'package:flutter/material.dart';
import 'package:car_rental_service_application/screens/booking_screen_admin.dart';
import 'package:car_rental_service_application/screens/display_booking_data_screen.dart';
import 'display_car_screen.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Options',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent, // Background color for the AppBar
        elevation: 4.0, // Add shadow for a subtle depth effect
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white), // Icon color
            onPressed: () {
              // Handle filter action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayBookingDataScreen(userId: 'user123'),
                    ),
                  );
                },
                child: Text('See Bookings'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color for the button
                  disabledForegroundColor: Colors.white.withOpacity(0.38), disabledBackgroundColor: Colors.white.withOpacity(0.12), // Text color for the button
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingScreen(),
                    ),
                  );
                },
                child: Text('Add Car'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color for the button
                  disabledForegroundColor: Colors.white.withOpacity(0.38), disabledBackgroundColor: Colors.white.withOpacity(0.12), // Text color for the button
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
