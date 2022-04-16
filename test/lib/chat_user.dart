// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:provider/provider.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'package:test/providers/user_provider.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({Key? key}) : super(key: key);

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen>
    with ChannelEventHandler {
  // List<BaseMessage> _messages = [];
  bool isLoading = false;
  String info = '';
  // List<String> otherId = ['Jana'];

  // GroupChannel? _channel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Text('Hi'),
    )
        //     DashChat(
        //   messages: asDashChatMessages(_messages),
        //   user: asDashChatUser(SendbirdSdk().currentUser),
        //   onSend: (newMessage) {},
        // )
        );
  }

//   ChatUser asDashChatUser(User? user){
//     if(user == null){
//         return ChatUser(
//           uid: "",
//           name: '',
//           avatar: '',
//         );
//     }
//     return ChatUser(uid: user.userId, name: user.nickname, avatar: user.profileUrl);
//   }

//   List<ChatMessage> asDashChatMessages(List<BaseMessage> messages) {
//     return [
//     for(BaseMessage sbm in messages) ChatMessage(text: sbm.message, user: asDashChatUser(sbm.sender))
//   ];
//   }
//   @override
//   void onMessageReceived(BaseChannel channel, BaseMessage message) {
//     setState(() {
//       _messages.add(message);
//     });
//     super.onMessageReceived(channel, message);
//   }

//   void initState(){
//     super.initState();
//     SendbirdSdk().addChannelEventHandler('chat', this);
//     load();
//   }
//   getUserInfo() {
//     setState(() {
//       isLoading = true;
//     });
//     final UserProvider userProvider =
//     Provider.of<UserProvider>(context, listen: false);

//     setState(() {
//       isLoading = false;
//     });
//     setState(() {
//       info = userProvider.getUser.username;
//     });

//   }
//   @override
//   void dispose() {
//     SendbirdSdk().removeChannelEventHandler('chat');
//     // TODO: implement dispose
//     super.dispose();
//   }

//   void load() async {
//     try {
//       final sendbird = SendbirdSdk(appId: 'CDF63B23-218C-40D7-B7FC-44FFB1539C46');
//       final _ = await sendbird.connect(info);

//       //get exsiting channels
//       final query = GroupChannelListQuery()
//       ..limit = 1
//       ..userIdsExactlyIn = otherId;
//       List<GroupChannel> channels = await query.loadNext();

//       GroupChannel aChannel;
//       if(channels.length == 0){
//         //create new channel
//         aChannel = await GroupChannel.createChannel(GroupChannelParams()..userIds = otherId + [info]);
//       } else{
//         aChannel = channels[0];
//       }
//       //get messages from channel
//       List<BaseMessage> messages = await aChannel.getMessagesByTimestamp(DateTime.now().millisecondsSinceEpoch * 1000, MessageListParams());

//       //set the data
//       setState(() {
//         _messages = messages;
//         _channel = aChannel;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
// }
}
