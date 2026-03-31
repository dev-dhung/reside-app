enum VisitorStatus { pending, approved, inBuilding, exited, rejected }

class Visitor {
  final String id;
  final String residentId;
  final String residentApartment;
  final String visitorName;
  final String visitorCedula;
  final DateTime expectedDate;
  final DateTime? entryTime;
  final DateTime? exitTime;
  final VisitorStatus status;
  final String? vehiclePlate;
  final String? notes;
  final String accessCode;

  const Visitor({
    required this.id,
    required this.residentId,
    required this.residentApartment,
    required this.visitorName,
    required this.visitorCedula,
    required this.expectedDate,
    this.entryTime,
    this.exitTime,
    required this.status,
    this.vehiclePlate,
    this.notes,
    required this.accessCode,
  });
}
