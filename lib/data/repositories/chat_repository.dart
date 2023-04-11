import 'dart:convert';

import 'package:agriapp/data/models/chat.dart';
import 'package:http/http.dart' as http;

class ChatRepository {
  Future<Chat?> requestChat(Chat chat) async {
    final Uri url = Uri.https('api.openai.com', "v1/chat/completions");

    final body = jsonEncode(
      {
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "You are a helpful assistant that helps farmers with information to increase their yields"},
          chat.toMap(),
        ],
        "temperature": 0.7
      },
    );

    final response = await http.post(
      url,
      headers: {'Authorization': 'Bearer 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', 'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      final message = responseBody["choices"].first["message"];

      return Chat.fromMap(message);
    }
  }
}
