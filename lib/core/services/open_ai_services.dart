import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'networks.dart';

class OpenAiServices {
  static final OpenAiServices _instance = OpenAiServices._internal();

  factory OpenAiServices() {
    return _instance;
  }

  OpenAiServices._internal();

  final Network _network = Network();

  Future<String> getCompletion(String prompt) async {
    try {
      final response = await _network.requestExternal.post(
        "https://api.openai.com/v1/chat/completions",
        data: {
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": prompt}
          ],
          "temperature": 0.7,
        },
      );
      final choice = response.data["choices"]?[0];
      return choice['message']['content'];
    } catch (err) {
      debugPrint("GET_COMPLETION: $err");
      rethrow;
    }
  }
}
