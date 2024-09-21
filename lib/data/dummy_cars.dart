import 'package:google_maps_flutter/google_maps_flutter.dart'; // For map integration
import '../models/car.dart';

List<Car> dummyCars = [
  Car(
    id: '1',
    make: 'Toyota',
    model: 'Corolla',
    year: 2020,
    licenceNumber: 'ABC123',
    rentRate: 50.0,
    location: LatLng(13.564851278471778, 79.99935361863072), // Example coordinates for Downtown
    isAvailable: true,
    rating: 4.2,
  ),
  Car(
    id: '2',
    make: 'Honda',
    model: 'Civic',
    year: 2021,
    licenceNumber: 'XYZ789',
    rentRate: 60.0,
    location: LatLng(13.58164360309397, 80.02200909247718), // Example coordinates for Uptown
    isAvailable: true,
    rating: 4.5,
  ),
  Car(
    id: '3',
    make: 'Ford',
    model: 'Focus',
    year: 2019,
    licenceNumber: 'LMN456',
    rentRate: 55.0,
    location: LatLng(13.532364396006507, 80.05882423747767), // Example coordinates for Suburb
    isAvailable: true,
    rating: 4.0,
  ),
  Car(
    id: '4',
    make: 'Chevrolet',
    model: 'Malibu',
    year: 2022,
    licenceNumber: 'GHI789',
    rentRate: 70.0,
    location: LatLng(13.653871211613097, 80.01826091110735), // Example coordinates for Airport
    isAvailable: true,
    rating: 4.7,
  ),
  Car(
    id: '5',
    make: 'BMW',
    model: 'X3',
    year: 2023,
    licenceNumber: 'JKL123',
    rentRate: 90.0,
    location: LatLng(13.689786796158046, 80.02772379089275), // Example coordinates for City Center
    isAvailable: true,
    rating: 4.8,
  ),
  Car(
    id: '6',
    make: 'Nissan',
    model: 'Altima',
    year: 2023,
    licenceNumber: 'NOP123',
    rentRate: 65.0,
    location: LatLng(13.54650422976162, 79.97878526280512), // Example coordinates for Suburb
    isAvailable: true,
    rating: 4.3,
  ),
  Car(
    id: '7',
    make: 'Volkswagen',
    model: 'Jetta',
    year: 2022,
    licenceNumber: 'QRS456',
    rentRate: 70.0,
    location: LatLng(13.514334434201398, 80.0063230684277), // Example coordinates for Airport
    isAvailable: true,
    rating: 4.6,
  ),
  Car(
    id: '8',
    make: 'Mazda',
    model: 'CX-5',
    year: 2021,
    licenceNumber: 'TUV789',
    rentRate: 80.0,
    location: LatLng(13.622738969873973, 79.9611477289181), // Example coordinates for City Center
    isAvailable: true,
    rating: 4.4,
  ),
  Car(
    id: '9',
    make: 'Hyundai',
    model: 'Elantra',
    year: 2020,
    licenceNumber: 'WXY123',
    rentRate: 55.0,
    location: LatLng(13.659596463903299, 79.98989911416959), // Example coordinates for Downtown
    isAvailable: true,
    rating: 4.1,
  ),
  Car(
    id: '10',
    make: 'Kia',
    model: 'Sportage',
    year: 2023,
    licenceNumber: 'ZAB456',
    rentRate: 75.0,
    location: LatLng(13.60906456638793, 80.04984881107691), // Example coordinates for Uptown
    isAvailable: true,
    rating: 4.7,
  ),
];
