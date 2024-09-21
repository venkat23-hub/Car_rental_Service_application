import 'package:flutter/material.dart';
import '../models/car.dart';
import '../models/booking.dart';
import '../services/booking_service.dart';
import 'display_booking_data_screen.dart'; // Import the new screen

class BookingScreenUser extends StatefulWidget {
  final Car car;

  BookingScreenUser({required this.car});

  @override
  _BookingScreenUserState createState() => _BookingScreenUserState();
}

class _BookingScreenUserState extends State<BookingScreenUser> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  DateTime? _startDate;
  DateTime? _endDate;
  int _days = 0;
  double? _price;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _price = widget.car.rentRate;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  void _calculateDays() {
    if (_startDate != null && _endDate != null) {
      setState(() {
        _days = _endDate!.difference(_startDate!).inDays;
        _animationController.forward().then((_) => _animationController.reverse());
      });
    }
  }

  void _submitBooking() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final booking = Booking(
        id: DateTime.now().toString(),
        carId: widget.car.id,
        customerId: 'user', // Replace with actual user ID
        startDate: _startDate!,
        endDate: _endDate!,
        price: _price! * _days,
        duration: Duration(days: _days),
        status: 'Booked',
        paymentStatus: 'Pending',
      );

      final bookingService = BookingService();
      await bookingService.addBooking(booking);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking confirmed!')),
      );

      // Navigate to the display bookings screen after booking confirmation
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DisplayBookingDataScreen(userId: 'user123'), // Pass actual user ID
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Car',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueAccent, // Background color for the AppBar
        elevation: 4.0, // Add shadow for a subtle depth effect
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Booking Details for ${widget.car.make} ${widget.car.model}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildDateField('Start Date', _startDate, (pickedDate) {
                if (pickedDate != null && pickedDate != _startDate) {
                  setState(() {
                    _startDate = pickedDate;
                    _calculateDays();
                  });
                }
              }),
              SizedBox(height: 20),
              _buildDateField('End Date', _endDate, (pickedDate) {
                if (pickedDate != null && pickedDate != _endDate) {
                  setState(() {
                    _endDate = pickedDate;
                    _calculateDays();
                  });
                }
              }),
              SizedBox(height: 20),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Text(
                  'Total Days: $_days',
                  key: ValueKey<int>(_days),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Text(
                  'Total Price: \$${_price! * _days}',
                  key: ValueKey<double>(_price! * _days),
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitBooking,
                child: Text('Confirm Booking'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
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

  Widget _buildDateField(String label, DateTime? date, void Function(DateTime?) onDatePicked) {
    return GestureDetector(
      onTap: () async {
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        onDatePicked(pickedDate);
      },
      child: AbsorbPointer(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            hintText: 'Select the $label',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          controller: TextEditingController(
            text: date != null ? date.toLocal().toString().split(' ')[0] : '',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
