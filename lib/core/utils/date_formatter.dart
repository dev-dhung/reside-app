class DateFormatter {
  DateFormatter._();

  static const List<String> _monthsShort = [
    'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
    'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic',
  ];

  static const List<String> _monthsFull = [
    'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
    'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
  ];

  static String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  static String formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  static String formatDateLong(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = _monthsShort[date.month - 1];
    final year = date.year.toString();
    return '$day $month $year';
  }

  static String formatDateFull(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = _monthsFull[date.month - 1];
    final year = date.year.toString();
    return '$day de $month de $year';
  }

  static String formatDateTime(DateTime date) {
    return '${formatDate(date)} ${formatTime(date)}';
  }
}
