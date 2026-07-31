import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../helpers/pump_sintia.dart';

void main() {
  group('SintiaThemeContextExtension', () {
    testWidgets('expone tema, colores y tipografía', (
      WidgetTester tester,
    ) async {
      late BuildContext capturedContext;
      await tester.pumpWidget(
        wrapSintia(
          Builder(
            builder: (BuildContext context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      expect(capturedContext.theme, isA<ThemeData>());
      expect(capturedContext.primaryColor, capturedContext.colorScheme.primary);
      expect(capturedContext.errorColor, capturedContext.colorScheme.error);
      expect(capturedContext.surfaceColor, capturedContext.colorScheme.surface);
      expect(capturedContext.textTheme, capturedContext.theme.textTheme);
      expect(capturedContext.isDarkMode, isFalse);
      expect(capturedContext.statusColors, SintiaStatusColors.light);
    });

    testWidgets('cae en los defaults si el tema no registra la extensión', (
      WidgetTester tester,
    ) async {
      late BuildContext lightContext;
      late BuildContext darkContext;

      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: Builder(
            builder: (BuildContext context) {
              lightContext = context;
              return Theme(
                data: ThemeData.dark(),
                child: Builder(
                  builder: (BuildContext context) {
                    darkContext = context;
                    return const SizedBox.shrink();
                  },
                ),
              );
            },
          ),
        ),
      );

      expect(lightContext.statusColors, SintiaStatusColors.light);
      expect(darkContext.statusColors, SintiaStatusColors.dark);
      expect(darkContext.isDarkMode, isTrue);
    });
  });

  group('SintiaResponsiveContextExtension', () {
    Future<BuildContext> pumpWithWidth(
      WidgetTester tester,
      double width,
    ) async {
      late BuildContext capturedContext;
      setViewSize(tester, Size(width, 800));
      await tester.pumpWidget(
        wrapSintia(
          Builder(
            builder: (BuildContext context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );
      return capturedContext;
    }

    testWidgets('clasifica móvil, tablet y escritorio', (
      WidgetTester tester,
    ) async {
      BuildContext context = await pumpWithWidth(tester, 400);
      expect(context.isMobile, isTrue);
      expect(context.isTablet, isFalse);
      expect(context.isDesktop, isFalse);
      expect(context.screenWidth, 400);

      context = await pumpWithWidth(tester, 800);
      expect(context.isTablet, isTrue);

      context = await pumpWithWidth(tester, 1400);
      expect(context.isDesktop, isTrue);
      expect(context.screenHeight, 800);
    });

    testWidgets('responsiveValue resuelve por breakpoint', (
      WidgetTester tester,
    ) async {
      BuildContext context = await pumpWithWidth(tester, 400);
      expect(
        context.responsiveValue<int>(desktop: 4, tablet: 2, mobile: 1),
        1,
      );

      context = await pumpWithWidth(tester, 800);
      expect(
        context.responsiveValue<int>(desktop: 4, tablet: 2, mobile: 1),
        2,
      );

      context = await pumpWithWidth(tester, 1400);
      expect(
        context.responsiveValue<int>(desktop: 4, tablet: 2, mobile: 1),
        4,
      );
      expect(context.responsiveValue<int>(desktop: 4), 4);
    });

    testWidgets('cae en desktop si no se define el breakpoint actual', (
      WidgetTester tester,
    ) async {
      final BuildContext context = await pumpWithWidth(tester, 400);
      expect(context.responsiveValue<int>(desktop: 4, tablet: 2), 4);
    });
  });

  group('SintiaTextStyleExtension', () {
    testWidgets('aplica colores del tema y pesos', (
      WidgetTester tester,
    ) async {
      late BuildContext capturedContext;
      await tester.pumpWidget(
        wrapSintia(
          Builder(
            builder: (BuildContext context) {
              capturedContext = context;
              return const SizedBox.shrink();
            },
          ),
        ),
      );

      const TextStyle base = TextStyle();
      expect(
        base.primary(capturedContext).color,
        capturedContext.colorScheme.primary,
      );
      expect(
        base.secondary(capturedContext).color,
        capturedContext.colorScheme.secondary,
      );
      expect(
        base.error(capturedContext).color,
        capturedContext.colorScheme.error,
      );
      expect(
        base.muted(capturedContext).color,
        capturedContext.colorScheme.onSurfaceVariant,
      );
      expect(base.withColor(Colors.pink).color, Colors.pink);
      expect(base.regular.fontWeight, FontWeight.w400);
      expect(base.medium.fontWeight, FontWeight.w500);
      expect(base.semiBold.fontWeight, FontWeight.w600);
      expect(base.bold.fontWeight, FontWeight.w700);
    });
  });
}
