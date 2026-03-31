import 'package:prototype/domain/entities/visitor.dart';
import 'package:prototype/domain/repositories/visitor_repository.dart';
import 'package:prototype/data/datasources/mock/mock_visitors.dart';

class MockVisitorRepository implements VisitorRepository {
  final List<Visitor> _visitors = List.from(mockVisitors);

  @override
  Future<List<Visitor>> getVisitorsByResident(String residentId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _visitors.where((v) => v.residentId == residentId).toList();
  }

  @override
  Future<List<Visitor>> getAllVisitors() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_visitors);
  }

  @override
  Future<Visitor> registerVisitor(Visitor visitor) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _visitors.add(visitor);
    return visitor;
  }

  @override
  Future<void> approveVisitor(String visitorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _visitors.indexWhere((v) => v.id == visitorId);
    if (index != -1) {
      final v = _visitors[index];
      _visitors[index] = Visitor(
        id: v.id,
        residentId: v.residentId,
        residentApartment: v.residentApartment,
        visitorName: v.visitorName,
        visitorCedula: v.visitorCedula,
        expectedDate: v.expectedDate,
        entryTime: v.entryTime,
        exitTime: v.exitTime,
        status: VisitorStatus.approved,
        vehiclePlate: v.vehiclePlate,
        notes: v.notes,
        accessCode: v.accessCode,
      );
    }
  }

  @override
  Future<void> rejectVisitor(String visitorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _visitors.indexWhere((v) => v.id == visitorId);
    if (index != -1) {
      final v = _visitors[index];
      _visitors[index] = Visitor(
        id: v.id,
        residentId: v.residentId,
        residentApartment: v.residentApartment,
        visitorName: v.visitorName,
        visitorCedula: v.visitorCedula,
        expectedDate: v.expectedDate,
        entryTime: v.entryTime,
        exitTime: v.exitTime,
        status: VisitorStatus.rejected,
        vehiclePlate: v.vehiclePlate,
        notes: v.notes,
        accessCode: v.accessCode,
      );
    }
  }

  @override
  Future<void> markEntry(String visitorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _visitors.indexWhere((v) => v.id == visitorId);
    if (index != -1) {
      final v = _visitors[index];
      _visitors[index] = Visitor(
        id: v.id,
        residentId: v.residentId,
        residentApartment: v.residentApartment,
        visitorName: v.visitorName,
        visitorCedula: v.visitorCedula,
        expectedDate: v.expectedDate,
        entryTime: DateTime.now(),
        exitTime: v.exitTime,
        status: VisitorStatus.inBuilding,
        vehiclePlate: v.vehiclePlate,
        notes: v.notes,
        accessCode: v.accessCode,
      );
    }
  }

  @override
  Future<void> markExit(String visitorId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _visitors.indexWhere((v) => v.id == visitorId);
    if (index != -1) {
      final v = _visitors[index];
      _visitors[index] = Visitor(
        id: v.id,
        residentId: v.residentId,
        residentApartment: v.residentApartment,
        visitorName: v.visitorName,
        visitorCedula: v.visitorCedula,
        expectedDate: v.expectedDate,
        entryTime: v.entryTime,
        exitTime: DateTime.now(),
        status: VisitorStatus.exited,
        vehiclePlate: v.vehiclePlate,
        notes: v.notes,
        accessCode: v.accessCode,
      );
    }
  }
}
