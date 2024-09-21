import 'package:flutter/material.dart';
import '../services/car_service.dart';
import '../models/car.dart';

class DisplayCarScreen extends StatelessWidget {
  final CarService carService = CarService();

  @override
  Widget build(BuildContext context) {
    // Get available cars synchronously
    final cars = carService.getAvailableCars();

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Cars'),
      ),
      body: cars.isEmpty
          ? Center(child: Text('No cars available.'))
          : ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          final car = cars[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Icon(Icons.directions_car, size: 50),
              title: Text('${car.make} ${car.model} (${car.year})'),
              subtitle: Text('Price: \$${car.rentRate}/day'),
            ),
          );
        },
      ),
    );
  }
}
