import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samajik/pages/feed.dart';
import 'package:samajik/pages/profile.dart';
import 'package:samajik/services/firebase_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseService? _firebaseService;
  final List<Widget> body = [
    Feed(),
    Profile(),
  ];
  int _currentpage = 0;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Vartalaap",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontFamily: "BubblegumSans",
          ),
        ),
        actions: [
          GestureDetector(
            onTap: _postImage,
            child: Icon(Icons.add_a_photo),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: GestureDetector(
              onTap: () async {
                _firebaseService!.logout();
                Navigator.popAndPushNamed(context, '/login');
              },
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

  void _postImage() async {
    FilePickerResult? _result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    File _image = File(_result!.files.first.path!);
    await _firebaseService!.postImage(_image);
  }
}
