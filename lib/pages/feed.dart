import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:samajik/services/firebase_service.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  FirebaseService? _firebaseService;
  double? _deviceHeight, _deviceWidth;

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
      height: _deviceHeight,
      width: _deviceWidth,
      child: _postListView(),
    );
  }

  Widget _postListView() {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseService!.getLatestPosts(),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            List _posts = _snapshot.data!.docs.map((e) => e.data()).toList();
            return ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (BuildContext context, int index) {
                  Map _post = _posts[index];
                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: _deviceWidth! * 0.05,
                        vertical: _deviceHeight! * 0.01),
                    height: _deviceHeight! * 0.56,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding:
                              EdgeInsets.only(bottom: _deviceHeight! * 0.01),
                          height: _deviceHeight! * 0.06,
                          child: Row(),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: _deviceHeight! * 0.01),
                          height: _deviceHeight! * 0.50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_post["image"]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
