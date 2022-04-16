// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_unnecessary_containers, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:test/Report.dart';
import 'package:test/comments_screen.dart';
import 'package:test/filtered.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/resources/firestore_methods.dart';
import 'package:test/theme/utils.dart';
import 'package:test/widgets/like_animation.dart';
import 'package:share_plus/share_plus.dart';

class PostCard extends StatefulWidget {
  final snap;
  const PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLikeAnimating = false;
  int commentLen = 0;
  bool isLoading = false;
  var info;

  @override
  void initState() {
    super.initState();
    getComments();
  }

  getUser() {}
  void getComments() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {});
  }

  userInfo() {
    setState(() {
      isLoading = true;
    });
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    setState(() {
      info = userProvider.getUser.uid;
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var username = widget.snap['username'];
    String share = 'Take a look at what $username';
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16)
                          .copyWith(right: 0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(widget.snap['profImage']),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.snap['username'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ]),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: ListView(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                shrinkWrap: true,
                                children: [
                                  FirebaseAuth.instance.currentUser!.uid ==
                                          widget.snap['uid']
                                      ? TextButton(
                                          onPressed: () async {
                                            await FirestoreMethods().deletePost(
                                                widget.snap['postId']);
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Delete'))
                                      : TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReportScreen()));
                                          },
                                          child: Text('Report'))
                                ],
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.more_vert),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  child: TextButton(
                    child: Text(
                      '#${widget.snap['BoardType']}',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Filtered(
                                BoardType: widget.snap['BoardType'],
                              )));
                    },
                  ),
                ),
                SizedBox(
                  child: Text(' ${widget.snap['description']}'),
                ),
                GestureDetector(
                  onDoubleTap: () async {
                    await FirestoreMethods().likePost(
                        widget.snap['postId'], info, widget.snap['likes']);
                    setState(() {
                      isLikeAnimating = true;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: double.infinity,
                        child: Image.network(widget.snap['postUrl'],
                            fit: BoxFit.contain),
                      ),
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isLikeAnimating ? 1 : 0,
                        child: LikeAnimation(
                          child: const Icon(Icons.favorite,
                              color: Colors.white, size: 120),
                          isAnimating: isLikeAnimating,
                          duration: const Duration(milliseconds: 400),
                          onEnd: () {
                            setState(() {
                              isLikeAnimating = false;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    LikeAnimation(
                        isAnimating: widget.snap['likes'].contains(info),
                        smallLike: true,
                        child: IconButton(
                            onPressed: () async {
                              await FirestoreMethods().likePost(
                                  widget.snap['postId'],
                                  info,
                                  widget.snap['likes']);
                            },
                            icon: widget.snap['likes'].contains(info)
                                ? Icon(Icons.favorite, color: Colors.red)
                                : const Icon(Icons.favorite))),
                    IconButton(
                        onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    CommentsScreen(snap: widget.snap),
                              ),
                            ),
                        icon:
                            Icon(Icons.comment_outlined, color: Colors.black)),
                    IconButton(
                        onPressed: () async {
                          final box = context.findRenderObject() as RenderBox?;

                          await Share.shareFiles(widget.snap['postUrl'],
                              text: widget.snap['descirption'],
                              subject: share,
                              sharePositionOrigin:
                                  box!.localToGlobal(Offset.zero) & box.size);
                        },
                        icon: Icon(Icons.send, color: Colors.black)),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                          style:
                              Theme.of(context).textTheme.subtitle2!.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                          child: Text(
                            '${widget.snap['likes'].length} likes',
                            style: Theme.of(context).textTheme.bodyText2,
                          )),
                      InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                CommentsScreen(snap: widget.snap),
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Text(
                              'View all $commentLen comments',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          DateFormat.yMMMd()
                              .format(widget.snap['datePublished'].toDate()),
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
