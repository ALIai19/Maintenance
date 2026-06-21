import '../entities/maintenance_record.dart';
import '../repositories/maintenance_repository.dart';

class GetMaintenanceRecords {
  final MaintenanceRepository repository;
  GetMaintenanceRecords(this.repository);

  Stream<List<MaintenanceRecordEntity>> call(MaintenanceCategory category) {
    return repository.watchRecordsByCategory(category);
  }
}

class AddMaintenanceRecordUseCase {
  final MaintenanceRepository repository;
  AddMaintenanceRecordUseCase(this.repository);

  Future<void> call(MaintenanceRecordEntity record) async {
    await repository.insertRecord(record);
  }
}

class UpdateMaintenanceRecordUseCase {
  final MaintenanceRepository repository;
  UpdateMaintenanceRecordUseCase(this.repository);

  Future<void> call(MaintenanceRecordEntity record) async {
    await repository.updateRecord(record);
  }
}

class DeleteMaintenanceRecordUseCase {
  final MaintenanceRepository repository;
  DeleteMaintenanceRecordUseCase(this.repository);

  Future<void> call(MaintenanceRecordEntity record) async {
    await repository.deleteRecord(record);
  }
}
