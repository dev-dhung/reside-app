class ChatMessage {
  final String id;
  final String text;
  final bool isBot;
  final DateTime timestamp;
  final bool isTyping;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.isBot,
    required this.timestamp,
    this.isTyping = false,
  });
}
