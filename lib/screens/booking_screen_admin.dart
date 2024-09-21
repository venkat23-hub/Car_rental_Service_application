import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/car.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _carIdController = TextEditingController();
  final TextEditingController _makeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _rentRateController = TextEditingController();

  @override
  void dispose() {
    _carIdController.dispose();
    _makeController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _rentRateController.dispose();
    super.dispose();
  }

  Future<void> _addCarToFirestore(Car car) async {
    await FirebaseFirestore.instance.collection('cars').add({
      'id': car.id,
      'make': car.make,
      'model': car.model,
      'year': car.year,
      'rentRate': car.rentRate,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Car'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _carIdController,
                decoration: InputDecoration(
                  labelText: 'Car ID',
                  hintText: 'Enter the car ID',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the car ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _makeController,
                decoration: InputDecoration(
                  labelText: 'Make',
                  hintText: 'Enter the make of the car',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the make';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _modelController,
                decoration: InputDecoration(
                  labelText: 'Model',
                  hintText: 'Enter the model of the car',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the model';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(
                  labelText: 'Year',
                  hintText: 'Enter the year of the car',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the year';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _rentRateController,
                decoration: InputDecoration(
                  labelText: 'Rent Rate',
                  hintText: 'Enter the rent rate per day',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the rent rate';
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final car = Car(
                      id: _carIdController.text,
                      make: _makeController.text,
                      model: _modelController.text,
                      year: int.parse(_yearController.text),
                      rentRate: double.parse(_rentRateController.text), licenceNumber: '123rewe', location: LatLng(13.659596463903299, 79.98989911416959),
                    );
                    _addCarToFirestore(car);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Car added successfully!')),
                    );

                    _formKey.currentState!.reset();
                  }
                },
                child: Text('Add Car'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
