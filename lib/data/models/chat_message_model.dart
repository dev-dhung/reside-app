import 'package:prototype/domain/entities/chat_message.dart';

class ChatMessageModel {
  final String id;
  final String text;
  final bool isBot;
  final DateTime timestamp;
  final bool isTyping;

  const ChatMessageModel({
    required this.id,
    required this.text,
    required this.isBot,
    required this.timestamp,
    this.isTyping = false,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] as String,
      text: json['text'] as String,
      isBot: json['isBot'] as bool,
      timestamp: DateTime.parse(json['timestamp'] as String),
      isTyping: json['isTyping'] as bool? ?? false,
    );
  }

  factory ChatMessageModel.fromEntity(ChatMessage message) {
    return ChatMessageModel(
      id: message.id,
      text: message.text,
      isBot: message.isBot,
      timestamp: message.timestamp,
      isTyping: message.isTyping,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'isBot': isBot,
      'timestamp': timestamp.toIso8601String(),
      'isTyping': isTyping,
    };
  }

  ChatMessage toEntity() {
    return ChatMessage(
      id: id,
      text: text,
      isBot: isBot,
      timestamp: timestamp,
      isTyping: isTyping,
    );
  }
}
