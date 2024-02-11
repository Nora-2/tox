// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:Toxicon/core/components/cubit/app_cubit.dart';
import 'package:chat_bubbles/bubbles/bubble_normal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:Toxicon/core/constants/constants.dart';

class Message {
  final bool isSender;
  final String msg;

  Message(this.isSender, this.msg);
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<Message> msgs = [
    Message(false, "how can I help you"),
    Message(false, 'Hello'),
  ];
  bool isTyping = false;

  void sendMsg() async {
    String text = controller.text;

    String apiKey = "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";
    controller.clear();
    try {
      if (text.isNotEmpty) {
        setState(() {
          msgs.insert(0, Message(true, text));
          isTyping = true;
        });
        scrollController.animateTo(
          0.0,
          duration: const Duration(seconds: 1),
          curve: Curves.easeOut,
        );
        var response = await http.post(
          Uri.parse("https://api.openai.com/v1/chat/completions"),
          headers: {
            "Authorization": "Bearer $apiKey",
            "Content-Type": "application/json"
          },
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            "messages": [
              {"role": "user", "content": text}
            ]
          }),
        );
        if (response.statusCode == 200) {
          var json = jsonDecode(response.body);
          setState(() {
            isTyping = false;
            msgs.insert(
              0,
              Message(
                false,
                json["choices"][0]["message"]["content"].toString().trimLeft(),
              ),
            );
          });
          scrollController.animateTo(
            0.0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeOut,
          );
        }
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Some error occurred, please try again!"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode brightnessValue =
        AppCubit.get(context).isdark ? ThemeMode.dark : ThemeMode.light;
    bool isDark = brightnessValue == ThemeMode.dark;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            isDark ?const Color(0xff0D0D0D) : Colors.white,
            isDark ?const Color(0xff0D0D0D) : Colors.white,
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: isDark ? Colors.white :const Color(0xff0D0D0D),
                      )),
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    'Mr-Tox',
                    style: GoogleFonts.sanchez(
                        textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            // color: Color(0xff0D0D0D),
                            fontSize: 20)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: msgs.length,
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: isTyping && index == 0
                        ? Column(
                            children: [
                              BubbleNormal(
                                text: msgs[0].msg,
                                isSender: true,
                                color: Colors.blue.shade100,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 4),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Lottie.asset(
                                    'assets/images/loading.json', // Replace with your Lottie file
                                    width: 70,
                                    height: 50,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: msgs[index].isSender
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              msgs[index].isSender
                                  ? const SizedBox()
                                  : Image.asset(
                                      'assets/images/robotchat.png',
                                      width: 50,
                                      height: 50,
                                    ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: BubbleNormal(
                                  text: msgs[index].msg,
                                  isSender: msgs[index].isSender,
                                  color: msgs[index].isSender
                                      ? Colors.blue.shade100
                                      : Colors.grey.shade200,
                                ),
                              ),
                              msgs[index].isSender
                                  ? Image.asset(
                                      'assets/images/profile.png',
                                      width: 50,
                                      height: 50,
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        color:
                            isDark ? Colors.white : Colors.grey.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: controller,
                          textCapitalization: TextCapitalization.sentences,
                          onSubmitted: (value) {
                            sendMsg();
                          },
                          textInputAction: TextInputAction.send,
                          showCursor: true,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter text",
                              hintStyle: TextStyle(
                                color:
                                    isDark ? const Color(0xff0D0D0D) : Colors.white,
                              )),
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    sendMsg();
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: icolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      Icons.send,
                      size: 15,
                      color: isDark ? Colors.white : Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
