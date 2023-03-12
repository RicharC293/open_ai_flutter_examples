import 'package:chatgpt_test/core/services/open_ai_services.dart';
import 'package:flutter/material.dart';

class SimpleChatScreen extends StatefulWidget {
  const SimpleChatScreen({Key? key}) : super(key: key);

  static const routeName = '/simple_chat';

  @override
  State<SimpleChatScreen> createState() => _SimpleChatScreenState();
}

class _SimpleChatScreenState extends State<SimpleChatScreen> {
  /// The messages that the user has sent and received.
  /// 'sent' : 'response'
  ///
  final Map<String, String> _messages = {};

  final TextEditingController _textController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  Future<void> _sendMessage() async {
    if (_textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a message'),
        ),
      );
      return;
    }
    setState(() {
      _messages.addAll({_textController.text: ""});
    });

    /// web issue with scroll
    /// TODO: fix this
    await Future.delayed(Duration.zero);
    positionedScroll();
    final chatResponse =
        await OpenAiServices().getCompletion(_textController.text);
    setState(() {
      _messages[_textController.text] = chatResponse.toString().trimLeft();
      _textController.clear();
    });

    /// web issue with scroll
    /// TODO: fix this
    await Future.delayed(Duration.zero);
    positionedScroll();
  }

  void positionedScroll() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Simple Chat without State Management'),
        ),
        body: ListView.builder(
          controller: _scrollController,
          itemCount: _messages.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) {
            final messageSent = _messages.keys.elementAt(index);
            final messageReceived = _messages.values.elementAt(index);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(messageSent),
                  ),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: messageReceived.isNotEmpty
                        ? Text(messageReceived)
                        : const LinearProgressIndicator(),
                  ),
                ),
                const SizedBox(height: 5),
              ],
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: const InputDecoration(
                    hintText: 'Enter a message',
                  ),
                  onSubmitted: (value) => _sendMessage(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ));
  }
}
