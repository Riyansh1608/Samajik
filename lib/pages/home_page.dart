import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Samajik",
        style: TextStyle(color: Colors.white, fontSize: 30),
      )),
      body: const Center(
        child: Text(
          "A Social Place For the new India",
          style: TextStyle(color: Colors.purple, fontSize: 30),
        ),
      ),
    );
  }
}
