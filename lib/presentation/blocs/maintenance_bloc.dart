import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/maintenance_usecases.dart';
import 'maintenance_event.dart';
import 'maintenance_state.dart';
import 'dart:async';

class MaintenanceBloc extends Bloc<MaintenanceEvent, MaintenanceState> {
  final GetMaintenanceRecords getMaintenanceRecords;
  final AddMaintenanceRecordUseCase addMaintenanceRecord;
  final UpdateMaintenanceRecordUseCase updateMaintenanceRecord;
  final DeleteMaintenanceRecordUseCase deleteMaintenanceRecord;

  StreamSubscription? _subscription;

  MaintenanceBloc({
    required this.getMaintenanceRecords,
    required this.addMaintenanceRecord,
    required this.updateMaintenanceRecord,
    required this.deleteMaintenanceRecord,
  }) : super(MaintenanceInitial()) {
    on<LoadRecordsByCategory>(_onLoadRecords);
    on<AddMaintenanceRecord>(_onAddRecord);
    on<UpdateMaintenanceRecord>(_onUpdateRecord);
    on<DeleteMaintenanceRecord>(_onDeleteRecord);
    on<UpdateStateWithRecords>(_onUpdateStateWithRecords);
  }

  Future<void> _onLoadRecords(
      LoadRecordsByCategory event, Emitter<MaintenanceState> emit) async {
    emit(MaintenanceLoading());
    await _subscription?.cancel();
    _subscription = getMaintenanceRecords(event.category).listen(
      (records) {
        add(UpdateStateWithRecords(records));
      },
    );
  }

  void _onUpdateStateWithRecords(
      UpdateStateWithRecords event, Emitter<MaintenanceState> emit) {
    emit(MaintenanceLoaded(event.records));
  }

  Future<void> _onAddRecord(
      AddMaintenanceRecord event, Emitter<MaintenanceState> emit) async {
    await addMaintenanceRecord(event.record);
  }

  Future<void> _onUpdateRecord(
      UpdateMaintenanceRecord event, Emitter<MaintenanceState> emit) async {
    await updateMaintenanceRecord(event.record);
  }

  Future<void> _onDeleteRecord(
      DeleteMaintenanceRecord event, Emitter<MaintenanceState> emit) async {
    await deleteMaintenanceRecord(event.record);
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
