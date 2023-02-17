import 'package:app/pages/add_car_page.dart';
import 'package:app/pages/home_page.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:app/pages/update_car_page.dart';
import 'package:flutter/material.dart';
import 'pages/car_details_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (context) => const LoginPage(),
        'register': (context) => const RegisterPage(),
        'home': (context) => const HomePage(),
        'car_details': (context) => const CarDetailsPage(),
        'add_car': (context) => const AddCarPage(),
        'update_car': (context) => const UpdateCarPage()
      },
    );
  }
}


