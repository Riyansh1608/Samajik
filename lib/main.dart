import 'package:flutter/material.dart';
import 'package:samajik/pages/home_page.dart';
import 'package:samajik/pages/login_screen.dart';
import 'package:samajik/pages/register_screeen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samajik',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: "/login",
      routes: {
        "/home": (context) => const Home(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
      },
    );
  }
}
