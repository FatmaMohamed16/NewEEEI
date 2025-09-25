// lib/widgets/chatbot_floating_button.dart
import 'package:eeei/ChatbotScreen.dart';
import 'package:flutter/material.dart';
import 'ChatbotFloatingButton.dart';

class ChatbotFloatingButton extends StatelessWidget {
  const ChatbotFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (context) => const ChatbotScreen()));
      },
      backgroundColor: Colors.transparent,
      elevation: 0,
      highlightElevation: 0,
      splashColor: Colors.transparent,
      child: Image.asset(
        'assets/chatbot.jpg',
        width: 80,
        height: 80,
        fit: BoxFit.contain,
      ),
    );
  }
}
