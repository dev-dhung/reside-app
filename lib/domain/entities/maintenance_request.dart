enum RequestPriority { low, medium, high, urgent }

enum RequestStatus { open, inProgress, resolved, closed }

enum RequestCategory {
  plumbing,
  electrical,
  elevator,
  commonAreas,
  structural,
  security,
  other,
}

class MaintenanceRequest {
  final String id;
  final String residentId;
  final String apartment;
  final String title;
  final String description;
  final RequestCategory category;
  final RequestPriority priority;
  final RequestStatus status;
  final DateTime createdAt;
  final DateTime? resolvedAt;
  final String? assignedTo;
  final String? adminNotes;
  final List<String> imageUrls;

  const MaintenanceRequest({
    required this.id,
    required this.residentId,
    required this.apartment,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.status,
    required this.createdAt,
    this.resolvedAt,
    this.assignedTo,
    this.adminNotes,
    this.imageUrls = const [],
  });

  MaintenanceRequest copyWith({
    String? id,
    String? residentId,
    String? apartment,
    String? title,
    String? description,
    RequestCategory? category,
    RequestPriority? priority,
    RequestStatus? status,
    DateTime? createdAt,
    DateTime? resolvedAt,
    String? assignedTo,
    String? adminNotes,
    List<String>? imageUrls,
  }) {
    return MaintenanceRequest(
      id: id ?? this.id,
      residentId: residentId ?? this.residentId,
      apartment: apartment ?? this.apartment,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      assignedTo: assignedTo ?? this.assignedTo,
      adminNotes: adminNotes ?? this.adminNotes,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }
}
