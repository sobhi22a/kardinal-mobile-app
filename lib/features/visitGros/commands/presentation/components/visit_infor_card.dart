import 'package:e_commerce_app/core/functions/static_values.dart';
import 'package:e_commerce_app/localization/AppLocalizations.dart';
import 'package:flutter/material.dart';

/// Card displaying visit plan information
class VisitInfoCard extends StatelessWidget {
  final Map<String, dynamic> visitPlanToday;
  final VoidCallback onCreateCommand;

  const VisitInfoCard({
    super.key,
    required this.visitPlanToday,
    required this.onCreateCommand,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations(currentLanguage);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoChips(t),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onCreateCommand,
                icon: const Icon(Icons.add),
                label: Text(t.text('create_new_command')),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChips(AppLocalizations t) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      alignment: WrapAlignment.center,
      children: [
        _InfoChip(
          icon: Icons.location_on,
          label: t.text('region'),
          value: visitPlanToday['regionName'] ?? t.text('not_set'),
          color: Colors.blue,
        ),
        _InfoChip(
          icon: Icons.calendar_today,
          label: t.text('date'),
          value: visitPlanToday['visitDate'] ?? t.text('not_set'),
          color: Colors.green,
        ),
        _InfoChip(
          icon: Icons.supervised_user_circle,
          label: t.text('responsable'),
          value: visitPlanToday['responsibleName'] ?? t.text('not_set'),
          color: Colors.purple,
        ),
      ],
    );
  }
}

/// Individual info chip widget
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}