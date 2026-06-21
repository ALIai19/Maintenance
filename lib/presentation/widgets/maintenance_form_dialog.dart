import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/maintenance_record.dart';

class MaintenanceFormDialog extends StatefulWidget {
  final MaintenanceCategory category;
  final String? initialLabName;
  final DateTime? initialMaintenanceDate;
  final DateTime? initialDueDate;
  final void Function(String labName, DateTime maintenanceDate, DateTime dueDate) onSave;

  const MaintenanceFormDialog({
    super.key,
    required this.category,
    this.initialLabName,
    this.initialMaintenanceDate,
    this.initialDueDate,
    required this.onSave,
  });

  @override
  State<MaintenanceFormDialog> createState() => _MaintenanceFormDialogState();
}

class _MaintenanceFormDialogState extends State<MaintenanceFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _labNameController;
  late DateTime _maintenanceDate;
  late DateTime _dueDate;

  @override
  void initState() {
    super.initState();
    _labNameController = TextEditingController(text: widget.initialLabName);
    _maintenanceDate = widget.initialMaintenanceDate ?? DateTime.now();
    _dueDate = widget.initialDueDate ?? DateTime.now().add(const Duration(days: 180));
  }

  @override
  void dispose() {
    _labNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('إضافة/تعديل صيانة'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _labNameController,
                decoration: const InputDecoration(
                  labelText: 'اسم المختبر',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'الرجاء إدخال اسم المختبر' : null,
              ),
              const SizedBox(height: 16),
              _buildDatePickerTile(
                title: 'تاريخ الصيانة الحالية',
                date: _maintenanceDate,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _maintenanceDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) setState(() => _maintenanceDate = date);
                },
              ),
              const SizedBox(height: 8),
              _buildDatePickerTile(
                title: 'تاريخ الصيانة القادمة',
                date: _dueDate,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: _dueDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (date != null) setState(() => _dueDate = date);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('إلغاء'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onSave(_labNameController.text, _maintenanceDate, _dueDate);
              Navigator.pop(context);
            }
          },
          child: const Text('حفظ'),
        ),
      ],
    );
  }

  Widget _buildDatePickerTile({
    required String title,
    required DateTime date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.bodySmall),
                Text(
                  DateFormat('yyyy-MM-dd').format(date),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }
}
