import 'package:flutter/material.dart';
import 'package:samajik/pages/home_page.dart';
import 'package:samajik/pages/login_screen.dart';
import 'package:samajik/pages/register_screeen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:samajik/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.instance.registerSingleton<FirebaseService>(
    FirebaseService(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vartalaap',
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
