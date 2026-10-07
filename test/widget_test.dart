import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:egitim_merkezi/shared/demo_app.dart';
import 'package:egitim_merkezi/shared/demo_state.dart';
import 'package:egitim_merkezi/mock/mock_repository.dart';
import 'package:egitim_merkezi/models/entities.dart';
import 'package:egitim_merkezi/core/routing/navigation_config.dart';
import 'package:egitim_merkezi/core/widgets/seven_navigation.dart';

void main() {
  test('Parent context affects education but preserves family records', () {
    final repo = MockRepository();
    final state = DemoState(repo)..selectRole(DemoRole.parent);
    final before = repo.records(
      'Ders Programı',
      DemoRole.parent,
      state.childId,
    );
    final payments = repo.records(
      'Ödeme Özeti',
      DemoRole.parent,
      state.childId,
    );
    final messages = repo.records('Mesajlar', DemoRole.parent, state.childId);
    state.selectChild('zeynep');
    expect(
      repo.records('Ders Programı', DemoRole.parent, state.childId).first.title,
      isNot(before.first.title),
    );
    expect(
      repo.records('Ödeme Özeti', DemoRole.parent, state.childId),
      payments,
    );
    expect(repo.records('Mesajlar', DemoRole.parent, state.childId), messages);
    expect(payments.map((e) => e.studentId).toSet(), {'ahmet', 'zeynep'});
    expect(
      categories(DemoRole.parent).expand((c) => c.modules),
      isNot(contains('Giriş / Çıkış')),
    );
    state.dispose();
  });
  for (final width in [320.0, 375.0, 430.0]) {
    testWidgets('Every role and module at ${width.toInt()}px', (tester) async {
      tester.view.physicalSize = Size(width, 812);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(EducationApp(repository: MockRepository()));
      for (final role in DemoRole.values) {
        await tester.tap(find.text(roleLabel(role)));
        await tester.pumpAndSettle();
        expect(find.byType(SevenNavigation), findsOneWidget);
        final homeIcon = find.descendant(
          of: find.byKey(const ValueKey('nav-3')),
          matching: find.byType(Icon),
        );
        final otherIcon = find.descendant(
          of: find.byKey(const ValueKey('nav-0')),
          matching: find.byType(Icon),
        );
        expect(
          tester.getSize(homeIcon).width,
          greaterThan(tester.getSize(otherIcon).width),
        );
        for (var i = 0; i < 7; i++) {
          await tester.tap(find.byKey(ValueKey('nav-$i')));
          await tester.pumpAndSettle();
          expect(tester.takeException(), isNull, reason: '${role.name} tab $i');
          for (final module in categories(role)[i].modules) {
            await tester.tap(
              find
                  .descendant(
                    of: find.byType(Card),
                    matching: find.text(module),
                  )
                  .first,
            );
            await tester.pumpAndSettle();
            expect(
              tester.takeException(),
              isNull,
              reason: '${role.name} $module',
            );
            await tester.tap(find.byIcon(Icons.arrow_back));
            await tester.pumpAndSettle();
          }
        }
        for (final element
            in find
                .descendant(
                  of: find.byType(SevenNavigation),
                  matching: find.byType(Text),
                )
                .evaluate()) {
          final text = element.widget as Text;
          expect(text.overflow, isNot(TextOverflow.ellipsis));
          final render = element.findRenderObject() as RenderParagraph;
          expect(render.didExceedMaxLines, isFalse);
        }
        await tester.tap(find.byTooltip('Demo rolünü değiştir'));
        await tester.pumpAndSettle();
      }
    });
  }
  testWidgets('Child selection refreshes mounted dashboard and detail', (
    tester,
  ) async {
    await tester.pumpWidget(EducationApp(repository: MockRepository()));
    await tester.tap(find.text('Veli'));
    await tester.pumpAndSettle();
    expect(find.text('AHMET YILMAZ • 4-A'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('child-selector')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Zeynep').last);
    await tester.pumpAndSettle();
    expect(find.text('ZEYNEP YILMAZ • 3-B'), findsOneWidget);
    expect(find.text('Hayat Bilgisi'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('nav-4')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Ödeme Özeti'));
    await tester.pumpAndSettle();
    expect(find.text('Ekim • Ahmet Yılmaz'), findsOneWidget);
    expect(find.text('Ekim • Zeynep Yılmaz'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('nav-5')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mesajlar'));
    await tester.pumpAndSettle();
    expect(find.text('Yoklama bilgilendirmesi'), findsOneWidget);
    await tester.tap(find.widgetWithText(ChoiceChip, 'Zeynep'));
    await tester.pumpAndSettle();
    expect(find.text('Yoklama bilgilendirmesi'), findsNothing);
    expect(find.text('Yarın robotik etkinliği'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
