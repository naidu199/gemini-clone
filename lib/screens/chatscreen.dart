import 'dart:io';
import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_clone/input_pages/textinput.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class Message {
  final String sender;
  final String content;
  final Uint8List? imageBytes;

  Message({
    required this.sender,
    required this.content,
    this.imageBytes,
  });
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  final List<Message> messages = [];
  bool isSending = false;
  final gemini = Gemini.instance;
  bool nomessage = true;
  File? pickedImage;
  Uint8List? imageBytes;
  bool imageSelected = false;

  @override
  void initState() {
    super.initState();
    // _fetchPreviousMessages();
  }

  void _sendMessage(String message) async {
    TextInput textInput = TextInput();
    final userMsg = Message(sender: 'You', content: message);

    setState(() {
      messages.add(userMsg);
      messageController.clear();
      isSending = true;
      nomessage = false;
      _scrollToBottom();
    });

    final response = await textInput.replyText(message);

    if (response != null) {
      final geminiMessage = Message(sender: 'Gemini', content: response);
      setState(() {
        messages.add(geminiMessage);
        messageController.clear();
        _scrollToBottom();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error sending message')),
      );
    }
    setState(() {
      isSending = false;
    });
  }

  void _sendMessageAndImage(String message, Uint8List image) async {
    final userMsg = Message(sender: 'You', content: message);
    ImageText imageText = ImageText();
    setState(() {
      messages.add(userMsg);
      messageController.clear();
      isSending = true;
      nomessage = false;
      _scrollToBottom();
    });

    final response = await imageText.replyMsgImage(message, image);

    if (response.isNotEmpty) {
      final geminiMessage = Message(sender: 'Gemini', content: response);
      setState(() {
        messages.add(geminiMessage);
        messageController.clear();
        _scrollToBottom();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error sending message')),
      );
    }
    setState(() {
      isSending = false;
    });
  }

  Future<Uint8List?> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          imageBytes = bytes;
        });

        final userMsg = Message(
            sender: 'You',
            content: messageController.text,
            imageBytes: imageBytes);
        setState(() {
          messages.add(userMsg);
          nomessage = false;
          _scrollToBottom();
        });
        return imageBytes;
      }
    } catch (e) {
      print('Error picking image: $e');
    }
    return null;
  }

  void _scrollToBottom() {
    if (scrollController.hasClients) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 300),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'GENIE AI',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      Message message = messages[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        alignment: message.sender == 'You'
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: message.sender == 'You'
                                ? Colors.blue[100]
                                : Colors.grey[200],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.sender == 'Gemini' ? "Genie" : "you",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                    color: message.sender == 'Gemini'
                                        ? Colors.blue
                                        : Colors.grey),
                                textAlign: TextAlign.start,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              if (message.imageBytes != null)
                                Image.memory(
                                  message.imageBytes!,
                                  width: 200,
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              Text(
                                message.content,
                                style: const TextStyle(
                                    height: 1.4,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                if (isSending)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Genie ...",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 75,
                        // width: 110,
                        child: Lottie.asset('assets/dots.json'),
                      ),
                    ],
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          controller: messageController,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: 'Ask Genie ...',
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100.0),
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                    style: BorderStyle.solid),
                              )),
                          onEditingComplete: () {
                            if (messageController.text.isNotEmpty &&
                                !imageSelected) {
                              _sendMessage(messageController.text);
                            }
                            if (messageController.text.isNotEmpty &&
                                imageSelected) {
                              _sendMessageAndImage(
                                  messageController.text, imageBytes!);
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () async {
                                imageBytes = await _pickImage();
                                if (imageBytes != null) {
                                  setState(() {
                                    // pickedImage = pickedImage;
                                    imageBytes = imageBytes;
                                    imageSelected = true;
                                  });
                                }
                              },
                              icon: Icon(
                                Icons.image_search_outlined,
                                size: 38,
                              )),
                          IconButton(
                            icon: const Icon(
                              Icons.send,
                              size: 35,
                            ),
                            onPressed: () {
                              if (messageController.text.isNotEmpty &&
                                  !imageSelected) {
                                _sendMessage(messageController.text);
                              }
                              if (messageController.text.isNotEmpty &&
                                  imageSelected) {
                                _sendMessageAndImage(
                                    messageController.text, imageBytes!);
                                setState(() {
                                  imageSelected = false;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (nomessage)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/genie.jpeg'),
                      radius: 70,
                    ),
                    Text(
                      "Genie AI",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.purpleAccent[400]),
                    ),
                    SizedBox(
                      height: 40,
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText('Build With Gemini',
                              textStyle: const TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
                              speed: const Duration(milliseconds: 100)),
                        ],
                        isRepeatingAnimation: true,
                        repeatForever: true,
                        totalRepeatCount: 10,
                      ),
                    ),
                    const Text(
                      "How can I help you today ?.. ",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
