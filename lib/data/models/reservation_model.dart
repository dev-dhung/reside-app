import 'package:prototype/domain/entities/reservation.dart';

class ReservationModel {
  final String id;
  final String userId;
  final String areaId;
  final String areaName;
  final DateTime date;
  final ReservationStatus status;
  final int guestCount;
  final String? notes;

  const ReservationModel({
    required this.id,
    required this.userId,
    required this.areaId,
    required this.areaName,
    required this.date,
    required this.status,
    required this.guestCount,
    this.notes,
  });

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      areaId: json['areaId'] as String,
      areaName: json['areaName'] as String,
      date: DateTime.parse(json['date'] as String),
      status: ReservationStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
      guestCount: json['guestCount'] as int,
      notes: json['notes'] as String?,
    );
  }

  factory ReservationModel.fromEntity(Reservation reservation) {
    return ReservationModel(
      id: reservation.id,
      userId: reservation.userId,
      areaId: reservation.areaId,
      areaName: reservation.areaName,
      date: reservation.date,
      status: reservation.status,
      guestCount: reservation.guestCount,
      notes: reservation.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'areaId': areaId,
      'areaName': areaName,
      'date': date.toIso8601String(),
      'status': status.name,
      'guestCount': guestCount,
      'notes': notes,
    };
  }

  Reservation toEntity() {
    return Reservation(
      id: id,
      userId: userId,
      areaId: areaId,
      areaName: areaName,
      date: date,
      status: status,
      guestCount: guestCount,
      notes: notes,
    );
  }
}
