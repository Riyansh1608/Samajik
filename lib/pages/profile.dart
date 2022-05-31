import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samajik/services/firebase_service.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double? _deviceHeight, _deviceWidth;
  FirebaseService? _firebaseService;
  File? _image;
  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth! * 0.05,
        vertical: _deviceWidth! * 0.04,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _profileWidget(),
          _nameWidget(),
          _postGridView(),
        ],
      ),
    );
  }

  Widget _profileWidget() {
    var _imageProvider = NetworkImage(_firebaseService!.currentUser!["image"]);
    return GestureDetector(
      onTap: () async {
        await FilePicker.platform
            .pickFiles(type: FileType.image)
            .then((_result) {
          setState(() {
            _image = File(_result!.files.first.path!);
            print(_image);
          });
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: _deviceHeight! * 0.02),
        height: _deviceHeight! * 0.15,
        width: _deviceHeight! * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
              color: Colors.purple,
              blurRadius: 2.0,
              spreadRadius: 5.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.2,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          image: DecorationImage(
            fit: BoxFit.cover,
            image: _imageProvider,
            //image: NetworkImage(_firebaseService!.currentUser!["image"]),
          ),
        ),
      ),
    );
  }

  Widget _nameWidget() {
    return Container(
      margin: EdgeInsets.only(bottom: _deviceHeight! * 0.02),
      height: _deviceHeight! * 0.05,
      width: _deviceHeight!,
      child: Center(
          child: Text(
        _firebaseService!.currentUser!["name"],
        style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 95, 19, 109),
            fontFamily: "BubblegumSans"),
      )),
    );
  }

  Widget _postGridView() {
    return Expanded(
      child: StreamBuilder<QuerySnapshot>(
        stream: _firebaseService!.getUsersPosts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List _posts = snapshot.data!.docs.map((e) => e.data()).toList();
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
              ),
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                Map _post = _posts[index];
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        _post["image"],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }
}
