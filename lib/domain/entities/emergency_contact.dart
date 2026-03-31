class EmergencyContact {
  final String id;
  final String name;
  final String phone;
  final String category;
  final String iconName;
  final bool isAvailable24h;
  final String? schedule;

  const EmergencyContact({
    required this.id,
    required this.name,
    required this.phone,
    required this.category,
    required this.iconName,
    required this.isAvailable24h,
    this.schedule,
  });
}
