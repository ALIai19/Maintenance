import '../../domain/entities/maintenance_record.dart';

abstract class MaintenanceRepository {
  Stream<List<MaintenanceRecordEntity>> watchRecordsByCategory(MaintenanceCategory category);
  Future<List<MaintenanceRecordEntity>> getAllRecords();
  Future<void> insertRecord(MaintenanceRecordEntity record);
  Future<void> updateRecord(MaintenanceRecordEntity record);
  Future<void> deleteRecord(MaintenanceRecordEntity record);
}
