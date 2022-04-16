// // ignore_for_file: prefer_typing_uninitialized_variables, annotate_overrides, prefer_const_constructors

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sendbird_sdk/sdk/sendbird_sdk_api.dart';
// import 'package:test/chat_user.dart';
// import 'package:test/providers/user_provider.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   String info = '';
//   bool isLoading = false;

//   void initState() {
//     super.initState();
//     getUserInfo();

//   }

//   getUserInfo() {
//     setState(() {
//       isLoading = true;
//     });
//     final UserProvider userProvider =
//         Provider.of<UserProvider>(context, listen: false);

//     setState(() {
//       isLoading = false;
//     });
//     setState(() {
//       info = userProvider.getUser.username;
//     });

//   }
// //   userId() async {
// //     final sendbird = SendbirdSdk(appId: 'CDF63B23-218C-40D7-B7FC-44FFB1539C46');
// //
// //     try {
// //       final user = await sendbird.connect( 'Jana');
// // // The user is connected to Sendbird server.
// //     } catch (e) {
// // // Handle error.
// //     }
// //   }

//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? Center(
//             child: CircularProgressIndicator(),
//           )
//         : Scaffold(
//             body: Column ( children : [

//              ,
//       ]
//     )
//           );
//   }
// }
