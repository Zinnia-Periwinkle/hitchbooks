// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:sendbird_sdk/sendbird_sdk.dart';

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/login_screen.dart';
import 'package:test/resources/auth_methods.dart';
import 'package:test/responsive/mobile_screen_layout.dart';
import 'package:test/responsive/responsive_layout_screen.dart';
import 'package:test/responsive/web_screen_layout.dart';
import 'package:test/theme/global_variable.dart';
import 'package:test/theme/utils.dart';
import 'package:test/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool value = false;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    if (_emailController.text.isNotEmpty ||
        _passwordController.text.isNotEmpty ||
        _usernameController.text.isNotEmpty ||
        _bioController.text.isNotEmpty ||
        _image != null) {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethods().signUpUser(
          email: _emailController.text,
          password: _passwordController.text,
          username: _usernameController.text,
          bio: _bioController.text,
          file: _image!);

      setState(() {
        _isLoading = false;
      });
      print(res);
      if (res != 'success!') {
        showSnackBar(res, context);
        setState(() {
          _isLoading = false;
        });
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
                  MobileScreenLayout: Mobile(),
                  WebScreenLayout: WebScreenLayout(),
                )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 14,
                ),
                Text(
                  "HitchBooks",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 30.0,
                      color: Color(0xFF52b788)),
                ),
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: AssetImage('images/no_photo.png'),
                      ),
                // Positioned(
                //   bottom: -10,
                //   left: 80,
                //   child: IconButton(
                //     onPressed: selectImage,
                //     icon: const Icon(Icons.add_a_photo),
                //   ),
                // ),
                const SizedBox(
                  height: 54,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        color: Color(0xFF52b788)),
                  ),
                ),
                TextFieldInput(
                  hintText: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFieldInput(
                  hintText: 'Enter Your Username',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _usernameController,
                  isPass: false,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFieldInput(
                  hintText: 'Enter Your Bio',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _bioController,
                  isPass: false,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFieldInput(
                  hintText: 'Enter Your Password',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _passwordController,
                  isPass: true,
                ),
                const SizedBox(
                  height: 12,
                ),
                TextButton(
                    onPressed: selectImage,
                    child: Text(
                      'Add a Photo',
                      style: TextStyle(
                          color: Color(0xFF52b788), fontFamily: 'Roboto'),
                    )),
                InkWell(
                  onTap: () {
                    if (badWords.contains(_emailController.text) ||
                        badWords.contains(_passwordController.text) ||
                        badWords.contains(_usernameController.text) ||
                        badWords.contains(_bioController.text)) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                                title: Text(
                                    'One of your entries is against our community guidlines :('),
                                children: [
                                  SimpleDialogOption(
                                      child: Text('Learn More'),
                                      onPressed: () async {}),
                                  SimpleDialogOption(
                                      child: Text('Ok'),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      })
                                ]);
                          });
                    } else {
                      signUpUser();
                    }
                  },
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Sign Up',
                            style: TextStyle(fontFamily: 'Roboto'),
                          ),
                    width: 200,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        color: Color(0xFF52b788)),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Flexible(
                  child: Container(),
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Already have an account?"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Container(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
