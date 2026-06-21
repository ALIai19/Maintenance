import '../../domain/entities/maintenance_record.dart';
import '../database/app_database.dart';

class MaintenanceMapper {
  static MaintenanceRecordEntity toEntity(MaintenanceRecord record) {
    return MaintenanceRecordEntity(
      id: record.id,
      category: record.category,
      labName: record.labName,
      maintenanceDate: record.maintenanceDate,
      dueDate: record.dueDate,
      status: record.status,
    );
  }

  static MaintenanceRecordsCompanion toCompanion(MaintenanceRecordEntity entity) {
    return MaintenanceRecordsCompanion.insert(
      category: entity.category,
      labName: entity.labName,
      maintenanceDate: entity.maintenanceDate,
      dueDate: entity.dueDate,
      status: entity.status,
    );
  }

  static MaintenanceRecord toDriftModel(MaintenanceRecordEntity entity) {
    return MaintenanceRecord(
      id: entity.id!,
      category: entity.category,
      labName: entity.labName,
      maintenanceDate: entity.maintenanceDate,
      dueDate: entity.dueDate,
      status: entity.status,
    );
  }
}
