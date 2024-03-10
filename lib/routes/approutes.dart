// import 'dart:js';

import 'package:gemini_clone/screens/chatscreen.dart';
import 'package:gemini_clone/screens/homepage.dart';
import 'package:gemini_clone/screens/homescreen.dart';

class AppRoutes {
  static const String chatScreenRoute = '/chatscreen';
  static const String homeScreenRoute = '/homescreen';
  static const String homePageRoute = '/homepage';
  static final routes = {
    // homePageRoute: (context) => const HomePage(),
    homeScreenRoute: (context) => const HomeScreen(),
    chatScreenRoute: (context) => const ChatScreen(),
    homePageRoute: (context) => const HomePage(),
  };
}
