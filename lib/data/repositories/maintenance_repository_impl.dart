import 'package:prototype/data/datasources/mock/mock_maintenance.dart';
import 'package:prototype/domain/entities/maintenance_request.dart';
import 'package:prototype/domain/repositories/maintenance_repository.dart';

class MockMaintenanceRepository implements MaintenanceRepository {
  final List<MaintenanceRequest> _requests =
      List.from(mockMaintenanceRequests);

  @override
  Future<List<MaintenanceRequest>> getRequestsByResident(
      String residentId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _requests.where((r) => r.residentId == residentId).toList();
  }

  @override
  Future<List<MaintenanceRequest>> getAllRequests() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_requests);
  }

  @override
  Future<MaintenanceRequest> createRequest(MaintenanceRequest request) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _requests.add(request);
    return request;
  }

  @override
  Future<void> updateStatus(String requestId, RequestStatus status) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _requests.indexWhere((r) => r.id == requestId);
    if (index != -1) {
      _requests[index] = _requests[index].copyWith(
        status: status,
        resolvedAt:
            status == RequestStatus.resolved ? DateTime.now() : null,
      );
    }
  }

  @override
  Future<void> assignRequest(String requestId, String assignedTo) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _requests.indexWhere((r) => r.id == requestId);
    if (index != -1) {
      _requests[index] = _requests[index].copyWith(assignedTo: assignedTo);
    }
  }
}
