// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, unused_field, file_names, prefer_typing_uninitialized_variables, non_constant_identifier_names, annotate_overrides

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:test/resources/google.dart';

import 'widgets/text_field_input.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
              backgroundColor: Colors.white,
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: Column(children: [
              SizedBox(
                height: 50,
                child: Text('Report a Post'),
              ),
              Row(children: [
                SizedBox(
                    width: 300,
                    height: 50,
                    child: TextFieldInput(
                        hintText: 'Your email :)',
                        textEditingController: _emailController,
                        textInputType: TextInputType.emailAddress))
              ]),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                  width: 300,
                  height: 50,
                  child: TextFieldInput(
                      hintText: 'The post publisher',
                      textEditingController: _nameController,
                      textInputType: TextInputType.name)),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                      width: 300,
                      height: 50,
                      child: TextFieldInput(
                          hintText: 'the board type',
                          textEditingController: _infoController,
                          textInputType: TextInputType.name))
                ],
              ),
              Row(children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shadowColor: Color(0xFF52b788)),
                    onPressed: sendEmail,
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ))
              ])
            ]));
  }
}
