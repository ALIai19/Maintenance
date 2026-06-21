import 'package:workmanager/workmanager.dart';
import '../../data/database/app_database.dart';
import '../../data/repositories/maintenance_repository_impl.dart';
import 'notification_service.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final database = AppDatabase();
    final repository = MaintenanceRepositoryImpl(database);
    final records = await repository.getAllRecords();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    for (final record in records) {
      final difference = record.dueDate.difference(today).inDays;
      if (difference <= 5 && difference >= 0) {
        await NotificationService.showNotification(
          id: record.id!,
          title: 'تنبيه صيانة مستحقة',
          body: 'مختبر ${record.labName} يستحق الصيانة خلال $difference أيام',
        );
      }
    }
    return Future.value(true);
  });
}

class BackgroundService {
  static Future<void> init() async {
    await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
    await Workmanager().registerPeriodicTask(
      "periodic-maintenance-check",
      "maintenanceCheckTask",
      frequency: const Duration(hours: 24),
      constraints: Constraints(
        networkType: NetworkType.not_required,
        requiresBatteryNotLow: true,
      ),
    );
  }
}
