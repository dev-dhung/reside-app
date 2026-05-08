enum SessionType { login, logout }

class SessionLog {
  final int id;
  final String ownerName;
  final String apartment;
  final SessionType type;
  final DateTime date;
  final String time;
  final String device;
  final String ip;

  const SessionLog({
    required this.id,
    required this.ownerName,
    required this.apartment,
    required this.type,
    required this.date,
    required this.time,
    required this.device,
    required this.ip,
  });

  String get typeLabel =>
      type == SessionType.login ? 'Inicio de sesión' : 'Cierre de sesión';
}
