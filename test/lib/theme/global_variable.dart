import 'package:provider/provider.dart';
import 'package:test/add_post_screen.dart';
import 'package:test/chat_screen.dart';
import 'package:test/chat_user.dart';
import 'package:test/feed_screen.dart';
import 'package:test/search_screen.dart';
import 'package:test/settings.dart';

import '../providers/user_provider.dart';

const webScreenSize = 900;

const homeScreenItems = [
  FeedScreen(),
  UserChatScreen(),
  AddPostScreen(),
  SettingsScreen(),
  SearchScreen(),
];

List badWords = [
  '2 girls 1 cup',
  '2g1c',
  '4r5e',
  '5h1t',
  '5hit',
  'a_s_s',
  'a2m',
  'a54',
  'a55',
  'a55hole',
  'aeolus',
  'ahole',
  'alabama hot pocket',
  'alaskan pipeline',
  'anal',
  'anal impaler',
  'anal leakage',
  'analannie',
  'analprobe',
  'analsex',
  'anilingus',
  'anus',
  'apeshit',
  'ar5e',
  'areola',
  'areole',
  'arian',
  'arrse',
  'arse',
  'arsehole',
  'aryan',
  'ass',
  'ass fuck',
  'ass hole',
  'shit',
  'fuck',
  'ass',
  'asshole'
];
