import 'package:flutter/material.dart';

import '../../core/widgets/content_widgets.dart';
import '../../models/entities.dart';
import '../../shared/demo_state.dart';

class ParentDashboard extends StatelessWidget {
  const ParentDashboard(this.state, {super.key});
  final DemoState state;
  @override
  Widget build(BuildContext context) {
    List<Entry> get(String m) =>
        state.repository.records(m, DemoRole.parent, state.childId);
    final summaries = state.repository.dashboard(DemoRole.parent);
    final programs = get('Ders Programı');
    final attendance = get('Yoklama Durumu');
    final opinion = get('Öğretmen Görüşleri').first;
    final material = get('Eğitim Materyalleri').first;
    final meeting = get('Veli Görüşmeleri').first;
    return Column(
      children: [
        SummaryCard(
          label: '${state.child.name.toUpperCase()} • ${state.child.className}',
          value: programs.first.title,
          subtitle:
              '${programs.first.subtitle}\nBugün ${programs.length} program',
          icon: Icons.calendar_month,
          emphasis: true,
          onTap: () => state.navigate(1, 'Ders Programı'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: 'Yoklama',
          value: attendance.first.tag,
          subtitle: attendance.first.title,
          icon: Icons.fact_check_outlined,
          onTap: () => state.navigate(2, 'Yoklama Durumu'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: 'Öğretmen görüşü',
          value: opinion.title,
          subtitle: opinion.subtitle,
          icon: Icons.chat_outlined,
          onTap: () => state.navigate(0, 'Öğretmen Görüşleri'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: 'Yeni materyal',
          value: material.title,
          subtitle: material.subtitle,
          icon: Icons.menu_book_outlined,
          onTap: () => state.navigate(0, 'Eğitim Materyalleri'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: 'Veli görüşmesi',
          value: meeting.title,
          subtitle: meeting.subtitle,
          icon: Icons.event_outlined,
          onTap: () => state.navigate(0, 'Veli Görüşmeleri'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: summaries[0].tag,
          value: summaries[0].title,
          subtitle: summaries[0].subtitle,
          icon: Icons.account_balance_wallet_outlined,
          onTap: () => state.navigate(4, 'Ödeme Özeti'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: summaries[1].tag,
          value: summaries[1].title,
          subtitle: summaries[1].subtitle,
          icon: Icons.notifications_none,
          onTap: () => state.navigate(5, 'Bildirimler'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: summaries[2].tag,
          value: summaries[2].title,
          subtitle: summaries[2].subtitle,
          icon: Icons.restaurant_outlined,
          onTap: () => state.navigate(6, 'Yemek Menüsü'),
        ),
      ],
    );
  }
}
