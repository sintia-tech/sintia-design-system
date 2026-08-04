import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../helpers/pump_sintia.dart';

void main() {
  group('SintiaCard', () {
    testWidgets('no es interactiva sin onTap', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapSintia(const SintiaCard(child: SintiaText('Contenido'))),
      );
      expect(find.byType(InkWell), findsNothing);
    });

    testWidgets('con onTap responde al toque', (WidgetTester tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        wrapSintia(
          SintiaCard(
            onTap: () => tapped = true,
            child: const SintiaText('Contenido'),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      expect(tapped, isTrue);
    });

    testWidgets('showBorder dibuja el borde del tema', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaCard(showBorder: true, child: SintiaText('Contenido')),
        ),
      );

      final Card card = tester.widget<Card>(find.byType(Card));
      final RoundedRectangleBorder shape =
          card.shape! as RoundedRectangleBorder;
      final BuildContext context = tester.element(find.byType(Card));
      expect(shape.side.color, context.colorScheme.outlineVariant);
    });
  });

  group('SintiaBanner', () {
    testWidgets('muestra título, mensaje y cierre', (
      WidgetTester tester,
    ) async {
      bool closed = false;
      await tester.pumpWidget(
        wrapSintia(
          SintiaBanner(
            status: SintiaStatus.success,
            title: 'Listo',
            message: 'Cambios guardados.',
            onClose: () => closed = true,
          ),
        ),
      );

      expect(find.text('Listo'), findsOneWidget);
      expect(find.text('Cambios guardados.'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);

      await tester.tap(find.byIcon(Icons.close));
      expect(closed, isTrue);
    });

    testWidgets('sin onClose no muestra el botón de cerrar', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(const SintiaBanner(message: 'Solo informativo.')),
      );
      expect(find.byIcon(Icons.close), findsNothing);
      expect(find.byIcon(Icons.info_outline), findsOneWidget);
    });

    testWidgets('usa el ícono y color de cada estado', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const Column(
            children: <Widget>[
              SintiaBanner(status: SintiaStatus.warning, message: 'a'),
              SintiaBanner(status: SintiaStatus.error, message: 'b'),
            ],
          ),
        ),
      );

      expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);

      final BuildContext context = tester.element(
        find.byIcon(Icons.error_outline),
      );
      final Icon errorIcon = tester.widget<Icon>(
        find.byIcon(Icons.error_outline),
      );
      expect(errorIcon.color, context.colorScheme.error);
    });

    testWidgets('renderiza la acción opcional', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapSintia(
          SintiaBanner(
            message: 'Falló la sincronización.',
            action: SintiaButton(label: 'Reintentar', onPressed: () {}),
          ),
        ),
      );
      expect(find.widgetWithText(SintiaButton, 'Reintentar'), findsOneWidget);
    });
  });

  group('SintiaEmptyState', () {
    testWidgets('muestra título, mensaje y acción', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaEmptyState(
            title: 'Sin resultados',
            message: 'Intenta con otra búsqueda.',
            action: SintiaButton(label: 'Reintentar'),
          ),
        ),
      );

      expect(find.text('Sin resultados'), findsOneWidget);
      expect(find.text('Intenta con otra búsqueda.'), findsOneWidget);
      expect(find.byType(SintiaButton), findsOneWidget);
    });

    testWidgets('solo el título es obligatorio', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapSintia(const SintiaEmptyState(title: 'Sin datos')),
      );
      expect(find.byType(SintiaButton), findsNothing);
    });
  });

  group('SintiaListTile', () {
    testWidgets('muestra avatar, textos y etiqueta', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaListTile(
            title: 'Victor García',
            subtitle: 'Desarrollador móvil',
            avatarName: 'Victor García',
            tag: 'Admin',
          ),
        ),
      );

      expect(find.byType(SintiaAvatar), findsOneWidget);
      expect(find.text('Desarrollador móvil'), findsOneWidget);
      expect(find.widgetWithText(SintiaChip, 'Admin'), findsOneWidget);
    });

    testWidgets('el avatar tiene precedencia sobre el ícono', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaListTile(
            title: 'Victor',
            avatarName: 'Victor',
            leadingIcon: Icons.person,
          ),
        ),
      );

      expect(find.byType(SintiaAvatar), findsOneWidget);
      expect(find.byIcon(Icons.person), findsNothing);
    });

    testWidgets('trailing tiene precedencia sobre tag', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaListTile(
            title: 'Configuración',
            tag: 'Nuevo',
            trailing: Icon(Icons.chevron_right),
          ),
        ),
      );

      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      expect(find.byType(SintiaChip), findsNothing);
    });
  });

  group('SintiaCheckOption', () {
    testWidgets('toda la fila alterna el valor', (WidgetTester tester) async {
      bool? value;
      await tester.pumpWidget(
        wrapSintia(
          SintiaCheckOption(
            value: false,
            onChanged: (bool next) => value = next,
            label: 'Acepto los',
            linkText: 'Términos',
          ),
        ),
      );

      await tester.tap(find.text('Acepto los Términos'));
      expect(value, isTrue);
    });

    testWidgets('muestra el check cuando está marcada', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          SintiaCheckOption(
            value: true,
            onChanged: (_) {},
            label: 'Acepto',
          ),
        ),
      );
      expect(find.byIcon(Icons.check), findsOneWidget);
    });
  });

  group('SintiaOtpField', () {
    testWidgets('avanza el foco y notifica una sola vez al completar', (
      WidgetTester tester,
    ) async {
      final List<String> completed = <String>[];
      final List<String> changes = <String>[];

      await tester.pumpWidget(
        wrapSintia(
          SizedBox(
            width: 300,
            child: SintiaOtpField(
              length: 3,
              onChanged: changes.add,
              onCompleted: completed.add,
            ),
          ),
        ),
      );

      final Finder fields = find.byType(TextField);
      expect(fields, findsNWidgets(3));

      await tester.enterText(fields.at(0), '1');
      await tester.pump();
      await tester.enterText(fields.at(1), '2');
      await tester.pump();
      await tester.enterText(fields.at(2), '3');
      await tester.pump();

      expect(completed, <String>['123']);
      expect(changes.last, '123');

      // Reeditar el último dígito no vuelve a disparar onCompleted.
      await tester.enterText(fields.at(2), '4');
      await tester.pump();
      expect(completed, <String>['123']);
    });
  });

  group('SintiaConfirmDialog', () {
    testWidgets('es puro: notifica por callbacks sin Navigator', (
      WidgetTester tester,
    ) async {
      bool confirmed = false;
      bool cancelled = false;

      await tester.pumpWidget(
        wrapSintia(
          SintiaConfirmDialog(
            title: '¿Continuar?',
            message: 'Sin navegación involucrada.',
            onConfirm: () => confirmed = true,
            onCancel: () => cancelled = true,
          ),
        ),
      );

      await tester.tap(find.text('Confirmar'));
      expect(confirmed, isTrue);

      await tester.tap(find.text('Cancelar'));
      expect(cancelled, isTrue);
    });

    testWidgets('show resuelve true al confirmar', (
      WidgetTester tester,
    ) async {
      bool? result;
      await tester.pumpWidget(
        wrapSintia(
          Builder(
            // Se abre con un botón de Material y no con SintiaButton: un
            // onPressed asíncrono dejaría el botón en estado de carga (con su
            // animación) mientras el diálogo está abierto, y pumpAndSettle no
            // podría estabilizarse.
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () async {
                result = await SintiaConfirmDialog.show(
                  context: context,
                  title: '¿Eliminar?',
                  message: 'No se puede deshacer.',
                  confirmLabel: 'Eliminar',
                  danger: true,
                );
              },
              child: const Text('Abrir'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      expect(find.text('¿Eliminar?'), findsOneWidget);
      expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);

      await tester.tap(find.text('Eliminar'));
      await tester.pumpAndSettle();
      expect(result, isTrue);
    });

    testWidgets('show resuelve false al cancelar', (
      WidgetTester tester,
    ) async {
      bool? result;
      await tester.pumpWidget(
        wrapSintia(
          Builder(
            builder: (BuildContext context) => ElevatedButton(
              onPressed: () async {
                result = await SintiaConfirmDialog.show(
                  context: context,
                  title: '¿Salir?',
                  message: 'Perderás los cambios.',
                );
              },
              child: const Text('Abrir'),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Abrir'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancelar'));
      await tester.pumpAndSettle();
      expect(result, isFalse);
    });
  });

  group('SintiaSuccessView', () {
    testWidgets('muestra el check de éxito y dispara la acción', (
      WidgetTester tester,
    ) async {
      bool pressed = false;
      await tester.pumpWidget(
        wrapSintia(
          SintiaSuccessView(
            title: '¡Listo!',
            message: 'Todo salió bien.',
            actionLabel: 'Continuar',
            onAction: () => pressed = true,
          ),
        ),
      );

      final Icon icon = tester.widget<Icon>(
        find.byIcon(Icons.check_circle_rounded),
      );
      final BuildContext context = tester.element(
        find.byType(SintiaText).first,
      );
      expect(icon.color, context.statusColors.success);

      await tester.tap(find.text('Continuar'));
      expect(pressed, isTrue);
    });
  });

  group('SintiaAppBarTitle', () {
    testWidgets('sin onPressed no es táctil', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapSintia(const SintiaAppBarTitle(text: 'Mis pedidos')),
      );
      expect(find.byType(InkWell), findsNothing);
    });

    testWidgets('con onPressed toda el área es táctil', (
      WidgetTester tester,
    ) async {
      bool pressed = false;
      await tester.pumpWidget(
        wrapSintia(
          SintiaAppBarTitle(
            text: 'Tienda el Centro',
            prefix: const Icon(Icons.store_outlined),
            suffix: const Icon(Icons.keyboard_arrow_down),
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      expect(pressed, isTrue);
      expect(find.byIcon(Icons.store_outlined), findsOneWidget);
      expect(find.byIcon(Icons.keyboard_arrow_down), findsOneWidget);
    });
  });

  group('SintiaNavDrawerItem', () {
    testWidgets('resalta el ítem seleccionado con el color de marca', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SizedBox(
            width: SintiaNavDrawerMetrics.expandedWidth,
            child: SintiaNavDrawerItem(
              item: SintiaNavItem(
                label: 'Pedidos',
                icon: Icons.receipt_long_outlined,
                selectedIcon: Icons.receipt_long,
                route: '/orders',
              ),
              selected: true,
              collapsed: false,
              onSelected: _noop,
            ),
          ),
        ),
      );

      final Material material = tester.widget<Material>(
        find.descendant(
          of: find.byType(SintiaNavDrawerItem),
          matching: find.byType(Material),
        ),
      );
      final BuildContext context = tester.element(
        find.byType(SintiaNavDrawerItem),
      );
      expect(material.color, context.colorScheme.primary);
      expect(find.byIcon(Icons.receipt_long), findsOneWidget);
    });

    testWidgets('colapsado agrega tooltip con la etiqueta', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SizedBox(
            width: SintiaNavDrawerMetrics.collapsedWidth,
            child: SintiaNavDrawerItem(
              item: SintiaNavItem(
                label: 'Clientes',
                icon: Icons.people_outline,
                route: '/customers',
              ),
              selected: false,
              collapsed: true,
              onSelected: _noop,
            ),
          ),
        ),
      );

      expect(find.byType(Tooltip), findsOneWidget);
      expect(
        tester.widget<Tooltip>(find.byType(Tooltip)).message,
        'Clientes',
      );
    });

    testWidgets('notifica el ítem al tocarlo y dibuja el divisor', (
      WidgetTester tester,
    ) async {
      SintiaNavItem? selected;
      await tester.pumpWidget(
        wrapSintia(
          SizedBox(
            width: SintiaNavDrawerMetrics.expandedWidth,
            child: SintiaNavDrawerItem(
              item: const SintiaNavItem(
                label: 'Reportes',
                icon: Icons.insert_chart_outlined,
                route: '/reports',
                dividerAbove: true,
                badgeCount: 4,
              ),
              selected: false,
              collapsed: false,
              onSelected: (SintiaNavItem item) => selected = item,
            ),
          ),
        ),
      );

      expect(find.byType(Divider), findsOneWidget);
      expect(find.text('4'), findsOneWidget);

      await tester.tap(find.byType(InkWell));
      expect(selected?.route, '/reports');
    });
  });

  group('SintiaSegmentedControl', () {
    const List<SintiaSegment<String>> segments = <SintiaSegment<String>>[
      SintiaSegment<String>(value: 'es', label: 'Español'),
      SintiaSegment<String>(value: 'en', label: 'EN'),
    ];

    testWidgets('notifica el valor del segmento tocado', (
      WidgetTester tester,
    ) async {
      String? changed;
      await tester.pumpWidget(
        wrapSintia(
          SintiaSegmentedControl<String>(
            segments: segments,
            value: 'es',
            onChanged: (String value) => changed = value,
          ),
        ),
      );

      await tester.tap(find.text('EN'));
      expect(changed, 'en');
    });

    testWidgets('no notifica al tocar el segmento activo', (
      WidgetTester tester,
    ) async {
      String? changed;
      await tester.pumpWidget(
        wrapSintia(
          SintiaSegmentedControl<String>(
            segments: segments,
            value: 'es',
            onChanged: (String value) => changed = value,
          ),
        ),
      );

      await tester.tap(find.text('Español'));
      expect(changed, isNull);
    });

    testWidgets('rellena el segmento activo con el color de marca', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          SintiaSegmentedControl<String>(
            segments: segments,
            value: 'es',
            onChanged: (_) {},
          ),
        ),
      );

      final BuildContext context = tester.element(find.text('Español'));
      BoxDecoration decorationOf(String label) {
        return tester
                .widget<Container>(
                  find
                      .ancestor(
                        of: find.text(label),
                        matching: find.byType(Container),
                      )
                      .first,
                )
                .decoration!
            as BoxDecoration;
      }

      expect(decorationOf('Español').color, context.colorScheme.primary);
      expect(decorationOf('EN').color, Colors.transparent);
      expect(
        tester.widget<Text>(find.text('Español')).style?.color,
        context.colorScheme.onPrimary,
      );
    });

    testWidgets('expanded reparte el ancho en segmentos iguales', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          SintiaSegmentedControl<String>(
            segments: segments,
            value: 'es',
            expanded: true,
            onChanged: (_) {},
          ),
        ),
      );

      final double first = tester.getSize(find.byType(InkWell).at(0)).width;
      final double second = tester.getSize(find.byType(InkWell).at(1)).width;
      expect(first, greaterThan(0));
      expect(first, second);
    });

    testWidgets('un segmento sin texto muestra su tooltip', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          SintiaSegmentedControl<bool>(
            value: false,
            segments: const <SintiaSegment<bool>>[
              SintiaSegment<bool>(
                value: false,
                icon: Icons.view_list_outlined,
                tooltip: 'Lista',
              ),
              SintiaSegment<bool>(
                value: true,
                icon: Icons.grid_view_outlined,
                tooltip: 'Cuadrícula',
              ),
            ],
            size: SintiaSize.large,
            onChanged: (_) {},
          ),
        ),
      );

      expect(find.byType(Tooltip), findsNWidgets(2));
      expect(find.byIcon(Icons.grid_view_outlined), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('los overrides de color y radio ganan sobre el tema', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          SintiaSegmentedControl<String>(
            segments: segments,
            value: 'es',
            selectedBackgroundColor: Colors.amber,
            selectedForegroundColor: Colors.black,
            unselectedForegroundColor: Colors.white70,
            borderRadius: const BorderRadius.all(Radius.circular(4)),
            onChanged: (_) {},
          ),
        ),
      );

      BoxDecoration decorationOf(String label) {
        return tester
                .widget<Container>(
                  find
                      .ancestor(
                        of: find.text(label),
                        matching: find.byType(Container),
                      )
                      .first,
                )
                .decoration!
            as BoxDecoration;
      }

      expect(decorationOf('Español').color, Colors.amber);
      expect(
        decorationOf('Español').borderRadius,
        const BorderRadius.all(Radius.circular(4)),
      );
      expect(
        tester.widget<Text>(find.text('Español')).style?.color,
        Colors.black,
      );
      expect(
        tester.widget<Text>(find.text('EN')).style?.color,
        Colors.white70,
      );
    });

    testWidgets('los estilos de etiqueta ganan sobre el peso automático', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          SintiaSegmentedControl<String>(
            segments: segments,
            value: 'es',
            selectedLabelStyle: const TextStyle(fontSize: 20),
            onChanged: (_) {},
          ),
        ),
      );

      expect(tester.widget<Text>(find.text('Español')).style?.fontSize, 20);
    });
  });
}

void _noop(SintiaNavItem item) {}
