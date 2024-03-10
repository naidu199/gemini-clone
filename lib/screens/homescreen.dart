import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:gemini_clone/input_pages/textinput.dart';

// import 'dart:js';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextInput textInput = TextInput();
  ChatUser currentUser = ChatUser(id: '1', firstName: 'currentUser');
  ChatUser genie = ChatUser(id: '3.5', firstName: 'genie');
  List<ChatMessage> allMsgs = <ChatMessage>[];
  List<ChatUser> generating = <ChatUser>[];

  Future<void> getData(ChatMessage msg) async {
    setState(() {
      allMsgs.insert(0, msg);
    });
    generating.add(genie);
    // allMsgs.add(msg);
    final response = await textInput.replyText(msg.text);
    generating.remove(genie);
    ChatMessage genieMsg =
        ChatMessage(text: response!, user: genie, createdAt: DateTime.now());

    setState(() {
      allMsgs.insert(0, genieMsg);
    });

    // List<Messages> msgHistory=;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purpleAccent[300],
        title: Text(
          'Build with Gemini',
          style: TextStyle(
            // color: Theme.of(context).primaryColor,
            fontFamily: 'PlayfairDisplay',
          ),
        ),
      ),
      body: DashChat(
        typingUsers: generating,
        currentUser: currentUser,
        onSend: (ChatMessage msg) {
          getData(msg);
        },
        messages: allMsgs,
        messageOptions: const MessageOptions(
          showCurrentUserAvatar: true,
          showOtherUsersAvatar: true,
          currentUserContainerColor: Color.fromRGBO(6, 39, 62, 1),
          containerColor: Color.fromRGBO(127, 76, 222, 0.8),
          textColor: Colors.white,
          // messageTextBuilder:
        ),
        // inputOptions: const InputOptions(inputDecoration: InputDecoration()),
      ),
    );
  }
}
