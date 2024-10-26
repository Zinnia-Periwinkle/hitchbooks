// ignore_for_file: prefer_const_constructors, unused_import, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:test/profile_screen.dart';

import 'package:test/widgets/post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  var stream;
  @override
  void initState() {
    super.initState();
    stream = FirebaseFirestore.instance.collection('posts').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(title: Text('Filter By'), children: [
                        SimpleDialogOption(
                          child: Text('Book of the Month'),
                          onPressed: () async {
                            setState(() {
                              stream = FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('BoardType',
                                      isEqualTo: 'Book of the Month')
                                  .snapshots();
                            });
                          },
                        ),
                        SimpleDialogOption(
                          child: Text('Song of the Week'),
                          onPressed: () async {
                            setState(() {
                              stream = FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('BoardType',
                                      isEqualTo: 'Song of the Week')
                                  .snapshots();
                            });
                          },
                        ),
                        SimpleDialogOption(
                          child: Text('Quote of the Week'),
                          onPressed: () async {
                            setState(() {
                              stream = FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('BoardType',
                                      isEqualTo: 'Quote of the Week')
                                  .snapshots();
                            });
                          },
                        ),
                        SimpleDialogOption(
                          child: Text('Poem of the Week'),
                          onPressed: () async {
                            setState(() {
                              stream = FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('BoardType',
                                      isEqualTo: 'Poem of the Week')
                                  .snapshots();
                            });
                          },
                        ),
                        SimpleDialogOption(
                          child: Text('Notable of the Week'),
                          onPressed: () async {
                            setState(() {
                              stream = FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('BoardType',
                                      isEqualTo: 'Notable of the Week')
                                  .snapshots();
                            });
                          },
                        ),
                        SimpleDialogOption(
                          child: Text('Word of the Day'),
                          onPressed: () async {
                            setState(() {
                              stream = FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('BoardType',
                                      isEqualTo: 'Word of the Day')
                                  .snapshots();
                            });
                          },
                        ),
                        SimpleDialogOption(
                          child: Text('News of the Day'),
                          onPressed: () async {
                            setState(() {
                              stream = FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('BoardType',
                                      isEqualTo: 'News of the Day')
                                  .snapshots();
                            });
                          },
                        ),
                        SimpleDialogOption(
                          child: Text('Diaries of the Day'),
                          onPressed: () async {
                            setState(() {
                              stream = FirebaseFirestore.instance
                                  .collection('posts')
                                  .where('BoardType',
                                      isEqualTo: 'News of the Day')
                                  .snapshots();
                            });
                          },
                        ),
                        SimpleDialogOption(
                          child: Text('Cancel'),
                          onPressed: () async {
                            setState(() {
                              stream = FirebaseFirestore.instance
                                  .collection('posts')
                                  .snapshots();
                            });
                          },
                        ),
                      ]);
                    });
              },
              icon: Icon(
                Icons.filter_alt,
                color: Colors.black,
              )),
        ),
        body: StreamBuilder(
            stream: stream,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) => PostCard(
                  snap: snapshot.data!.docs[index],
                ),
              );
            }));
  }
}
