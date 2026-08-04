import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../helpers/pump_sintia.dart';

const List<SintiaNavItem> _items = <SintiaNavItem>[
  SintiaNavItem(
    label: 'Inicio',
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
    route: '/',
  ),
  SintiaNavItem(
    label: 'Pedidos',
    icon: Icons.receipt_long_outlined,
    route: '/orders',
    badgeCount: 12,
  ),
];

const List<SintiaNavItem> _footerItems = <SintiaNavItem>[
  SintiaNavItem(
    label: 'Configuración',
    icon: Icons.settings_outlined,
    route: '/settings',
  ),
];

void main() {
  group('SintiaAppBar', () {
    testWidgets('sin leading alinea el título al inicio', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          const Scaffold(appBar: SintiaAppBar(title: 'Mis pedidos')),
        ),
      );

      final AppBar appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.centerTitle, isFalse);
      expect(appBar.leading, isNull);
      expect(find.text('Mis pedidos'), findsOneWidget);
    });

    testWidgets('el botón de volver hace pop', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            body: Builder(
              builder: (BuildContext context) => ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const Scaffold(
                      appBar: SintiaAppBar(
                        title: 'Detalle',
                        leading: SintiaAppBarLeading.back,
                      ),
                    ),
                  ),
                ),
                child: const Text('Ir'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Ir'));
      await tester.pumpAndSettle();
      expect(find.text('Detalle'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.text('Detalle'), findsNothing);
    });

    testWidgets('el leading de menú abre el drawer del Scaffold', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          const Scaffold(
            appBar: SintiaAppBar(
              title: 'Inicio',
              leading: SintiaAppBarLeading.menu,
            ),
            drawer: Drawer(child: Text('Menú lateral')),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();
      expect(find.text('Menú lateral'), findsOneWidget);
    });

    testWidgets('el leading de menú se oculta si no hay drawer', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          const Scaffold(
            appBar: SintiaAppBar(
              title: 'Inicio',
              leading: SintiaAppBarLeading.menu,
            ),
          ),
        ),
      );
      expect(find.byIcon(Icons.menu), findsNothing);
    });

    testWidgets('renderiza las acciones con badge y el título táctil', (
      WidgetTester tester,
    ) async {
      bool titlePressed = false;
      bool actionPressed = false;

      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            appBar: SintiaAppBar(
              title: 'Tienda el Centro',
              titleSuffix: const Icon(Icons.keyboard_arrow_down),
              onTitlePressed: () => titlePressed = true,
              actions: <SintiaAppBarAction>[
                SintiaAppBarAction(
                  icon: Icons.shopping_cart_outlined,
                  tooltip: 'Carrito',
                  badgeCount: 3,
                  onPressed: () => actionPressed = true,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.text('3'), findsOneWidget);

      await tester.tap(find.text('Tienda el Centro'));
      expect(titlePressed, isTrue);

      await tester.tap(find.byIcon(Icons.shopping_cart_outlined));
      expect(actionPressed, isTrue);
    });

    testWidgets('preferredSize incluye el widget inferior', (
      WidgetTester tester,
    ) async {
      const SintiaAppBar plain = SintiaAppBar(title: 'a');
      const SintiaAppBar withBottom = SintiaAppBar(
        title: 'a',
        bottom: TabBar(tabs: <Widget>[Tab(text: 'Uno')]),
      );
      expect(
        withBottom.preferredSize.height,
        greaterThan(plain.preferredSize.height),
      );
    });
  });

  group('SintiaDialog', () {
    testWidgets('renderiza las ranuras que recibe', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          SintiaDialog(
            icon: const Icon(Icons.mark_email_read_outlined),
            title: 'Revisa tu correo',
            message: 'Te enviamos un enlace.',
            primaryAction: SintiaButton(label: 'Entendido', onPressed: () {}),
            secondaryAction: SintiaButton(
              label: 'Cancelar',
              variant: SintiaButtonVariant.ghost,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.mark_email_read_outlined), findsOneWidget);
      expect(find.text('Revisa tu correo'), findsOneWidget);
      expect(find.text('Te enviamos un enlace.'), findsOneWidget);
      expect(find.byType(SintiaButton), findsNWidgets(2));
    });

    testWidgets('content tiene precedencia sobre message', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaDialog(
            title: 'Nuevo cliente',
            message: 'No debería verse',
            content: SintiaTextField(label: 'Nombre'),
          ),
        ),
      );

      expect(find.text('No debería verse'), findsNothing);
      expect(find.byType(SintiaTextField), findsOneWidget);
    });

    testWidgets('el botón de cierre hace pop', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            body: Builder(
              builder: (BuildContext context) => ElevatedButton(
                onPressed: () => SintiaDialog.show<void>(
                  context: context,
                  dialog: const SintiaDialog(
                    title: 'Aviso',
                    showCloseButton: true,
                  ),
                ),
                child: const Text('Abrir'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      expect(find.text('Aviso'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      await tester.pumpAndSettle();
      expect(find.text('Aviso'), findsNothing);
    });

    testWidgets('sin showCloseButton no dibuja la X', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrapSintia(const SintiaDialog(title: 'Aviso')));
      expect(find.byIcon(Icons.close), findsNothing);
    });

    testWidgets('width y height fijan el tamaño del diálogo', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaDialog(title: 'Aviso', width: 320, height: 220),
        ),
      );

      final Size size = tester.getSize(
        find
            .descendant(
              of: find.byType(Dialog),
              matching: find.byType(SizedBox),
            )
            .first,
      );
      expect(size.width, 320);
      expect(size.height, 220);
    });

    testWidgets('titleColor y titleStyle override el título', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaDialog(
            title: 'Aviso',
            titleColor: Colors.amber,
            titleStyle: TextStyle(fontSize: 22),
          ),
        ),
      );

      final Text text = tester.widget<Text>(find.text('Aviso'));
      expect(text.style?.color, Colors.amber);
      expect(text.style?.fontSize, 22);
    });
  });

  group('SintiaListSection', () {
    testWidgets('muestra encabezado, acción y elementos', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaListSection(
            title: 'Integrantes',
            action: SintiaButton(
              label: 'Agregar',
              variant: SintiaButtonVariant.ghost,
            ),
            items: <SintiaListItem>[
              SintiaListItem(
                title: 'Victor García',
                subtitle: 'victor@sintia.tech',
                avatarName: 'Victor García',
                tag: 'Admin',
              ),
              SintiaListItem(title: 'Laura Pérez', avatarName: 'Laura Pérez'),
            ],
          ),
        ),
      );

      expect(find.text('Integrantes'), findsOneWidget);
      expect(find.text('Agregar'), findsOneWidget);
      expect(find.byType(SintiaAvatar), findsNWidgets(2));
      expect(find.widgetWithText(SintiaChip, 'Admin'), findsOneWidget);
    });

    testWidgets('muestra el emptyState sin elementos', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaListSection(
            title: 'Invitaciones',
            items: <SintiaListItem>[],
          ),
        ),
      );

      expect(find.byType(SintiaEmptyState), findsOneWidget);
      expect(find.text('Sin elementos'), findsOneWidget);
    });
  });

  group('SintiaProfileHeader', () {
    testWidgets('muestra avatar, datos, etiquetas y acciones', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaProfileHeader(
            name: 'Victor García',
            subtitle: 'Desarrollador móvil',
            tags: <String>['Flutter', 'Dart'],
            actions: <Widget>[SintiaButton(label: 'Editar')],
          ),
        ),
      );

      expect(find.byType(SintiaAvatar), findsOneWidget);
      expect(find.text('Desarrollador móvil'), findsOneWidget);
      expect(find.byType(SintiaChip), findsNWidgets(2));
      expect(find.widgetWithText(SintiaButton, 'Editar'), findsOneWidget);
    });

    testWidgets('solo el nombre es obligatorio', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapSintia(const SintiaProfileHeader(name: 'Laura Pérez')),
      );
      expect(find.byType(SintiaChip), findsNothing);
      expect(find.byType(SintiaButton), findsNothing);
    });
  });

  group('SintiaNavigationDrawer', () {
    testWidgets('expandido muestra las etiquetas y ancho completo', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            body: SintiaNavigationDrawer(
              items: _items,
              footerItems: _footerItems,
              currentRoute: '/orders',
              onItemSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Pedidos'), findsOneWidget);
      expect(find.text('Configuración'), findsOneWidget);
      expect(
        tester.getSize(find.byType(SintiaNavigationDrawer)).width,
        SintiaNavDrawerMetrics.expandedWidth,
      );
    });

    testWidgets('colapsado usa el ancho de rail', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            body: SintiaNavigationDrawer(
              items: _items,
              currentRoute: '/orders',
              collapsed: true,
              onItemSelected: (_) {},
            ),
          ),
        ),
      );

      expect(
        tester.getSize(find.byType(SintiaNavigationDrawer)).width,
        SintiaNavDrawerMetrics.collapsedWidth,
      );
    });

    testWidgets('marca como seleccionado el ítem de la ruta activa', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            body: SintiaNavigationDrawer(
              items: _items,
              currentRoute: '/',
              onItemSelected: (_) {},
            ),
          ),
        ),
      );

      final Iterable<SintiaNavDrawerItem> tiles = tester
          .widgetList<SintiaNavDrawerItem>(find.byType(SintiaNavDrawerItem));
      expect(
        tiles.where((SintiaNavDrawerItem tile) => tile.selected).length,
        1,
      );
      expect(find.byIcon(Icons.dashboard), findsOneWidget);
    });

    testWidgets('el ítem de colapsar solo aparece con onToggleCollapsed', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            body: SintiaNavigationDrawer(
              items: _items,
              currentRoute: '/',
              onItemSelected: (_) {},
            ),
          ),
        ),
      );
      expect(find.text('Colapsar'), findsNothing);

      bool toggled = false;
      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            body: SintiaNavigationDrawer(
              items: _items,
              currentRoute: '/',
              onToggleCollapsed: () => toggled = true,
              onItemSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Colapsar'), findsOneWidget);
      await tester.tap(find.text('Colapsar'));
      expect(toggled, isTrue);
    });

    testWidgets('notifica la ruta seleccionada', (WidgetTester tester) async {
      String? route;
      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            body: SintiaNavigationDrawer(
              items: _items,
              currentRoute: '/',
              onItemSelected: (SintiaNavItem item) => route = item.route,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Pedidos'));
      expect(route, '/orders');
    });

    testWidgets('cruza logo y mark según el estado', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            body: SintiaNavigationDrawer(
              items: _items,
              currentRoute: '/',
              logo: const Text('Mi empresa'),
              mark: const Text('M'),
              onItemSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(SintiaNavDrawerHeader), findsOneWidget);
      expect(find.text('Mi empresa'), findsOneWidget);
      expect(find.text('M'), findsOneWidget);
    });

    testWidgets('sin logo ni header no dibuja encabezado', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            body: SintiaNavigationDrawer(
              items: _items,
              currentRoute: '/',
              onItemSelected: (_) {},
            ),
          ),
        ),
      );
      expect(find.byType(SintiaNavDrawerHeader), findsNothing);
    });

    testWidgets('header personalizado reemplaza el de marca', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintiaScreen(
          Scaffold(
            body: SintiaNavigationDrawer(
              items: _items,
              currentRoute: '/',
              logo: const Text('Ignorado'),
              header: const Text('Encabezado propio'),
              footer: const Text('Pie propio'),
              onItemSelected: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Encabezado propio'), findsOneWidget);
      expect(find.text('Pie propio'), findsOneWidget);
      expect(find.byType(SintiaNavDrawerHeader), findsNothing);
    });
  });
}
