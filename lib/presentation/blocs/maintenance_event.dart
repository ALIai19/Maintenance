import 'package:equatable/equatable.dart';
import '../../domain/entities/maintenance_record.dart';

abstract class MaintenanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadRecordsByCategory extends MaintenanceEvent {
  final MaintenanceCategory category;
  LoadRecordsByCategory(this.category);
  @override
  List<Object?> get props => [category];
}

class AddMaintenanceRecord extends MaintenanceEvent {
  final MaintenanceRecordEntity record;
  AddMaintenanceRecord(this.record);
  @override
  List<Object?> get props => [record];
}

class UpdateMaintenanceRecord extends MaintenanceEvent {
  final MaintenanceRecordEntity record;
  UpdateMaintenanceRecord(this.record);
  @override
  List<Object?> get props => [record];
}

class DeleteMaintenanceRecord extends MaintenanceEvent {
  final MaintenanceRecordEntity record;
  DeleteMaintenanceRecord(this.record);
  @override
  List<Object?> get props => [record];
}

class UpdateStateWithRecords extends MaintenanceEvent {
  final List<MaintenanceRecordEntity> records;
  UpdateStateWithRecords(this.records);
  @override
  List<Object?> get props => [records];
}
