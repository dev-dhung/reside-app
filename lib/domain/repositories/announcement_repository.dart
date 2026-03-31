import '../entities/announcement.dart';
import '../entities/rule.dart';

abstract class AnnouncementRepository {
  Future<List<Announcement>> getAnnouncements();
  Future<List<Rule>> getRules();
}
