import '../entities/maintenance_request.dart';

abstract class MaintenanceRepository {
  Future<List<MaintenanceRequest>> getRequestsByResident(String residentId);
  Future<List<MaintenanceRequest>> getAllRequests();
  Future<MaintenanceRequest> createRequest(MaintenanceRequest request);
  Future<void> updateStatus(String requestId, RequestStatus status);
  Future<void> assignRequest(String requestId, String assignedTo);
}
