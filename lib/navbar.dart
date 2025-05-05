import 'package:flutter/material.dart';
import 'landing.dart';
import 'navigation.dart';
import 'show_booking.dart';
import 'settings.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _handleNavigation(BuildContext context, int index) {
  if (index == currentIndex) return;

  Widget page;
  if (index == 0){
    page = const LandingPage();
  }
  else if (index == 1){
    page = const NavigationPage();
  }
  else if (index == 2){
    page = const ShowBookingPage();
  }
  else if (index == 3){
    page = const SettingsPage();
  }
  else{
    page = const LandingPage();
  }

  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => page,
      transitionDuration: Duration.zero,
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _handleNavigation(context, index),
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.yellow[600],
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/Navbar1.png',
            width: 24,
            height: 24,
            color: currentIndex == 0 ? Colors.blue : Colors.grey,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/Navbar2.png',
            width: 24,
            height: 24,
            color: currentIndex == 1 ? Colors.blue : Colors.grey,
          ),
          label: 'Navigation',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/Navbar3.png',
            width: 24,
            height: 24,
            color: currentIndex == 2 ? Colors.blue : Colors.grey,
          ),
          label: 'Booking',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/Navbar4.png',
            width: 24,
            height: 24,
            color: currentIndex == 3 ? Colors.blue : Colors.grey,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}