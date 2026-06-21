enum MaintenanceCategory {
  fujifilm,
  urine,
  cbc,
}

enum MaintenanceStatus {
  completed,
  due,
}

class MaintenanceRecordEntity {
  final int? id;
  final MaintenanceCategory category;
  final String labName;
  final DateTime maintenanceDate;
  final DateTime dueDate;
  final MaintenanceStatus status;

  const MaintenanceRecordEntity({
    this.id,
    required this.category,
    required this.labName,
    required this.maintenanceDate,
    required this.dueDate,
    required this.status,
  });

  MaintenanceRecordEntity copyWith({
    int? id,
    MaintenanceCategory? category,
    String? labName,
    DateTime? maintenanceDate,
    DateTime? dueDate,
    MaintenanceStatus? status,
  }) {
    return MaintenanceRecordEntity(
      id: id ?? this.id,
      category: category ?? this.category,
      labName: labName ?? this.labName,
      maintenanceDate: maintenanceDate ?? this.maintenanceDate,
      dueDate: dueDate ?? this.dueDate,
      status: status ?? this.status,
    );
  }
}
