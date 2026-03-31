import 'package:prototype/domain/entities/announcement.dart';

class AnnouncementModel {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final AnnouncementPriority priority;
  final String? author;

  const AnnouncementModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.priority,
    this.author,
  });

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) {
    return AnnouncementModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      date: DateTime.parse(json['date'] as String),
      priority: AnnouncementPriority.values.firstWhere(
        (e) => e.name == json['priority'],
      ),
      author: json['author'] as String?,
    );
  }

  factory AnnouncementModel.fromEntity(Announcement announcement) {
    return AnnouncementModel(
      id: announcement.id,
      title: announcement.title,
      content: announcement.content,
      date: announcement.date,
      priority: announcement.priority,
      author: announcement.author,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
      'priority': priority.name,
      'author': author,
    };
  }

  Announcement toEntity() {
    return Announcement(
      id: id,
      title: title,
      content: content,
      date: date,
      priority: priority,
      author: author,
    );
  }
}
