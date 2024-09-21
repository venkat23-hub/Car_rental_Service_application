import 'package:flutter/material.dart';
import '../models/car.dart';
import '../services/car_service.dart';
import 'booking_screen_user.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final CarService carService = CarService();
  late Future<List<Car>> _availableCars;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _refreshCars();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  // Method to refresh the list of available cars
  void _refreshCars() {
    setState(() {
      _availableCars = Future.delayed(
        Duration(seconds: 1),
            () => carService.getAvailableCars(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Browse Cars',
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
      body: FutureBuilder<List<Car>>(
        future: _availableCars, // Use the future that fetches the available cars
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: FadeTransition(
                opacity: _animationController.drive(CurveTween(curve: Curves.easeIn)),
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No cars available.'));
          } else {
            final cars = snapshot.data!;
            return ListView.builder(
              itemCount: cars.length,
              itemBuilder: (context, index) {
                final car = cars[index];
                // Define colors for the ListTile
                final colors = [Colors.blueAccent, Colors.greenAccent, Colors.orangeAccent, Colors.redAccent];
                final color = colors[index % colors.length]; // Cycle through colors

                return AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final animation = Tween<double>(begin: 0.95, end: 1.0).animate(
                      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
                    );

                    return ScaleTransition(
                      scale: animation,
                      child: Card(
                        color: color, // Apply color
                        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          leading: Icon(Icons.directions_car, size: 50, color: Colors.white),
                          title: Text('${car.make} ${car.model} (${car.year})', style: TextStyle(color: Colors.white)),
                          subtitle: Text('Price: \$${car.rentRate}/day', style: TextStyle(color: Colors.white70)),
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookingScreenUser(car: car),
                              ),
                            );
                            _refreshCars(); // Refresh the car list after returning from booking screen
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
