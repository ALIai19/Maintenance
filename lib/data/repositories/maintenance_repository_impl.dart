import '../../domain/entities/maintenance_record.dart';
import '../../domain/repositories/maintenance_repository.dart';
import '../database/app_database.dart';
import '../mappers/maintenance_mapper.dart';

class MaintenanceRepositoryImpl implements MaintenanceRepository {
  final AppDatabase database;
  MaintenanceRepositoryImpl(this.database);

  @override
  Stream<List<MaintenanceRecordEntity>> watchRecordsByCategory(MaintenanceCategory category) {
    return database.watchRecordsByCategory(category).map(
          (records) => records.map(MaintenanceMapper.toEntity).toList(),
        );
  }

  @override
  Future<List<MaintenanceRecordEntity>> getAllRecords() async {
    final records = await database.getAllRecords();
    return records.map(MaintenanceMapper.toEntity).toList();
  }

  @override
  Future<void> insertRecord(MaintenanceRecordEntity record) async {
    await database.insertRecord(MaintenanceMapper.toCompanion(record));
  }

  @override
  Future<void> updateRecord(MaintenanceRecordEntity record) async {
    await database.updateRecord(MaintenanceMapper.toDriftModel(record));
  }

  @override
  Future<void> deleteRecord(MaintenanceRecordEntity record) async {
    await database.deleteRecord(MaintenanceMapper.toDriftModel(record));
  }
}
