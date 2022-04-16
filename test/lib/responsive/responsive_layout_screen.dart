// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/user_provider.dart';
import 'package:test/theme/global_variable.dart';

class ResponsiveLayout extends StatefulWidget {
  final Widget MobileScreenLayout;
  final Widget WebScreenLayout;
  const ResponsiveLayout({
    Key? key,
    required this.MobileScreenLayout,
    required this.WebScreenLayout,
  }) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        // 600 can be changed to 900 if you want to display tablet screen with mobile screen layout
        return widget.WebScreenLayout;
      }
      return widget.MobileScreenLayout;
    });
  }
}
