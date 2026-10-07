import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../core/routing/navigation_config.dart';
import '../core/widgets/seven_navigation.dart';
import '../core/widgets/content_widgets.dart';
import '../models/entities.dart';
import '../features/admin/admin_dashboard.dart';
import '../features/teacher/teacher_dashboard.dart';
import '../features/parent/parent_dashboard.dart';
import 'demo_state.dart';
import 'education_repository.dart';

class EducationApp extends StatefulWidget {
  const EducationApp({super.key, required this.repository});
  final EducationRepository repository;
  @override
  State<EducationApp> createState() => _EducationAppState();
}

class _EducationAppState extends State<EducationApp> {
  late final DemoState state = DemoState(widget.repository);
  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Pusula Eğitim Merkezi',
    theme: AppTheme.light,
    home: ListenableBuilder(
      listenable: state,
      builder: (context, _) =>
          state.role == null ? _RoleSelector(state) : _Shell(state),
    ),
  );
}

class _RoleSelector extends StatelessWidget {
  const _RoleSelector(this.state);
  final DemoState state;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.teal,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.explore_outlined,
                    color: Colors.white,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 26),
                Text(
                  'Pusula',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const Text(
                  'EĞİTİM MERKEZİ',
                  style: TextStyle(
                    letterSpacing: 3,
                    fontSize: 11,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 38),
                Text(
                  'Demo kullanıcı seç',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                const Text('Merkezinizi üç farklı bakış açısından keşfedin.'),
                const SizedBox(height: 24),
                ...DemoRole.values.map(
                  (role) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        leading: Icon(
                          [
                            Icons.business_center_outlined,
                            Icons.school_outlined,
                            Icons.family_restroom,
                          ][role.index],
                          color: AppTheme.teal,
                        ),
                        title: Text(roleLabel(role)),
                        subtitle: Text(state.repository.userName(role)),
                        trailing: const Icon(Icons.arrow_forward_rounded),
                        onTap: () => state.selectRole(role),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'UI/UX PROTOTİPİ',
                  style: TextStyle(
                    fontSize: 10,
                    letterSpacing: 2,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Bu demo, örnek verilerle çalışır.',
                  style: TextStyle(color: Colors.blueGrey),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _Shell extends StatelessWidget {
  const _Shell(this.state);
  final DemoState state;
  @override
  Widget build(BuildContext context) {
    final role = state.role!;
    final items = categories(role);
    final dashboard = state.tab == 3;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          if (state.module != null) {
            state.navigate(state.tab);
          } else if (state.tab != 3) {
            state.navigate(3);
          } else {
            state.selectRole(null);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: state.module == null
              ? null
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => state.navigate(state.tab),
                ),
          title: Text(
            state.module ?? (dashboard ? 'Pusula' : items[state.tab].label),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          actions: [
            if (role == DemoRole.parent)
              PopupMenuButton<String>(
                key: const ValueKey('child-selector'),
                tooltip: 'Aktif çocuk seç',
                initialValue: state.childId,
                onSelected: state.selectChild,
                itemBuilder: (context) => state.repository.parentChildren
                    .map(
                      (child) => PopupMenuItem(
                        value: child.id,
                        child: Row(
                          children: [
                            Icon(
                              child.id == state.childId
                                  ? Icons.check
                                  : Icons.person_outline,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(child.firstName),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      Text(
                        state.child.firstName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.keyboard_arrow_down, size: 18),
                    ],
                  ),
                ),
              ),
            IconButton(
              tooltip: 'Demo rolünü değiştir',
              icon: const Icon(Icons.swap_horiz_rounded),
              onPressed: () => state.selectRole(null),
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: SingleChildScrollView(
                key: ValueKey('${role.name}-${state.tab}-${state.module}'),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (dashboard) ...[
                      Text(
                        'Günaydın, ${state.repository.userName(role).split(' ').first}',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${state.repository.dateLabel} • ${roleLabel(role)}',
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 24),
                      switch (role) {
                        DemoRole.admin => AdminDashboard(state),
                        DemoRole.teacher => TeacherDashboard(state),
                        DemoRole.parent => ParentDashboard(state),
                      },
                    ] else if (state.module == null) ...[
                      Text(
                        'Her şey bir arada',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '${items[state.tab].label} işlemleri ve güncel bilgiler',
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                      const SizedBox(height: 24),
                      LayoutBuilder(
                        builder: (context, constraints) => Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: items[state.tab].modules
                              .asMap()
                              .entries
                              .map(
                                (entry) => SizedBox(
                                  width: (constraints.maxWidth - 12) / 2,
                                  child: Card(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(18),
                                      onTap: () => state.navigate(
                                        state.tab,
                                        entry.value,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(
                                              [
                                                items[state.tab].icon,
                                                Icons.view_list_outlined,
                                                Icons.event_note_outlined,
                                                Icons.folder_outlined,
                                              ][entry.key % 4],
                                              color: AppTheme.teal,
                                              size: 27,
                                            ),
                                            const SizedBox(height: 20),
                                            Text(
                                              entry.value,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium,
                                            ),
                                            const SizedBox(height: 8),
                                            const Icon(
                                              Icons.arrow_forward_rounded,
                                              size: 18,
                                              color: Colors.blueGrey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ] else
                      _Detail(state),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: SevenNavigation(
          items: items,
          selected: state.tab,
          onSelect: (i) => state.navigate(i),
        ),
      ),
    );
  }
}

class _Detail extends StatelessWidget {
  const _Detail(this.state);
  final DemoState state;
  @override
  Widget build(BuildContext context) {
    final module = state.module!;
    final role = state.role!;
    var records = state.repository.records(module, role, state.childId);
    final communication = role == DemoRole.parent && state.tab == 5;
    if (communication && state.communicationFilter != null) {
      records = records
          .where(
            (e) =>
                e.studentId == null || e.studentId == state.communicationFilter,
          )
          .toList();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(module, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          role == DemoRole.parent
              ? (module.contains('Ödeme') || communication
                    ? 'Tüm çocuklarınıza ait kayıtlar'
                    : '${state.child.name} • ${state.child.className}')
              : 'Güncel kayıtlar ve örnek bilgiler',
          style: const TextStyle(color: Colors.blueGrey),
        ),
        const SizedBox(height: 18),
        if (communication)
          Padding(
            padding: const EdgeInsets.only(bottom: 18),
            child: Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: const Text('Tümü'),
                  selected: state.communicationFilter == null,
                  onSelected: (_) => state.filter(null),
                ),
                ...state.repository.parentChildren.map(
                  (s) => ChoiceChip(
                    label: Text(s.firstName),
                    selected: state.communicationFilter == s.id,
                    onSelected: (_) => state.filter(s.id),
                  ),
                ),
              ],
            ),
          ),
        if (role == DemoRole.parent &&
            module.contains('Ödeme') &&
            module != 'Ödeme Geçmişi') ...[
          SummaryCard(
            label: 'EKİM • AİLE ÖDEME ÖZETİ',
            value: state.repository.dashboard(DemoRole.parent).first.title,
            subtitle: state.repository
                .dashboard(DemoRole.parent)
                .first
                .subtitle,
            icon: Icons.account_balance_wallet_outlined,
            onTap: () => state.navigate(4, 'Aylık Ödemeler'),
          ),
          const SizedBox(height: 14),
        ],
        if (records.isEmpty)
          const Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Text('Bu seçim için kayıt bulunmuyor.'),
            ),
          ),
        ...records.map(
          (e) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: RecordCard(e),
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Demo veriler • Düzenleme ve işlem akışları sonraki aşamada eklenecek.',
          style: TextStyle(fontSize: 12, color: Colors.blueGrey),
        ),
      ],
    );
  }
}
