import 'package:flutter/material.dart';
import '../models/car.dart';
import 'booking_screen_user.dart'; // Import the BookingScreenUser

class CarDetailsScreen extends StatelessWidget {
  final Car car; // Receive the Car object

  CarDetailsScreen({required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display car details
            Text(
              '${car.make} ${car.model} (${car.year})',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Licence Number: ${car.licenceNumber}'),
            Text('Location: ${car.location}'),
            Text('Price: \$${car.rentRate}/day'),
            SizedBox(height: 20),
            Text(
              'Availability: ${car.isAvailable ? 'Available' : 'Not Available'}',
              style: TextStyle(
                color: car.isAvailable ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (car.isAvailable) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingScreenUser(car: car),
                    ),
                  );
                } else {
                  // Show a message if the car is not available
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Unavailable'),
                      content: Text('This car is currently not available for booking.'),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text('Book This Car'),
            ),
          ],
        ),
      ),
    );
  }
}
