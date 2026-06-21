import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';
import '../../domain/entities/maintenance_record.dart';

part 'app_database.g.dart';

@DataClassName('MaintenanceRecord')
class MaintenanceRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get category => textEnum<MaintenanceCategory>()();
  TextColumn get labName => text().withLength(min: 1, max: 100)();
  DateTimeColumn get maintenanceDate => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  TextColumn get status => textEnum<MaintenanceStatus>()();
}

@DriftDatabase(tables: [MaintenanceRecords])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // CRUD Operations
  Future<List<MaintenanceRecord>> getAllRecords() => select(maintenanceRecords).get();

  Stream<List<MaintenanceRecord>> watchRecordsByCategory(MaintenanceCategory category) {
    return (select(maintenanceRecords)..where((t) => t.category.equals(category.name))).watch();
  }

  Future<int> insertRecord(MaintenanceRecordsCompanion entry) =>
    into(maintenanceRecords).insert(entry);

  Future<bool> updateRecord(MaintenanceRecord entry) =>
    update(maintenanceRecords).replace(entry);

  Future<int> deleteRecord(MaintenanceRecord entry) =>
    delete(maintenanceRecords).delete(entry);

  Future<List<MaintenanceRecord>> getDueRecords() {
     final now = DateTime.now();
     // Typically records are due if dueDate is close to now,
     // but the requirement says "automated transfer if <= 5 days"
     // We will fetch all records and the logic will be handled or use a specific query
     return (select(maintenanceRecords)..where((t) => t.dueDate.isSmallerOrEqualValue(now.add(const Duration(days: 5))))).get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
