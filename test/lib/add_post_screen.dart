// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test/models/user.dart';
import 'package:test/resources/firestore_methods.dart';
import 'package:test/responsive/mobile_screen_layout.dart';
import 'package:test/theme/colors.dart';
import 'package:test/theme/global_variable.dart';
import 'package:test/theme/utils.dart';
import 'providers/user_provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  var _file;
  final TextEditingController _descriptionController = TextEditingController();
  late String BoardType;
  bool _isLoading = false;
  String text = '';

  void postImage(
    String uid,
    String username,
    String profImage,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FirestoreMethods().uploadPost(
        _descriptionController.text,
        _file!,
        uid,
        username,
        profImage,
        BoardType,
      );

      if (res == 'success!') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted!', context);
        clearImage();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Mobile(),
            ));
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext parentContext) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(title: const Text('create a post'), children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('take a photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(ImageSource.camera);

                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('choose from gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List file = await pickImage(
                  ImageSource.gallery,
                );

                setState(() {
                  _file = file;
                });
              },
            ),
          ]);
        });
  }

  void clearImage() {
    setState(() {
      _file == null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final User user = Provider.of<UserProvider>(context).getUser;
    final User user = Provider.of<UserProvider>(context).getUser;
    return _file == null
        ? Center(
            child: SizedBox(
            width: 60,
            height: 300,
            child: IconButton(
              icon: const Icon(Icons.upload),
              onPressed: () => _selectImage(context),
            ),
          ))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: clearImage,
              ),
              title: Text(
                'Add Post',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 0.0)),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.photoUrl,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 200,
                      width: 600,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                            image: MemoryImage(_file!),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Center(
                      child: SizedBox(
                        height: 50,
                        width: 600,
                        child: TextField(
                          controller: _descriptionController,
                          decoration: const InputDecoration(
                              hintText: "Write a caption...",
                              border: InputBorder.none),
                          maxLines: 8,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(),
                SizedBox(
                  child: Text('Choose your board!'),
                ),
                SizedBox(
                  child: Center(
                      child: DropdownButton(
                          hint: text == '' ? Text('nothing yet') : Text(text),
                          items: [
                            DropdownMenuItem(
                                child: Text('Book of the Month'),
                                value: 'Book of the Month'),
                            DropdownMenuItem(
                                child: Text('Poem of the Week'),
                                value: 'Poem of the Week'),
                            DropdownMenuItem(
                                child: Text('Song of the Week'),
                                value: 'Song of the Week'),
                            DropdownMenuItem(
                                child: Text('Word of the Day'),
                                value: 'Word of the Day'),
                            DropdownMenuItem(
                                child: Text('Notable of the Week'),
                                value: 'Notable of the Week'),
                            DropdownMenuItem(
                                child: Text('Quote of the Week'),
                                value: 'Quote of the Week'),
                            DropdownMenuItem(
                                child: Text('News of the Day'),
                                value: 'News of the Day'),
                            DropdownMenuItem(
                                child: Text('Diaries of the Day'),
                                value: 'Diaries of the Day'),
                          ].toList(),
                          onChanged: (value) {
                            setState(() => BoardType = value.toString());
                            setState(() {
                              text = BoardType;
                            });
                          })),
                ),
                TextButton(
                  child: _isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          'Post',
                          style: TextStyle(color: Color(0xFF52b788)),
                        ),
                  onPressed: () {
                    if (badWords.contains(_descriptionController.text)) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                                title: Text(
                                    'Oops! This is against our community guidlines :)'),
                                children: [
                                  SimpleDialogOption(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  SimpleDialogOption(
                                    child: Text('Learn More'),
                                    onPressed: () {},
                                  ),
                                ]);
                          });
                    } else {
                      postImage(
                        user.uid,
                        user.username,
                        user.photoUrl,
                      );
                    }
                  },
                )
              ],
            ),
          );
  }
}
