import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../helpers/pump_sintia.dart';

void main() {
  group('SintiaText', () {
    testWidgets('hereda bodyMedium cuando no se pasa estilo', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(wrapSintia(const SintiaText('Hola')));

      final Text text = tester.widget<Text>(find.text('Hola'));
      final BuildContext context = tester.element(find.text('Hola'));
      expect(text.style, context.textTheme.bodyMedium);
    });

    testWidgets('respeta el estilo, el recorte y la semántica', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaText(
            'Hola',
            style: TextStyle(fontSize: 32),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            semanticsLabel: 'Saludo',
          ),
        ),
      );

      final Text text = tester.widget<Text>(find.byType(Text));
      expect(text.semanticsLabel, 'Saludo');
      expect(text.style?.fontSize, 32);
      expect(text.maxLines, 1);
      expect(text.overflow, TextOverflow.ellipsis);
    });
  });

  group('SintiaAvatar', () {
    testWidgets('muestra las iniciales de las dos primeras palabras', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(const SintiaAvatar(name: 'Victor García Hurtado')),
      );
      expect(find.text('VG'), findsOneWidget);
    });

    testWidgets('soporta nombres de una palabra y espacios extra', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(const SintiaAvatar(name: '  sintia ')),
      );
      expect(find.text('S'), findsOneWidget);
    });

    testWidgets('crece con el vocabulario de tamaños', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const Column(
            children: <Widget>[
              SintiaAvatar(name: 'A', size: SintiaSize.small),
              SintiaAvatar(name: 'B', size: SintiaSize.large),
            ],
          ),
        ),
      );

      final Iterable<CircleAvatar> avatars = tester.widgetList<CircleAvatar>(
        find.byType(CircleAvatar),
      );
      expect(avatars.first.radius, lessThan(avatars.last.radius!));
    });
  });

  group('SintiaButton', () {
    testWidgets('renderiza el botón Material de cada variante', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const Column(
            children: <Widget>[
              SintiaButton(label: 'a'),
              SintiaButton(label: 'b', variant: SintiaButtonVariant.outline),
              SintiaButton(label: 'c', variant: SintiaButtonVariant.ghost),
            ],
          ),
        ),
      );

      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('loading muestra el loader y bloquea el tap', (
      WidgetTester tester,
    ) async {
      bool pressed = false;
      await tester.pumpWidget(
        wrapSintia(
          SintiaButton(
            label: 'Guardar',
            loading: true,
            onPressed: () => pressed = true,
          ),
        ),
      );

      expect(find.byType(SintiaLoader), findsOneWidget);
      expect(find.text('Guardar'), findsNothing);

      await tester.tap(find.byType(SintiaButton));
      expect(pressed, isFalse);
    });

    testWidgets('gestiona su propia carga cuando onPressed es asíncrono', (
      WidgetTester tester,
    ) async {
      final Completer<void> completer = Completer<void>();
      await tester.pumpWidget(
        wrapSintia(
          SintiaButton(
            label: 'Guardar',
            loadingLabel: 'Guardando…',
            onPressed: () => completer.future,
          ),
        ),
      );

      expect(find.byType(SintiaLoader), findsNothing);

      await tester.tap(find.byType(SintiaButton));
      await tester.pump();

      expect(find.byType(SintiaLoader), findsOneWidget);
      expect(find.text('Guardando…'), findsOneWidget);

      completer.complete();
      await tester.pumpAndSettle();

      expect(find.byType(SintiaLoader), findsNothing);
      expect(find.text('Guardar'), findsOneWidget);
    });

    testWidgets('no entra en carga si onPressed es sincrónico', (
      WidgetTester tester,
    ) async {
      int taps = 0;
      await tester.pumpWidget(
        wrapSintia(SintiaButton(label: 'Sumar', onPressed: () => taps++)),
      );

      await tester.tap(find.byType(SintiaButton));
      await tester.pump();

      expect(taps, 1);
      expect(find.byType(SintiaLoader), findsNothing);
    });

    testWidgets('se deshabilita sin onPressed', (WidgetTester tester) async {
      await tester.pumpWidget(wrapSintia(const SintiaButton(label: 'Nada')));
      final FilledButton button = tester.widget<FilledButton>(
        find.byType(FilledButton),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('expanded ocupa todo el ancho disponible', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SizedBox(
            width: 400,
            child: SintiaButton(label: 'Continuar', expanded: true),
          ),
        ),
      );
      expect(tester.getSize(find.byType(FilledButton)).width, 400);
    });

    testWidgets('los tamaños definen alturas crecientes', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const Column(
            children: <Widget>[
              SintiaButton(label: 'S', size: SintiaSize.small),
              SintiaButton(label: 'L', size: SintiaSize.large),
            ],
          ),
        ),
      );

      final double small = tester
          .getSize(
            find.widgetWithText(
              FilledButton,
              'S',
            ),
          )
          .height;
      final double large = tester
          .getSize(
            find.widgetWithText(
              FilledButton,
              'L',
            ),
          )
          .height;
      expect(small, lessThan(large));
    });
  });

  group('SintiaTextField', () {
    testWidgets('muestra la etiqueta sobre el campo', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(const SintiaTextField(label: 'Correo', hint: 'tu@correo')),
      );

      expect(find.text('Correo'), findsOneWidget);
      expect(
        tester.getTopLeft(find.text('Correo')).dy,
        lessThan(tester.getTopLeft(find.byType(TextFormField)).dy),
      );
    });

    testWidgets('alterna la visibilidad del texto oculto', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaTextField(label: 'Contraseña', obscureText: true),
        ),
      );

      EditableText editable() => tester.widget(find.byType(EditableText));
      expect(editable().obscureText, isTrue);

      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pump();
      expect(editable().obscureText, isFalse);
    });

    testWidgets('valida con el validator del formulario', (
      WidgetTester tester,
    ) async {
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      await tester.pumpWidget(
        wrapSintia(
          Form(
            key: formKey,
            child: SintiaTextField(
              label: 'Correo',
              validator: (String? value) =>
                  (value ?? '').contains('@') ? null : 'Correo inválido',
            ),
          ),
        ),
      );

      expect(formKey.currentState?.validate(), isFalse);
      await tester.pump();
      expect(find.text('Correo inválido'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'yo@sintia.tech');
      expect(formKey.currentState?.validate(), isTrue);
    });

    testWidgets('notifica cambios y taps', (WidgetTester tester) async {
      String? changed;
      bool tapped = false;
      await tester.pumpWidget(
        wrapSintia(
          SintiaTextField(
            label: 'Nombre',
            onChanged: (String value) => changed = value,
            onTap: () => tapped = true,
          ),
        ),
      );

      await tester.tap(find.byType(TextFormField));
      await tester.enterText(find.byType(TextFormField), 'Sintia');

      expect(tapped, isTrue);
      expect(changed, 'Sintia');
    });
  });

  group('SintiaChip', () {
    testWidgets('es estático sin onSelected', (WidgetTester tester) async {
      await tester.pumpWidget(wrapSintia(const SintiaChip(label: 'Admin')));
      expect(tester.widget<RawChip>(find.byType(RawChip)).onSelected, isNull);
    });

    testWidgets('actúa como filtro con onSelected', (
      WidgetTester tester,
    ) async {
      bool? selected;
      await tester.pumpWidget(
        wrapSintia(
          SintiaChip(
            label: 'Flutter',
            onSelected: (bool value) => selected = value,
          ),
        ),
      );

      await tester.tap(find.byType(RawChip));
      expect(selected, isTrue);
    });

    testWidgets('tiñe el chip con el color del estado', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaChip(label: 'Activo', status: SintiaStatus.success),
        ),
      );

      final RawChip chip = tester.widget<RawChip>(find.byType(RawChip));
      final BuildContext context = tester.element(find.byType(RawChip));
      expect(chip.labelStyle?.color, context.statusColors.success);
      expect(chip.backgroundColor, isNotNull);
    });

    testWidgets('muestra el ícono de borrar con onDeleted', (
      WidgetTester tester,
    ) async {
      bool deleted = false;
      await tester.pumpWidget(
        wrapSintia(
          SintiaChip(label: 'Flutter', onDeleted: () => deleted = true),
        ),
      );

      await tester.tap(find.byIcon(Icons.cancel));
      expect(deleted, isTrue);
    });
  });

  group('SintiaIconAction', () {
    testWidgets('oculta el badge sin conteo', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapSintia(const SintiaIconAction(icon: Icons.search)),
      );
      expect(
        tester.widget<Badge>(find.byType(Badge)).isLabelVisible,
        isFalse,
      );
    });

    testWidgets('ignora conteos en cero o negativos', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(const SintiaIconAction(icon: Icons.search, badgeCount: 0)),
      );
      expect(
        tester.widget<Badge>(find.byType(Badge)).isLabelVisible,
        isFalse,
      );
    });

    testWidgets('muestra el conteo cuando es positivo', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaIconAction(
            icon: Icons.shopping_cart_outlined,
            badgeCount: 3,
          ),
        ),
      );
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('showBadge muestra el punto sin número', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        wrapSintia(
          const SintiaIconAction(icon: Icons.mail_outline, showBadge: true),
        ),
      );

      final Badge badge = tester.widget<Badge>(find.byType(Badge));
      expect(badge.isLabelVisible, isTrue);
      expect(badge.label, isNull);
    });

    testWidgets('dispara onPressed', (WidgetTester tester) async {
      bool pressed = false;
      await tester.pumpWidget(
        wrapSintia(
          SintiaIconAction(
            icon: Icons.search,
            tooltip: 'Buscar',
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.byType(IconButton));
      expect(pressed, isTrue);
    });
  });

  group('SintiaLoader', () {
    testWidgets('muestra la etiqueta opcional', (WidgetTester tester) async {
      await tester.pumpWidget(
        wrapSintia(const SintiaLoader(label: 'Cargando…')),
      );
      expect(find.text('Cargando…'), findsOneWidget);
    });
  });
}
