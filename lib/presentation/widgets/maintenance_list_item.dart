import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/maintenance_record.dart';
import '../blocs/maintenance_bloc.dart';
import '../blocs/maintenance_event.dart';
import 'maintenance_form_dialog.dart';

class MaintenanceListItem extends StatelessWidget {
  final MaintenanceRecordEntity record;
  final bool isDueTab;

  const MaintenanceListItem({
    super.key,
    required this.record,
    this.isDueTab = false,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final daysRemaining = record.dueDate.difference(today).inDays;

    Color? cardColor;
    if (isDueTab) {
      if (daysRemaining <= 1) {
        cardColor = AppTheme.urgencyHigh.withOpacity(0.1);
      } else if (daysRemaining <= 5) {
        cardColor = AppTheme.urgencyMedium.withOpacity(0.1);
      }
    }

    return Card(
      color: cardColor,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        title: Text(
          record.labName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('تاريخ الصيانة: ${DateFormat('yyyy-MM-dd').format(record.maintenanceDate)}'),
            Text('الاستحقاق: ${DateFormat('yyyy-MM-dd').format(record.dueDate)}'),
            if (isDueTab)
              Text(
                'متبقي: $daysRemaining أيام',
                style: TextStyle(
                  color: daysRemaining <= 1 ? AppTheme.urgencyHigh : AppTheme.urgencyMedium,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showActionMenu(context),
        ),
        onTap: () => _showDetails(context),
      ),
    );
  }

  void _showActionMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (bottomSheetContext) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.visibility),
            title: const Text('عرض التفاصيل'),
            onTap: () {
              Navigator.pop(bottomSheetContext);
              _showDetails(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('تعديل البيانات'),
            onTap: () {
              Navigator.pop(bottomSheetContext);
              _showEditDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('حذف السجل', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(bottomSheetContext);
              _showDeleteConfirmation(context);
            },
          ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(record.labName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('التصنيف: ${record.category.name.toUpperCase()}'),
            const SizedBox(height: 8),
            Text('تاريخ الصيانة: ${DateFormat('yyyy-MM-dd').format(record.maintenanceDate)}'),
            const SizedBox(height: 8),
            Text('تاريخ الاستحقاق: ${DateFormat('yyyy-MM-dd').format(record.dueDate)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إغلاق'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => MaintenanceFormDialog(
        category: record.category,
        initialLabName: record.labName,
        initialMaintenanceDate: record.maintenanceDate,
        initialDueDate: record.dueDate,
        onSave: (labName, maintenanceDate, dueDate) {
          context.read<MaintenanceBloc>().add(
                UpdateMaintenanceRecord(
                  record.copyWith(
                    labName: labName,
                    maintenanceDate: maintenanceDate,
                    dueDate: dueDate,
                  ),
                ),
              );
        },
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('تأكيد الحذف'),
        content: const Text('هل أنت متأكد من رغبتك في حذف هذا السجل؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              context.read<MaintenanceBloc>().add(DeleteMaintenanceRecord(record));
              Navigator.pop(dialogContext);
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
