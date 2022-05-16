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
  Color _likeIconColor = Colors.white;
  Color _commentIconColor = Colors.white;
  Color _shareIconColor = Colors.white;

  bool _isCommented = false;
  bool _isShared = false;
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
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

                  String usrid = _post["userId"];

                  //var posterInfo = _firebaseService!.getUserData(uid: usrid).then((value) => va);

                  return Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: _deviceWidth! * 0.05,
                        vertical: _deviceHeight! * 0.025),
                    height: _deviceHeight! * 0.66,
                    child: Column(
                      children: [
                        Container(
                          // width: _deviceWidth! * 0.9,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 243, 193, 241),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(20)),
                          ),
                          padding: EdgeInsets.only(
                              left: _deviceWidth! * 0.05,
                              right: _deviceWidth! * 0.05),
                          height: _deviceHeight! * 0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: _deviceHeight! * 0.056,
                                width: _deviceHeight! * 0.056,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.purple,
                                      blurRadius: 1.0,
                                      spreadRadius: 3.0,
                                    ),
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: const Offset(0.0, 0.0),
                                      blurRadius: 0.0,
                                      spreadRadius: 0.0,
                                    ), //BoxShadow
                                  ], //BoxShadow],
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(_post["image"])),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: _deviceWidth! * 0.05,
                                    right: _deviceWidth! * 0.05),
                                child: Text(
                                  usrid,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 95, 19, 109),
                                      fontFamily: "BubblegumSans",
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //////////////////////////// main Image Container center/////////////////
                        Container(
                          padding: EdgeInsets.only(top: _deviceHeight! * 0.02),
                          height: _deviceHeight! * 0.52,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(_post["image"]),
                            ),
                          ),
                        ),

                        //////////////////////////////bottom bar///////////////////////
                        ///
                        //

                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: _deviceWidth! * 0.1),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 243, 193, 241),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(20)),
                          ),
                          height: _deviceHeight! * 0.07,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                iconSize: 30,
                                color: _likeIconColor,
                                onPressed: () {
                                  setState(() {
                                    _isLiked = !_isLiked;
                                    _likeIconColor =
                                        _isLiked ? Colors.purple : Colors.white;
                                  });
                                },
                                icon: const Icon(Icons.thumb_up),
                              ),
                              IconButton(
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                iconSize: 30,
                                color: _commentIconColor,
                                onPressed: () {
                                  setState(() {
                                    _isCommented = !_isCommented;
                                    _commentIconColor = _isCommented
                                        ? Colors.purple
                                        : Colors.white;
                                  });
                                },
                                icon: const Icon(Icons.comment),
                              ),
                              //////////////////////////////////////////
                              ///
                              ///share icon
                              ///
                              ////////////////////////////////////////////////
                              IconButton(
                                splashColor: Colors.white,
                                highlightColor: Colors.white,
                                iconSize: 30,
                                color: _shareIconColor,
                                onPressed: () {
                                  setState(() {
                                    _isShared = !_isShared;
                                    _shareIconColor = _isShared
                                        ? Colors.purple
                                        : Colors.white;
                                  });
                                },
                                icon: const Icon(Icons.share),
                              ),
                            ],
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
