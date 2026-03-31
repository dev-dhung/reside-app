import 'package:prototype/domain/entities/common_area.dart';

class CommonAreaModel {
  final String id;
  final String name;
  final String iconName;
  final AreaStatus status;
  final String? statusDetail;
  final double? depositAmount;

  const CommonAreaModel({
    required this.id,
    required this.name,
    required this.iconName,
    required this.status,
    this.statusDetail,
    this.depositAmount,
  });

  factory CommonAreaModel.fromJson(Map<String, dynamic> json) {
    return CommonAreaModel(
      id: json['id'] as String,
      name: json['name'] as String,
      iconName: json['iconName'] as String,
      status: AreaStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
      statusDetail: json['statusDetail'] as String?,
      depositAmount: (json['depositAmount'] as num?)?.toDouble(),
    );
  }

  factory CommonAreaModel.fromEntity(CommonArea area) {
    return CommonAreaModel(
      id: area.id,
      name: area.name,
      iconName: area.iconName,
      status: area.status,
      statusDetail: area.statusDetail,
      depositAmount: area.depositAmount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'iconName': iconName,
      'status': status.name,
      'statusDetail': statusDetail,
      'depositAmount': depositAmount,
    };
  }

  CommonArea toEntity() {
    return CommonArea(
      id: id,
      name: name,
      iconName: iconName,
      status: status,
      statusDetail: statusDetail,
      depositAmount: depositAmount,
    );
  }
}
