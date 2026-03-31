enum ReservationStatus { pending, approved, rejected, cancelled }

class Reservation {
  final String id;
  final String userId;
  final String areaId;
  final String areaName;
  final DateTime date;
  final ReservationStatus status;
  final int guestCount;
  final String? notes;

  const Reservation({
    required this.id,
    required this.userId,
    required this.areaId,
    required this.areaName,
    required this.date,
    required this.status,
    required this.guestCount,
    this.notes,
  });
}
