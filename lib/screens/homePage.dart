// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:gemini_clone/routes/approutes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const Color lightSkyBlue = Color.fromARGB(255, 242, 249, 249);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: lightSkyBlue,
          image: DecorationImage(
              image: AssetImage('assets/back3.jpeg'), fit: BoxFit.fill),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Spacer(),
            Text(
              "Genie AI",
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.only(left: 50),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(width: 30.0, height: 100.0),
                  const Text(
                    'Let\'s',
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10.0, height: 100.0),
                  DefaultTextStyle(
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'PlayfairDisplay',
                        color: Colors.black),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'Imagine ',
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          'Design ',
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          'Build ',
                          speed: const Duration(milliseconds: 100),
                        ),
                        TypewriterAnimatedText(
                          'Create Magic! ',
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      // totalRepeatCount: 6,
                      // pause: const Duration(milliseconds: 1000),
                      // displayFullTextOnTap: true,
                      // stopPauseOnTap: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
          // ),
        )),
      ),
      bottomNavigationBar: Container(
        color: Color.fromARGB(230, 192, 210, 210),
        padding: const EdgeInsets.only(bottom: 20, left: 60, right: 60, top: 5),
        child: SizedBox(
          height: 60,
          child: Card(
            elevation: 3,
            child: ElevatedButton(
                autofocus: true,
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.chatScreenRoute);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Let\'s get Started',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_right_alt_rounded,
                      size: 55,
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
