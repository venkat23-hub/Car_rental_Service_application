import 'package:flutter/material.dart';
import 'package:car_rental_service_application/screens/bottom_bar.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoSizeAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _logoSizeAnimation = Tween<double>(begin: 0.4, end: 0.6).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.3, 0.7, curve: Curves.easeInOut),
    ));

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          // Animated Circular image at the top of the screen
          AnimatedBuilder(
            animation: _logoSizeAnimation,
            builder: (context, child) {
              return Container(
                height: MediaQuery.of(context).size.height * _logoSizeAnimation.value,
                width: double.infinity,
                child: ClipOval(
                  child: Image.asset(
                    'assets/MotorQ Rentals.png', // Add your logo image in the assets folder
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              );
            },
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text(
                      'Welcome to Car Rental Service',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        'Easily find and book cars for rent. Manage your bookings and explore our range of vehicles.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ScaleTransition(
                    scale: _scaleAnimation,
                    child: ElevatedButton(

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomBarScreen(),
                          ),
                        );
                      },
                      child: Text('Get Started',style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black26,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        textStyle: TextStyle(fontSize: 18),

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
