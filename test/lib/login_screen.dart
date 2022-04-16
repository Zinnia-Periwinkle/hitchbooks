// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test/resources/auth_methods.dart';
import 'package:test/responsive/mobile_screen_layout.dart';
import 'package:test/responsive/web_screen_layout.dart';
import 'package:test/signup_screen.dart';
import 'package:test/widgets/text_field_input.dart';

import 'responsive/responsive_layout_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool value = false;
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success!') {
      setState(() {
        _isLoading = false;
      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                MobileScreenLayout: Mobile(),
                WebScreenLayout: WebScreenLayout(),
              )));
    }
    dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/Official-Logo.png',
                  height: 250,
                  width: 250,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 30.0,
                      color: Color(0xFF52b788)),
                ),
                const SizedBox(
                  height: 44,
                ),
                TextFieldInput(
                  hintText: 'Enter Your Email',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
                const SizedBox(
                  height: 44,
                ),
                TextFieldInput(
                  hintText: 'Enter Your Password',
                  textInputType: TextInputType.emailAddress,
                  textEditingController: _passwordController,
                  isPass: true,
                ),
                const SizedBox(
                  height: 44,
                ),
                InkWell(
                  onTap: loginUser,
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'Login',
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
                // Flexible(
                //   child: Container(),
                //   flex: 2,
                // ),
                SizedBox(
                  width: 14,
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Don't have an account?"),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: Container(
                        child: Text(
                          "Sign up!",
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
