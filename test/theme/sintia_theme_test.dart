import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

void main() {
  const SintiaThemeConfig config = SintiaThemeConfig(primary: Colors.indigo);

  group('SintiaTheme', () {
    test('deriva el ColorScheme de la marca del consumidor', () {
      final ThemeData theme = SintiaTheme.light(config);
      expect(theme.colorScheme.brightness, Brightness.light);
      expect(SintiaTheme.dark(config).colorScheme.brightness, Brightness.dark);
    });

    test('respeta el color secundario cuando se pasa', () {
      final ThemeData theme = SintiaTheme.dark(
        config.copyWith(secondary: Colors.teal),
      );
      expect(theme.colorScheme.secondary, Colors.teal);
    });

    test('registra SintiaStatusColors según el brillo', () {
      expect(
        SintiaTheme.light(config).extension<SintiaStatusColors>(),
        SintiaStatusColors.light,
      );
      expect(
        SintiaTheme.dark(config).extension<SintiaStatusColors>(),
        SintiaStatusColors.dark,
      );
    });

    test('permite sobreescribir los colores de estado', () {
      const SintiaStatusColors custom = SintiaStatusColors(
        success: Color(0xFF15803D),
        warning: Color(0xFFB45309),
        info: Color(0xFF1D4ED8),
      );
      final ThemeData theme = SintiaTheme.light(
        config.copyWith(lightStatusColors: custom),
      );
      expect(theme.extension<SintiaStatusColors>(), custom);
    });

    test('aplica la fuente de titulares solo a los titulares', () {
      final ThemeData theme = SintiaTheme.light(
        config.copyWith(
          fontFamily: 'OpenSans',
          headingFontFamily: 'Montserrat',
        ),
      );
      expect(theme.textTheme.headlineLarge?.fontFamily, 'Montserrat');
      expect(theme.textTheme.titleLarge?.fontFamily, 'Montserrat');
      expect(theme.textTheme.bodyMedium?.fontFamily, 'OpenSans');
      expect(theme.textTheme.labelSmall?.fontFamily, 'OpenSans');
    });

    test('usa la fuente base en todo si no hay fuente de titulares', () {
      final ThemeData theme = SintiaTheme.light(
        config.copyWith(fontFamily: 'OpenSans'),
      );
      expect(theme.textTheme.headlineLarge?.fontFamily, 'OpenSans');
    });

    test('define los estilos de componentes desde los tokens', () {
      final ThemeData theme = SintiaTheme.light(config);
      expect(theme.cardTheme.elevation, SintiaElevation.none);
      expect(theme.appBarTheme.elevation, SintiaElevation.none);
      expect(theme.dialogTheme.elevation, SintiaElevation.highest);
      expect(theme.inputDecorationTheme.filled, isTrue);
    });
  });

  group('SintiaStatusColors', () {
    test('copyWith solo cambia lo indicado', () {
      final SintiaStatusColors colors = SintiaStatusColors.light.copyWith(
        success: Colors.green,
      );
      expect(colors.success, Colors.green);
      expect(colors.warning, SintiaStatusColors.light.warning);
    });

    test('lerp interpola entre claro y oscuro', () {
      final SintiaStatusColors? mixed = SintiaStatusColors.light.lerp(
        SintiaStatusColors.dark,
        1,
      );
      expect(mixed?.success, SintiaStatusColors.dark.success);
    });

    test('lerp con otra extensión devuelve la misma instancia', () {
      expect(
        SintiaStatusColors.light.lerp(null, 0.5),
        SintiaStatusColors.light,
      );
    });
  });

  group('SintiaThemeConfig', () {
    test('iguala por valor', () {
      expect(config, const SintiaThemeConfig(primary: Colors.indigo));
      expect(
        config.hashCode,
        const SintiaThemeConfig(primary: Colors.indigo).hashCode,
      );
    });

    test('copyWith conserva el resto de la configuración', () {
      final SintiaThemeConfig updated = config.copyWith(fontFamily: 'Inter');
      expect(updated.primary, config.primary);
      expect(updated.fontFamily, 'Inter');
    });
  });
}
