// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test/theme/colors.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
  //WidgetsFlutterBinding.ensureInitialized();
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        // themeMode: themeProvider.themeMode,
      ),
    );
  }
}
