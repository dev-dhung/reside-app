enum AreaStatus { available, occupied, maintenance }

class CommonArea {
  final String id;
  final String name;
  final String iconName;
  final AreaStatus status;
  final String? statusDetail;
  final double? depositAmount;

  const CommonArea({
    required this.id,
    required this.name,
    required this.iconName,
    required this.status,
    this.statusDetail,
    this.depositAmount,
  });
}
