// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/profile_screen.dart';
import 'package:test/theme/global_variable.dart';

class Mobile extends StatefulWidget {
  const Mobile({
    Key? key,
  }) : super(key: key);

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  int _page = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                'HitchBooks',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                        uid: FirebaseAuth.instance.currentUser!.uid),
                  )),
                ),
              ],
              bottom: TabBar(tabs: [
                Tab(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.chat_bubble,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ]),
            ),
            body: TabBarView(
              children: homeScreenItems,
            )));
  }
//     return Scaffold(
//         body: PageView(
//           children: homeScreenItems,
//           controller: pageController,
//           onPageChanged: onPageChanged,
//         ),
//         bottomNavigationBar: CupertinoTabBar(
//           backgroundColor: mobileBackgroundColor,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.home,
//                 color: (_page == 0) ? primaryColor : secondaryColor,
//               ),
//               label: '',
//               backgroundColor: primaryColor,
//             ),
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.search,
//                   color: (_page == 1) ? primaryColor : secondaryColor,
//                 ),
//                 label: '',
//                 backgroundColor: primaryColor),
//             BottomNavigationBarItem(
//                 icon: Icon(
//                   Icons.add_circle,
//                   color: (_page == 2) ? primaryColor : secondaryColor,
//                 ),
//                 label: '',
//                 backgroundColor: primaryColor),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.favorite,
//                 color: (_page == 3) ? primaryColor : secondaryColor,
//               ),
//               label: '',
//               backgroundColor: primaryColor,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.person,
//                 color: (_page == 4) ? primaryColor : secondaryColor,
//               ),
//               label: '',
//               backgroundColor: primaryColor,
//             ),
//           ],
//           onTap: navigationTapped,
//           currentIndex: _page,
//         ) // ),
//         );
//   }
// }

}
