enum AnnouncementPriority { normal, high, urgent }

class Announcement {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final AnnouncementPriority priority;
  final String? author;

  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.priority,
    this.author,
  });
}
