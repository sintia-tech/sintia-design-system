import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

void main() {
  group('Escala de tokens', () {
    test('el espaciado crece de forma monótona sobre la grilla de 4px', () {
      const List<double> scale = <double>[
        SintiaSpacing.extraExtraSmall,
        SintiaSpacing.extraSmall,
        SintiaSpacing.small,
        SintiaSpacing.medium,
        SintiaSpacing.large,
        SintiaSpacing.extraLarge,
        SintiaSpacing.extraExtraLarge,
      ];
      for (int i = 1; i < scale.length; i++) {
        expect(scale[i], greaterThan(scale[i - 1]));
      }
      expect(SintiaSpacing.medium, SintiaSizes.size16);
    });

    test('los radios exponen el mismo valor como double y BorderRadius', () {
      expect(
        SintiaRadius.borderMedium.topLeft.x,
        SintiaRadius.medium,
      );
      expect(SintiaRadius.borderFull.topLeft.x, SintiaRadius.full);
    });

    test('los breakpoints están ordenados', () {
      expect(SintiaBreakpoints.mobile, lessThan(SintiaBreakpoints.tablet));
      expect(SintiaBreakpoints.tablet, lessThan(SintiaBreakpoints.desktop));
    });

    test('las elevaciones están ordenadas', () {
      expect(SintiaElevation.none, lessThan(SintiaElevation.low));
      expect(SintiaElevation.low, lessThan(SintiaElevation.medium));
      expect(SintiaElevation.medium, lessThan(SintiaElevation.high));
      expect(SintiaElevation.high, lessThan(SintiaElevation.highest));
    });

    test('las sombras crecen en difuminado', () {
      expect(
        SintiaShadows.low.first.blurRadius,
        lessThan(SintiaShadows.medium.first.blurRadius),
      );
      expect(
        SintiaShadows.medium.first.blurRadius,
        lessThan(SintiaShadows.high.first.blurRadius),
      );
    });

    test('las duraciones están ordenadas', () {
      expect(SintiaDuration.fast, lessThan(SintiaDuration.normal));
      expect(SintiaDuration.normal, lessThan(SintiaDuration.slow));
    });
  });

  group('SintiaNavDrawerMetrics', () {
    test('el drawer colapsado es más angosto que el expandido', () {
      expect(
        SintiaNavDrawerMetrics.collapsedWidth,
        lessThan(SintiaNavDrawerMetrics.expandedWidth),
      );
    });

    test('el ícono queda centrado en el ítem colapsado', () {
      const double left = SintiaNavDrawerMetrics.iconLeadingSpace;
      const double right =
          SintiaNavDrawerMetrics.itemCollapsedWidth -
          left -
          SintiaIconSize.medium;
      expect(left, right);
    });

    test('el contenido del ítem se maqueta con el ancho expandido', () {
      expect(
        SintiaNavDrawerMetrics.itemContentWidth,
        SintiaNavDrawerMetrics.expandedWidth -
            SintiaNavDrawerMetrics.itemMargin * 2,
      );
    });
  });

  group('SintiaNavItem', () {
    test('usa selectedIcon solo cuando está seleccionado', () {
      const SintiaNavItem item = SintiaNavItem(
        label: 'Pedidos',
        icon: SintiaTestIcons.outlined,
        selectedIcon: SintiaTestIcons.filled,
        route: '/orders',
      );
      expect(item.iconFor(selected: true), SintiaTestIcons.filled);
      expect(item.iconFor(selected: false), SintiaTestIcons.outlined);
    });

    test('cae en icon cuando no hay selectedIcon', () {
      const SintiaNavItem item = SintiaNavItem(
        label: 'Clientes',
        icon: SintiaTestIcons.outlined,
        route: '/customers',
      );
      expect(item.iconFor(selected: true), SintiaTestIcons.outlined);
    });
  });
}

/// Íconos de prueba, para no depender de `Icons` en aserciones de igualdad.
abstract final class SintiaTestIcons {
  static const IconData outlined = IconData(
    0xe000,
    fontFamily: 'MaterialIcons',
  );
  static const IconData filled = IconData(0xe001, fontFamily: 'MaterialIcons');
}
