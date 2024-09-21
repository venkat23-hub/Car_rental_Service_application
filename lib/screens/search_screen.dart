import 'package:flutter/material.dart';
import '../services/car_service.dart';
import '../models/car.dart';
import 'booking_screen_user.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  final CarService _carService = CarService();
  List<Car> _cars = [];
  List<Car> _filteredCars = [];

  String _searchQuery = '';
  String _selectedMMY = 'All';
  double _minRent = 50.0;
  double _maxRent = 100.0;

  late AnimationController _controller;
  late Animation<double> _searchBarAnimation;
  late Animation<double> _dropdownAnimation;
  late Animation<double> _sliderAnimation;

  @override
  void initState() {
    super.initState();

    _cars = _carService.getAllCars();
    _filteredCars = _cars;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();

    _searchBarAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _dropdownAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _sliderAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  void _filterCars() {
    setState(() {
      _filteredCars = _cars.where((car) {
        final matchesQuery = _searchQuery.isEmpty ||
            car.make.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            car.model.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            car.licenceNumber.toLowerCase().contains(_searchQuery.toLowerCase());
        final matchesMMY = _selectedMMY == 'All' ||
            '${car.make} ${car.model} ${car.year}'.contains(_selectedMMY);
        final matchesRent = car.rentRate >= _minRent && car.rentRate <= _maxRent;

        return matchesQuery && matchesMMY && matchesRent;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Cars',
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
        child: Column(
          children: [
            ScaleTransition(
              scale: _searchBarAnimation,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Search',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                    _filterCars();
                  });
                },
              ),
            ),
            SizedBox(height: 16),
            ScaleTransition(
              scale: _dropdownAnimation,
              child: DropdownButton<String>(
                value: _selectedMMY,
                items: <String>['All', 'Make Model Year'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMMY = newValue!;
                    _filterCars();
                  });
                },
                isExpanded: true,
              ),
            ),
            SizedBox(height: 16),
            ScaleTransition(
              scale: _sliderAnimation,
              child: RangeSlider(
                values: RangeValues(_minRent, _maxRent),
                min: 50.0,
                max: 100.0,
                divisions: 10,
                labels: RangeLabels(
                  '\$${_minRent.toStringAsFixed(0)}',
                  '\$${_maxRent.toStringAsFixed(0)}',
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _minRent = values.start;
                    _maxRent = values.end;
                    _filterCars();
                  });
                },
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredCars.length,
                itemBuilder: (context, index) {
                  final car = _filteredCars[index];
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      final animation = Tween<double>(begin: 0.95, end: 1.0).animate(
                        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                      );

                      return ScaleTransition(
                        scale: animation,
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue.shade100, Colors.blue.shade200],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text(
                                '${car.make} ${car.model} (${car.year})',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('Rent: \$${car.rentRate} per day'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingScreenUser(
                                      car: car, // Pass the car object
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
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
