import 'package:chatgpt_test/features/simple_chat/simple_chat_screen.dart';
import 'package:flutter/material.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  static const routeName = '/options';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Open Ai Flutter Examples'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Simple Chat without State Management'),
            subtitle: const Text('Model gpt-3.5-turbo'),
            onTap: () {
              Navigator.pushNamed(context, SimpleChatScreen.routeName);
            },
          ),
          ListTile(
            title: const Text(
                'Simple Chat without State Management - Local Database - ChatGPT UI clone'),
            subtitle: const Text('Model gpt-3.5-turbo'),
            onTap: () {
              UnimplementedError();
            },
          ),
          ListTile(
            title: const Text(
                'Simple Chat with State Management - Local Database - ChatGPT UI clone'),
            subtitle: const Text('Model gpt-3.5-turbo'),
            onTap: () {
              UnimplementedError();
            },
          ),
        ],
      ),
    );
  }
}
