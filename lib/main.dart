import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_clone/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';

import 'package:gemini_clone/routes/approutes.dart';
import 'package:gemini_clone/screens/chatscreen.dart';
import 'package:gemini_clone/screens/homescreen.dart';

void main() async {

  Gemini.init(apiKey: 'YOUR_API_KEY');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   // primarySwatch: Colors.blue,
      //   colorScheme: ColorScheme.fromSwatch(
      //     primarySwatch: Colors.blue,
      //     accentColor: Colors.purpleAccent[300],
      //   ),
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      //   fontFamily: 'PlayfairDisplay',
      //   // fallbackFontFamily: 'FallbackFont',

      //   textTheme: TextTheme(
      //     headlineLarge:
      //         TextStyle(color: Colors.white, fontFamily: 'PlayfairDisplay'),
      //   ),
      // ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.purpleAccent[400], // Accent color for highlights
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'PlayfairDisplay',
        textTheme: TextTheme(
          headlineLarge:
              TextStyle(color: Colors.white, fontFamily: 'PlayfairDisplay'),
        ),
        // Customizing chat container colors
        cardColor: Colors.blue[50],
      ),

      initialRoute: AppRoutes.homePageRoute,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      // home: HomeScreen(),
      home: ChatScreen(),
    );
  }
}
