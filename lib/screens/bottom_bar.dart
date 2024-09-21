import 'package:car_rental_service_application/data/dummy_cars.dart';
import 'package:car_rental_service_application/models/car.dart';
import 'package:car_rental_service_application/screens/search_screen.dart';
import 'package:car_rental_service_application/services/admin_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:car_rental_service_application/screens/home_screen.dart';
import 'package:car_rental_service_application/screens/favourites_screen.dart';
import 'package:car_rental_service_application/screens/booking_screen_admin.dart';
import 'package:car_rental_service_application/screens/admin.dart';
import 'package:car_rental_service_application/screens/maps_screen.dart';





class BottomBarScreen extends StatefulWidget {
  BottomBarScreen({super.key, this.selectedPageIndex});
  late int? selectedPageIndex;

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {


  final List<Map<String, dynamic>> pages = [
    {'page': '', 'title': 'Home'},
    {'page': '', 'title': 'Bookings'},
    {'page': '', 'title': 'Search'},
    {'page': '', 'title': 'Favourites'},
    {'page': '', 'tittle': 'Profile'}
  ];
  final List<Car> cars = dummyCars;

  void ChangePage(int index) {
    setState(() {
      widget.selectedPageIndex = index;
    });
  }
  var brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = brightness == Brightness.dark;

    pages[0]['page'] = HomeScreen();
    pages[1]['page'] = MapScreen(cars: cars,);
    pages[2]['page'] = SearchScreen();
    pages[3]['page'] = FavoritesScreen();
    pages[4]['page'] = AdminScreen();

    int selectedPageIndexDef = widget.selectedPageIndex ?? 0;
    return Scaffold(
      backgroundColor: Colors.black,
      body: pages[selectedPageIndexDef]['page'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.redAccent.shade700,
        onTap: (currentIndex) => {ChangePage(currentIndex)},
        currentIndex: selectedPageIndexDef,
        selectedItemColor: Colors.white, // Color for the selected label text
        unselectedItemColor: Colors.white70,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
              size: 35,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mode_of_travel,
              color: Colors.white,
              size: 35,
            ),
            label: 'Travel',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
              size: 35,
            ),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.admin_panel_settings_outlined,
              color: Colors.white,
              size: 35,
            ),
            label: 'Admin',
          )
        ],
      ),
    );
  }
}
