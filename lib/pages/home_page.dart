import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> body = [
    Container(color: Colors.red),
    Container(color: Colors.green),
  ];
  int _currentpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Vartalaap",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.add_a_photo),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () {},
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: body[_currentpage],
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentpage,
      onTap: (_index) {
        setState(() {
          _currentpage = _index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          label: "Feed",
          icon: Icon(Icons.feed),
        ),
        BottomNavigationBarItem(
          label: "profile",
          icon: Icon(Icons.account_box),
        )
      ],
    );
  }
}
