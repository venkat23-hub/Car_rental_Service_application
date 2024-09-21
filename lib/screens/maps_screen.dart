import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/car.dart'; // Ensure this path is correct

class MapScreen extends StatelessWidget {
  final List<Car> cars;

  MapScreen({required this.cars});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(
          'Available car locations',
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
      body: cars.isEmpty
          ? Center(child: Text('No cars available',style: TextStyle(color: Colors.black),))
          : SizedBox.expand( // Use SizedBox to ensure GoogleMap has a defined size
        child: GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(13.573077654399508, 80.00716280293129), // Default location
            zoom: 10,
          ),
          markers: _createMarkers(),
          onMapCreated: (GoogleMapController controller) {
            // Optional: you can add additional setup for the map here
          },
        ),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return cars.map((car) {
      return Marker(
        markerId: MarkerId(car.id),
        position: car.location,
        infoWindow: InfoWindow(
          title: '${car.make} ${car.model}',
          snippet: 'Rent: \$${car.rentRate} per day\nRating: ${car.rating}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
    }).toSet();
  }
}
