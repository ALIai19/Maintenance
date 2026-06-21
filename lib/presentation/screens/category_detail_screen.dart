import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/maintenance_record.dart';
import '../../domain/repositories/maintenance_repository.dart';
import '../../domain/usecases/maintenance_usecases.dart';
import '../../data/repositories/maintenance_repository_impl.dart';
import '../../data/database/app_database.dart';
import '../blocs/maintenance_bloc.dart';
import '../blocs/maintenance_event.dart';
import '../blocs/maintenance_state.dart';
import '../widgets/maintenance_form_dialog.dart';
import '../widgets/maintenance_list_item.dart';

class CategoryDetailScreen extends StatelessWidget {
  final MaintenanceCategory category;
  final String title;
  final Color color;

  const CategoryDetailScreen({
    super.key,
    required this.category,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<MaintenanceRepository>(
      create: (context) => MaintenanceRepositoryImpl(context.read<AppDatabase>()),
      child: BlocProvider(
        create: (context) {
          final repo = context.read<MaintenanceRepository>();
          return MaintenanceBloc(
            getMaintenanceRecords: GetMaintenanceRecords(repo),
            addMaintenanceRecord: AddMaintenanceRecordUseCase(repo),
            updateMaintenanceRecord: UpdateMaintenanceRecordUseCase(repo),
            deleteMaintenanceRecord: DeleteMaintenanceRecordUseCase(repo),
          )..add(LoadRecordsByCategory(category));
        },
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(title),
              backgroundColor: color.withOpacity(0.1),
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'الصيانات المنجزة'),
                  Tab(text: 'الصيانات المستحقة'),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                _CompletedMaintenanceTab(category: category),
                _DueMaintenanceTab(),
              ],
            ),
            floatingActionButton: Builder(
              builder: (context) => FloatingActionButton.extended(
                onPressed: () => _showAddDialog(context),
                label: const Text('إضافة صيانة'),
                icon: const Icon(Icons.add),
                backgroundColor: color,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => MaintenanceFormDialog(
        category: category,
        onSave: (labName, maintenanceDate, dueDate) {
          context.read<MaintenanceBloc>().add(
                AddMaintenanceRecord(
                  MaintenanceRecordEntity(
                    category: category,
                    labName: labName,
                    maintenanceDate: maintenanceDate,
                    dueDate: dueDate,
                    status: MaintenanceStatus.completed,
                  ),
                ),
              );
        },
      ),
    );
  }
}

class _CompletedMaintenanceTab extends StatelessWidget {
  final MaintenanceCategory category;
  const _CompletedMaintenanceTab({required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaintenanceBloc, MaintenanceState>(
      builder: (context, state) {
        if (state is MaintenanceLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MaintenanceLoaded) {
          if (state.completedRecords.isEmpty) {
            return const Center(child: Text('لا توجد صيانات منجزة حالياً'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.completedRecords.length,
            itemBuilder: (context, index) {
              return MaintenanceListItem(record: state.completedRecords[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _DueMaintenanceTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MaintenanceBloc, MaintenanceState>(
      builder: (context, state) {
        if (state is MaintenanceLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is MaintenanceLoaded) {
          if (state.dueRecords.isEmpty) {
            return const Center(child: Text('لا توجد صيانات مستحقة قريباً'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.dueRecords.length,
            itemBuilder: (context, index) {
              return MaintenanceListItem(
                record: state.dueRecords[index],
                isDueTab: true,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
