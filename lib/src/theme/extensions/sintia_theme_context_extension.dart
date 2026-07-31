import 'package:flutter/material.dart';

import '../sintia_status_colors.dart';

/// Acceso directo y limpio al diseño (tema, colores y tipografía) desde el
/// [BuildContext].
///
/// Es la vía que usan todos los componentes del sistema para leer color y
/// tipografía; nunca se hardcodean valores.
///
/// ```dart
/// Text(
///   '¡Operación exitosa!',
///   style: context.textTheme.bodyLarge?.copyWith(
///     color: context.statusColors.success,
///   ),
/// );
/// ```
extension SintiaThemeContextExtension on BuildContext {
  /// Acceso rápido al [ThemeData] activo.
  ThemeData get theme => Theme.of(this);

  /// Acceso directo al [ColorScheme] activo.
  ColorScheme get colorScheme => theme.colorScheme;

  /// Acceso directo al [TextTheme] activo.
  TextTheme get textTheme => theme.textTheme;

  /// Colores de estado del sistema (`success`, `warning`, `info`).
  ///
  /// Si el tema no los registra (por ejemplo, un `ThemeData` ajeno al
  /// sistema), cae en los defaults según el brillo activo.
  SintiaStatusColors get statusColors =>
      theme.extension<SintiaStatusColors>() ??
      (theme.brightness == Brightness.dark
          ? SintiaStatusColors.dark
          : SintiaStatusColors.light);

  /// `true` si el tema activo es oscuro.
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Color de marca ([ColorScheme.primary]).
  Color get primaryColor => colorScheme.primary;

  /// Color de contenido sobre la marca ([ColorScheme.onPrimary]).
  Color get onPrimaryColor => colorScheme.onPrimary;

  /// Color de error ([ColorScheme.error]).
  Color get errorColor => colorScheme.error;

  /// Color de superficie ([ColorScheme.surface]).
  Color get surfaceColor => colorScheme.surface;
}
