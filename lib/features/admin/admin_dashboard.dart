import 'package:flutter/material.dart';

import '../../core/widgets/content_widgets.dart';
import '../../shared/demo_state.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard(this.state, {super.key});
  final DemoState state;
  @override
  Widget build(BuildContext context) {
    final entries = state.repository.dashboard(state.role!);
    return Column(
      children: [
        SummaryCard(
          label: entries[0].tag,
          value: entries[0].title,
          subtitle: entries[0].subtitle,
          icon: Icons.wb_sunny_outlined,
          emphasis: true,
          onTap: () => state.navigate(1, 'Programlar'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: entries[1].tag,
          value: entries[1].title,
          subtitle: entries[1].subtitle,
          icon: Icons.people_outline,
          onTap: () => state.navigate(0, 'Öğrenciler'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: entries[2].tag,
          value: entries[2].title,
          subtitle: entries[2].subtitle,
          icon: Icons.school_outlined,
          onTap: () => state.navigate(1, 'Programlar'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: entries[3].tag,
          value: entries[3].title,
          subtitle: entries[3].subtitle,
          icon: Icons.account_balance_wallet_outlined,
          onTap: () => state.navigate(4, 'Ödemeler'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: entries[4].tag,
          value: entries[4].title,
          subtitle: entries[4].subtitle,
          icon: Icons.apartment_outlined,
          onTap: () => state.navigate(2, 'Yemek Menüsü'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: entries[5].tag,
          value: entries[5].title,
          subtitle: entries[5].subtitle,
          icon: Icons.chat_bubble_outline,
          onTap: () => state.navigate(5, 'Bildirimler'),
        ),
        const SizedBox(height: 12),
        SummaryCard(
          label: entries[6].tag,
          value: entries[6].title,
          subtitle: entries[6].subtitle,
          icon: Icons.tune,
          onTap: () => state.navigate(6, 'Kullanıcı & Yetkiler'),
        ),
      ],
    );
  }
}
