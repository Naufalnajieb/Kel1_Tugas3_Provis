import 'package:flutter/material.dart';
import 'booking_status.dart';
import 'cart.dart';
import 'detail_product.dart';
import 'landing.dart'; 
import 'login.dart';
import 'main.dart';
import 'navigation.dart';
import 'navigation_shop.dart';
import 'payment.dart';
import 'register.dart';
import 'settings.dart';
import 'success_payment.dart';

class DaftarMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tugas 3 Kelompok 3"), centerTitle: true,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 50,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookingStatusPage()),
                  );
                },
                child: Text("Go to Booking Status"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationPage()),
                  );
                },
                child: Text("Go to Navigation"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NavigationShopPage()),
                  );
                },
                child: Text("Go to Navigation Shop"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
                child: Text("Go to Settings"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SuccessPaymentPage()),
                  );
                },
                child: Text("Go to Success Payment"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text("Go to Register"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text("Go to Login"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LandingPage()),
                  );
                },
                child: Text("Go to Landing"),
              ),
              SizedBox(height: 150,)
          ],
        )
      ),
    );
  }
}
