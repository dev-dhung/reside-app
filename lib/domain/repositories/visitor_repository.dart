import '../entities/visitor.dart';

abstract class VisitorRepository {
  Future<List<Visitor>> getVisitorsByResident(String residentId);
  Future<List<Visitor>> getAllVisitors();
  Future<Visitor> registerVisitor(Visitor visitor);
  Future<void> approveVisitor(String visitorId);
  Future<void> rejectVisitor(String visitorId);
  Future<void> markEntry(String visitorId);
  Future<void> markExit(String visitorId);
}
