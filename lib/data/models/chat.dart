import 'dart:convert';

class Chat {
  final String role;
  final String content;

  Chat({required this.role, required this.content});

  Map<String, dynamic> toMap() {
    return {
      'role': role,
      'content': content,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      role: map['role'] ?? '',
      content: map['content'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source));
}
