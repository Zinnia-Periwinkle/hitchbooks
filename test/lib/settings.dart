// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field, prefer_typing_uninitialized_variables, non_constant_identifier_names, avoid_print, annotate_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:provider/provider.dart';
import 'package:test/resources/google.dart';
import 'providers/user_provider.dart';
import 'widgets/text_field_input.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  var info;
  String Problem = '';
  String text = '';
  bool isLoading = false;
  void initState() {
    super.initState();
    getUser();
  }

  getUser() {
    setState(() {
      isLoading = true;
    });
    final UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    setState(() {
      info = userProvider;
    });

    setState(() {
      isLoading = false;
    });
  }

  Future sendEmail() async {
    final user = await GoogleAuthApi.signIn();
    if (user == null) return;
    final email = user.email;

    final auth = await user.authentication;
    final token = auth.accessToken!;
    print('Authenticated $email');
    final smtpServer = gmailSaslXoauth2(email, token);
    final message = Message()
      ..from = Address(email, _nameController.text)
      ..recipients = ['jana.squared.plus.one@gmail.com']
      ..subject = 'Report a problem on $Problem'
      ..text = _infoController.text;

    try {
      await send(message, smtpServer);

      SimpleDialog(
        title: Text('The email was sent successfully! Thank you for your time'),
        children: [
          SimpleDialogOption(
            child: Text('Continue'),
          )
        ],
      );
    } on MailerException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final User user = Provider.of<UserProvider>(context).getUser;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                'Report A Problem',
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [Text('My Problem is Related to:')],
                ),
                Row(
                  children: [
                    DropdownButton(
                        hint: text == '' ? Text('Nothing yet') : Text(text),
                        items: [
                          DropdownMenuItem(
                              child: Text('Posts'), value: 'Posts'),
                          DropdownMenuItem(
                              child: Text('A user'), value: 'A user'),
                          DropdownMenuItem(
                              child: Text('a bug'), value: 'a bug'),
                          DropdownMenuItem(
                              child: Text('a modification'),
                              value: 'a modification'),
                        ].toList(),
                        onChanged: (value) {
                          setState(() => Problem = value.toString());
                          setState(() {
                            text = Problem;
                          });
                        }),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 300,
                      child: TextFieldInput(
                          hintText: 'Your Email',
                          textEditingController: _emailController,
                          textInputType: TextInputType.emailAddress),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                        height: 50,
                        width: 300,
                        child: TextFieldInput(
                            hintText: 'Name',
                            textEditingController: _nameController,
                            textInputType: TextInputType.name)),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 300,
                        height: 50,
                        child: TextFieldInput(
                            hintText: 'write your problem',
                            textEditingController: _infoController,
                            textInputType: TextInputType.name))
                  ],
                ),
                Align(
                    alignment: Alignment.center,
                    child: TextButton(
                        onPressed: sendEmail,
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 25,
                            color: Color(0xFF52b788),
                          ),
                        )))
              ],
            ));
    // : Scaffold(
    //     body: Column(children: [
    //     SizedBox(
    //       height: 50,
    //       child: Text('Report a Problem'),
    //     ),
    //     Row(children: [
    //       SizedBox(height: 50, child: Text('This Problem is related to')),
    //       SizedBox(
    //         height: 100,
    //         child: Row(children: [
    //           DropdownButton(
    //               hint: text == '' ? Text('Nothing yet') : Text(text),
    //               items: [
    //                 DropdownMenuItem(child: Text('Posts'), value: 'Posts'),
    //                 DropdownMenuItem(
    //                     child: Text('A user'), value: 'A user'),
    //                 DropdownMenuItem(child: Text('a bug'), value: 'a bug'),
    //                 DropdownMenuItem(
    //                     child: Text('a modification'),
    //                     value: 'a modification'),
    //               ].toList(),
    //               onChanged: (value) {
    //                 setState(() => Problem = value.toString());
    //                 setState(() {
    //                   text = Problem;
    //                 });
    //               }),
    //         ]),
    //       ),
    //     ]),
    //     Row(children: [
    //       SizedBox(
    //           width: 300,
    //           height: 50,
    //           child: TextFieldInput(
    //               hintText: 'Your email :)',
    //               textEditingController: _emailController,
    //               textInputType: TextInputType.emailAddress))
    //     ]),
    //     SizedBox(
    //         height: 50,
    //         width: 300,
    //         child: TextFieldInput(
    //             hintText: 'Name',
    //             textEditingController: _nameController,
    //             textInputType: TextInputType.name)),
    //     SizedBox(
    //       height: 50,
    //     ),
    //     Row(
    //       children: [
    //         SizedBox(
    //             width: 300,
    //             height: 50,
    //             child: TextFieldInput(
    //                 hintText: 'write your problem',
    //                 textEditingController: _infoController,
    //                 textInputType: TextInputType.name))
    //       ],
    //     ),
    //
    //   ]));
  }
}
