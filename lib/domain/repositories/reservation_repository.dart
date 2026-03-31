import '../entities/common_area.dart';
import '../entities/reservation.dart';

abstract class ReservationRepository {
  Future<List<CommonArea>> getAreas();
  Future<List<Reservation>> getReservations(String userId);
  Future<Reservation> createReservation(Reservation reservation);
}
