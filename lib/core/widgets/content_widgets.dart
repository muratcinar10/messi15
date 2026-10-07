import 'package:flutter/material.dart';

import '../../models/entities.dart';
import '../theme/app_theme.dart';

class RecordCard extends StatelessWidget {
  const RecordCard(this.entry, {super.key});
  final Entry entry;
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  entry.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              if (entry.amount > 0)
                Text(
                  '${entry.amount} TL',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
            ],
          ),
          const SizedBox(height: 7),
          Text(entry.subtitle),
          if (entry.tag.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                entry.tag,
                style: const TextStyle(
                  color: AppTheme.teal,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

class SummaryCard extends StatelessWidget {
  const SummaryCard({
    super.key,
    required this.label,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.onTap,
    this.emphasis = false,
  });
  final String label, value, subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final bool emphasis;
  @override
  Widget build(BuildContext context) => Card(
    color: emphasis ? AppTheme.ink : Colors.white,
    child: InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 21,
                  color: emphasis ? const Color(0xFF9AD8CB) : AppTheme.teal,
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      color: emphasis ? Colors.white70 : Colors.blueGrey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 18,
                  color: emphasis ? Colors.white70 : Colors.blueGrey,
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              value,
              style: TextStyle(
                fontSize: 23,
                height: 1.2,
                fontWeight: FontWeight.w700,
                color: emphasis ? Colors.white : AppTheme.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: TextStyle(
                height: 1.5,
                color: emphasis ? Colors.white70 : Colors.blueGrey,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
