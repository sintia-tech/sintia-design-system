import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../helpers/pump_sintia.dart';

const List<SintiaNavItem> _items = <SintiaNavItem>[
  SintiaNavItem(
    label: 'Inicio',
    icon: Icons.dashboard_outlined,
    route: '/',
  ),
  SintiaNavItem(
    label: 'Pedidos',
    icon: Icons.receipt_long_outlined,
    route: '/orders',
  ),
];

void main() {
  group('SintiaPageTemplate', () {
    testWidgets('renderiza título, secciones y footer', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          const SintiaPageTemplate(
            title: 'Mi equipo',
            sections: <Widget>[Text('Sección A'), Text('Sección B')],
            footer: SintiaButton(label: 'Invitar', expanded: true),
          ),
        ),
      );

      expect(find.text('Mi equipo'), findsOneWidget);
      expect(find.text('Sección A'), findsOneWidget);
      expect(find.text('Sección B'), findsOneWidget);
      expect(find.widgetWithText(SintiaButton, 'Invitar'), findsOneWidget);
    });

    testWidgets('sin footer no dibuja la barra inferior', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          const SintiaPageTemplate(
            title: 'Mi equipo',
            sections: <Widget>[Text('Sección A')],
          ),
        ),
      );
      expect(find.byType(SintiaPageFooter), findsNothing);
    });

    testWidgets('limita el ancho del contenido en pantallas grandes', (
      WidgetTester tester,
    ) async {
      setViewSize(tester, const Size(1600, 900));
      await tester.pumpWidget(
        wrapSintiaScreen(
          const SintiaPageTemplate(
            title: 'Mi equipo',
            sections: <Widget>[Text('Sección A')],
          ),
        ),
      );

      expect(
        tester.getSize(find.byType(ListView)).width,
        SintiaBreakpoints.tablet,
      );
    });

    testWidgets('propaga las acciones a la app bar', (
      WidgetTester tester,
    ) async {
      bool pressed = false;
      await tester.pumpWidget(
        wrapSintiaScreen(
          SintiaPageTemplate(
            title: 'Mi equipo',
            actions: <SintiaAppBarAction>[
              SintiaAppBarAction(
                icon: Icons.search,
                tooltip: 'Buscar',
                onPressed: () => pressed = true,
              ),
            ],
            sections: const <Widget>[Text('Sección A')],
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.search));
      expect(pressed, isTrue);
    });
  });

  group('SintiaDetailPageTemplate', () {
    testWidgets('renderiza encabezado fijo, secciones y footer', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          const SintiaDetailPageTemplate(
            title: 'Perfil',
            header: Text('Encabezado'),
            sections: <Widget>[Text('Sección A'), Text('Sección B')],
            footer: SintiaButton(label: 'Contactar', expanded: true),
          ),
        ),
      );

      expect(find.text('Perfil'), findsOneWidget);
      expect(find.text('Encabezado'), findsOneWidget);
      expect(find.text('Sección A'), findsOneWidget);
      expect(find.widgetWithText(SintiaButton, 'Contactar'), findsOneWidget);
    });

    testWidgets('trae el botón de volver por defecto', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          const SintiaDetailPageTemplate(
            title: 'Perfil',
            header: Text('Encabezado'),
            sections: <Widget>[Text('Sección A')],
          ),
        ),
      );
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });

  group('SintiaShellTemplate', () {
    Widget shell({String route = '/', List<String>? selected}) {
      return wrapSintiaScreen(
        SintiaShellTemplate(
          items: _items,
          currentRoute: route,
          onRouteSelected: (String value) => selected?.add(value),
          logo: const Text('Mi empresa'),
          body: Text('Contenido de $route'),
        ),
      );
    }

    testWidgets('en escritorio el drawer es permanente y colapsable', (
      WidgetTester tester,
    ) async {
      setViewSize(tester, const Size(1400, 900));
      await tester.pumpWidget(shell(route: '/orders'));

      expect(find.byType(SintiaNavigationDrawer), findsOneWidget);
      expect(find.byType(Drawer), findsNothing);
      expect(find.text('Contenido de /orders'), findsOneWidget);
      // El título sale de la etiqueta del ítem activo.
      expect(find.text('Pedidos'), findsNWidgets(2));

      expect(
        tester.getSize(find.byType(SintiaNavigationDrawer)).width,
        SintiaNavDrawerMetrics.collapsedWidth,
      );

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(
        tester.getSize(find.byType(SintiaNavigationDrawer)).width,
        SintiaNavDrawerMetrics.expandedWidth,
      );
    });

    testWidgets('en móvil el drawer es modal y se abre desde la app bar', (
      WidgetTester tester,
    ) async {
      setViewSize(tester, const Size(400, 800));
      await tester.pumpWidget(shell());

      expect(find.byType(SintiaNavigationDrawer), findsNothing);

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.byType(Drawer), findsOneWidget);
      expect(find.byType(SintiaNavigationDrawer), findsOneWidget);
      // En móvil el drawer siempre va expandido y sin botón de colapsar.
      expect(find.text('Colapsar'), findsNothing);
    });

    testWidgets('en móvil elegir una ruta cierra el drawer y notifica', (
      WidgetTester tester,
    ) async {
      final List<String> selected = <String>[];
      setViewSize(tester, const Size(400, 800));
      await tester.pumpWidget(shell(selected: selected));

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Pedidos'));
      await tester.pumpAndSettle();

      expect(selected, <String>['/orders']);
      expect(find.byType(Drawer), findsNothing);
    });

    testWidgets('acepta una app bar propia', (WidgetTester tester) async {
      setViewSize(tester, const Size(1400, 900));
      await tester.pumpWidget(
        wrapSintiaScreen(
          SintiaShellTemplate(
            items: _items,
            currentRoute: '/',
            onRouteSelected: (_) {},
            appBar: const SintiaAppBar(title: 'Título propio'),
            body: const Text('Contenido'),
          ),
        ),
      );

      expect(find.text('Título propio'), findsOneWidget);
    });

    testWidgets('showAppBar false quita la app bar en escritorio', (
      WidgetTester tester,
    ) async {
      setViewSize(tester, const Size(1400, 900));
      await tester.pumpWidget(
        wrapSintiaScreen(
          SintiaShellTemplate(
            items: _items,
            currentRoute: '/',
            onRouteSelected: (_) {},
            showAppBar: false,
            body: const Text('Contenido'),
          ),
        ),
      );

      expect(find.byType(SintiaAppBar), findsNothing);
      expect(find.text('Contenido'), findsOneWidget);
    });
  });
}
