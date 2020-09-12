import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState(this.userId);

  final String userId;
  const HomePage({this.userId});
}

class _HomePageState extends State<HomePage> {
  final String profileId;
  String view = "grid"; // default view
  bool isFollowing = false;
  bool followButtonClicked = false;
  int postCount = 0;
  int followerCount = 0;
  int followingCount = 0;
  _HomePageState(this.profileId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("HomePage"),
      ),
      body: new Center(
        child:  new Text("Home"),
      ),
    );
  }

  Container buildUserPosts() {
      Future<List<Container>> getPosts() async {
        List<Container> posts = [];
        var snap = await Firestore.instance
        .document('users')
        .collection('uid')
        .document('semestres')
            .collection('discplinas')
            .where('ownerId', isEqualTo: '')
            .orderBy("timestamp")
            .getDocuments();
        for (var doc in snap.documents) {
          posts.add(
              Container(
                child: AutoSizeText(
                "${doc.documentID}",
                minFontSize: 12,
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),));
        }
        setState(() {
          postCount = snap.documents.length;
        });

        return posts.reversed.toList();
      }

      return Container(
        //List <Image>
          child: FutureBuilder<List<Container>>(
        future: getPosts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Container(
                alignment: FractionalOffset.center,
                padding: const EdgeInsets.only(top: 10.0),
                child: CircularProgressIndicator());
          else if (view == "grid") {
            // build the grid
            return GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
//                    padding: const EdgeInsets.all(0.5),
                mainAxisSpacing: 1.5,
                crossAxisSpacing: 1.5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data.map((Container imagePost) {
                  return GridTile(child: imagePost);
                }).toList());
          } else if (view == "feed") {
            return Column(
                children: snapshot.data.map((Container imagePost) {
              return imagePost;
            }).toList());
          }
        },
      ));
    }
}
