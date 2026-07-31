import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

void main() {
  /// La showcase se prueba en escritorio: el drawer es permanente.
  void useDesktop(WidgetTester tester) {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1400, 900);
    addTearDown(tester.view.reset);
  }

  testWidgets('arranca en la bienvenida y navega a una categoría', (
    WidgetTester tester,
  ) async {
    useDesktop(tester);
    await tester.pumpWidget(const ShowcaseApp());
    await tester.pumpAndSettle();

    expect(find.text('Sistema de diseño Sintia'), findsOneWidget);

    // El drawer arranca colapsado: se navega por el ícono de la categoría.
    await tester.tap(find.byIcon(Icons.circle_outlined));
    await tester.pumpAndSettle();

    expect(find.text('Botones'), findsOneWidget);
    expect(find.text('Campos de texto'), findsOneWidget);
  });

  testWidgets('abre la página de un componente', (WidgetTester tester) async {
    useDesktop(tester);
    await tester.pumpWidget(const ShowcaseApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.circle_outlined));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Botones'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(SintiaButton, 'Primary'), findsOneWidget);
    expect(find.widgetWithText(SintiaButton, 'Danger'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(find.text('Botones'), findsOneWidget);
  });

  testWidgets('expande el drawer y navega por etiqueta', (
    WidgetTester tester,
  ) async {
    useDesktop(tester);
    await tester.pumpWidget(const ShowcaseApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Plantillas'));
    await tester.pumpAndSettle();

    expect(find.text('Shell con drawer'), findsOneWidget);
  });

  testWidgets('alterna entre tema claro y oscuro', (
    WidgetTester tester,
  ) async {
    useDesktop(tester);
    await tester.pumpWidget(const ShowcaseApp());
    await tester.pumpAndSettle();

    BuildContext context() => tester.element(find.byType(SintiaShellTemplate));
    expect(context().isDarkMode, isFalse);

    await tester.tap(find.byIcon(Icons.dark_mode_outlined));
    await tester.pumpAndSettle();

    expect(context().isDarkMode, isTrue);
    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
  });

  testWidgets('abre una página de ejemplo a pantalla completa', (
    WidgetTester tester,
  ) async {
    useDesktop(tester);
    await tester.pumpWidget(const ShowcaseApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.article_outlined));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Página de equipo'));
    await tester.pumpAndSettle();

    expect(find.text('Mi equipo'), findsOneWidget);
    expect(find.text('Victor García'), findsOneWidget);
    expect(
      find.widgetWithText(SintiaButton, 'Invitar integrante'),
      findsOneWidget,
    );
  });
}
