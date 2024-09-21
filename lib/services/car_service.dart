import '../models/car.dart';
import '../models/booking.dart';
import '../data/dummy_cars.dart';
import '../data/dummy_bookings.dart';

class CarService {
  List<Car> _cars = dummyCars; // Ensure dummyCars is defined correctly
  List<Booking> _bookings = dummyBookings; // Use dummy bookings data

  void updateCarAvailability() {
    for (var car in _cars) {
      car.isAvailable = !_bookings.any((booking) => booking.carId == car.id);
    }
  }

  List<Car> getAvailableCars() {
    updateCarAvailability();
    return _cars.where((car) => car.isAvailable).toList();
  }

  List<Car> getAllCars() {
    updateCarAvailability();
    return _cars;
  }

  Car? getCarById(String id) {
    updateCarAvailability();
    try {
      return _cars.firstWhere((car) => car.id == id && car.isAvailable);
    } catch (e) {
      return null;
    }
  }

  void addCar(Car car) {
    _cars.add(car);
  }

  void updateCar(Car updatedCar) {
    final index = _cars.indexWhere((car) => car.id == updatedCar.id);
    if (index != -1) {
      _cars[index] = updatedCar;
    }
  }

  void deleteCar(String id) {
    _cars.removeWhere((car) => car.id == id);
  }
}
