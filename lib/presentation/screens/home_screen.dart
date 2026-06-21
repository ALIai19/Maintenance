import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';
import '../../domain/entities/maintenance_record.dart';
import 'category_detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('متابعة الصيانة الطبية'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCategoryCard(
              context,
              title: 'Fujifilm',
              subtitle: 'أجهزة الكيمياء والتحاليل',
              icon: Icons.biotech,
              color: AppTheme.fujifilmColor,
              category: MaintenanceCategory.fujifilm,
            ),
            const SizedBox(height: 16),
            _buildCategoryCard(
              context,
              title: 'Urine',
              subtitle: 'أجهزة تحليل البول',
              icon: Icons.opacity,
              color: AppTheme.urineColor,
              category: MaintenanceCategory.urine,
            ),
            const SizedBox(height: 16),
            _buildCategoryCard(
              context,
              title: 'CBC',
              subtitle: 'أجهزة عد الدم الكامل',
              icon: Icons.bloodtype,
              color: AppTheme.cbcColor,
              category: MaintenanceCategory.cbc,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required MaintenanceCategory category,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryDetailScreen(
                category: category,
                title: title,
                color: color,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            border: Border(right: BorderSide(color: color, width: 8)),
          ),
          child: Row(
            children: [
              Icon(icon, size: 48, color: color),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
