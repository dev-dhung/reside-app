import 'package:prototype/domain/entities/announcement.dart';
import 'package:prototype/domain/entities/rule.dart';
import 'package:prototype/domain/repositories/announcement_repository.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';

class MockAnnouncementRepository implements AnnouncementRepository {
  @override
  Future<List<Announcement>> getAnnouncements() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockAnnouncements;
  }

  @override
  Future<List<Rule>> getRules() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockRules;
  }
}
