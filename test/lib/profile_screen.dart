// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, unused_field, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/login_screen.dart';
import 'package:test/my_posts.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/resources/auth_methods.dart';
import 'package:test/resources/firestore_methods.dart';
import 'package:test/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userData = {};

  int postLen = 0;
  int followers = 0;
  int following = 0;
  bool isFollowing = false;
  bool isLoading = false;
  var info;
  var userInfo;
  @override
  void initState() {
    super.initState();
    getData();
    // getUserInfo();
  }

  getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .get();
      setState(() {
        userInfo = userSnap;
      });
      // get post lengt

      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();
      postLen = postSnap.docs.length;
      userData = userSnap.data()!;
      setState(() {
        followers = userSnap.data()!['followers'].length;
        following = userSnap.data()!['following'].length;
      });

      isFollowing = userSnap
          .data()![followers]
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      e.toString();
    }
    setState(() {
      isLoading = false;
    });
  }

  getUserInfo() {
    setState(() {
      isLoading = true;
    });
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    setState(() {
      isLoading = false;
    });
    setState(() {
      userInfo = userProvider;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              toolbarHeight: 50,
              backgroundColor: Colors.white,
              title: Text(
                'My Profile',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Column(
              children: [
                Row(children: [
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(
                          userData['photoUrl'],
                        ),
                      ),
                      Text(
                        userData['username'],
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      )
                    ]),
                  ),
                ]),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildStatColumm(postLen, 'posts'),
                    buildStatColumm(followers, 'followers'),
                    buildStatColumm(following, 'following')
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FirebaseAuth.instance.currentUser!.uid == widget.uid
                        ? FollowButton(
                            text: 'Sign out',
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            borderColor: Colors.grey,
                            function: () async {
                              await AuthMethods().signOut();
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                          )
                        : isFollowing
                            ? FollowButton(
                                text: 'Unfollow',
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                borderColor: Colors.grey,
                                function: () async {
                                  await FirestoreMethods().followUser(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      userData['uid']);
                                  setState(() {
                                    isFollowing = false;
                                    followers--;
                                  });
                                },
                              )
                            : FollowButton(
                                text: 'follow',
                                backgroundColor: Colors.white,
                                textColor: Colors.black,
                                borderColor: Colors.grey,
                                function: () async {
                                  await FirestoreMethods().followUser(
                                      FirebaseAuth.instance.currentUser!.uid,
                                      userData['uid']);

                                  setState(() {
                                    isFollowing = true;
                                    followers++;
                                  });
                                },
                              )
                  ],
                ),
                Column(
                  children: [
                    Row(children: [
                      Text('My Posts'),
                      IconButton(
                          onPressed: () {
                            dispose();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    MyPosts(uid: widget.uid)));
                          },
                          icon: Icon(Icons.arrow_back))
                    ]),
                    // StreamBuilder(
                    //     stream: FirebaseFirestore.instance
                    //         .collection('posts')
                    //         .where('uid', isEqualTo: userData['uid'])
                    //         .snapshots(),
                    //     builder: (context,
                    //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                    //             snapshot) {
                    //       if (snapshot.connectionState ==
                    //           ConnectionState.waiting) {
                    //         return Center(
                    //           child: CircularProgressIndicator(),
                    //         );
                    //       }
                    //       return ListView.builder(
                    //           scrollDirection: Axis.vertical,
                    //           shrinkWrap: true,
                    //           itemCount: 1,
                    //           itemBuilder: (context, index) =>
                    //               Text(userInfo.data()!['followers']));
                    //     }),
                  ],
                ),
                //
              ],
            ),
          );
  }

  Column buildStatColumm(int num, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
        )
      ],
    );
  }
}
