import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class TextInput {
  final gemini = Gemini.instance;

  Future<String?> replyText(String inputText) async {
    // List<MessageReply> replyMessageList = [];
    String? replyChat = '';
    // final _conversationHistory = StringBuffer();
    try {
      final response = await gemini.text(inputText);
      replyChat = response?.output;
      //   setState(() {
      //   _conversationHistory.writeln(inputText); // Append user's current message
      //   _conversationHistory.writeln(response?.output); // Append Gemini's response
      // });
    } catch (e) {
      replyChat = 'Error in generating ';
    }
    return replyChat;
  }
}
//   Future<String?> myState(String input) async {
//     String? replyChat = '';

//     try {
//       final response = gemini.streamGenerateContent(input);
//       response.listen((value) {
//         replyChat = value.output!;
//       });
//     } catch (error) {
//       // print('Error generating content: $error');
//       replyChat = 'Error $error';
//     }
//     return replyChat;
//   }
// }

class ImageText {
  final gemini = Gemini.instance;

  Future<String> replyMsgImage(String msg, Uint8List image) async {
    try {
      final response = await gemini.textAndImage(
        text: "What is this picture?",
        images: [image],
      );

      final geminiText =
          response?.content?.parts?.last.text ?? 'No response from Gemini';
      return geminiText;
    } catch (e) {
      print('Error in replyMsgImage: $e');
      return 'Error in processing image';
    }
  }
}
