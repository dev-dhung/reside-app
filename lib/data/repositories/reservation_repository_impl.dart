import 'package:prototype/domain/entities/common_area.dart';
import 'package:prototype/domain/entities/reservation.dart';
import 'package:prototype/domain/repositories/reservation_repository.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';

class MockReservationRepository implements ReservationRepository {
  final List<Reservation> _reservations = List.from(mockReservations);

  @override
  Future<List<CommonArea>> getAreas() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return mockAreas;
  }

  @override
  Future<List<Reservation>> getReservations(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _reservations.where((r) => r.userId == userId).toList();
  }

  @override
  Future<Reservation> createReservation(Reservation reservation) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _reservations.add(reservation);
    return reservation;
  }
}
