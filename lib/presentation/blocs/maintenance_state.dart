import 'package:equatable/equatable.dart';
import '../../domain/entities/maintenance_record.dart';

abstract class MaintenanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MaintenanceInitial extends MaintenanceState {}

class MaintenanceLoading extends MaintenanceState {}

class MaintenanceLoaded extends MaintenanceState {
  final List<MaintenanceRecordEntity> records;
  final List<MaintenanceRecordEntity> completedRecords;
  final List<MaintenanceRecordEntity> dueRecords;

  MaintenanceLoaded(this.records)
      : completedRecords = records.where((r) => r.status == MaintenanceStatus.completed).toList(),
        dueRecords = records.where((r) {
          final now = DateTime.now();
          final today = DateTime(now.year, now.month, now.day);
          final diff = r.dueDate.difference(today).inDays;
          return diff <= 5;
        }).toList();

  @override
  List<Object?> get props => [records, completedRecords, dueRecords];
}

class MaintenanceError extends MaintenanceState {
  final String message;
  MaintenanceError(this.message);
  @override
  List<Object?> get props => [message];
}
