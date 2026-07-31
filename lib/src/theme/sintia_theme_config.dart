import 'package:flutter/material.dart';

import 'sintia_status_colors.dart';

/// Identidad visual que el consumidor inyecta al sistema de diseño.
///
/// El sistema aporta la consistencia (tokens, radios, espaciados y estilos
/// de componentes); esta configuración aporta la marca. Se define una sola
/// vez y alimenta tanto el tema claro como el oscuro.
///
/// ```dart
/// const SintiaThemeConfig config = SintiaThemeConfig(
///   primary: Color(0xFF4F46E5),
///   secondary: Color(0xFF0D9488),
///   fontFamily: 'OpenSans',
///   headingFontFamily: 'Montserrat',
/// );
///
/// MaterialApp(
///   theme: SintiaTheme.light(config),
///   darkTheme: SintiaTheme.dark(config),
/// );
/// ```
@immutable
class SintiaThemeConfig {
  const SintiaThemeConfig({
    required this.primary,
    this.secondary,
    this.fontFamily,
    this.headingFontFamily,
    this.lightStatusColors = SintiaStatusColors.light,
    this.darkStatusColors = SintiaStatusColors.dark,
  });

  /// Color de marca. Semilla del [ColorScheme] completo.
  final Color primary;

  /// Color de acento opcional. Si es null lo deriva el [ColorScheme].
  final Color? secondary;

  /// Fuente base de la app (body, title, label). Si es null usa la del
  /// sistema operativo.
  ///
  /// El paquete es agnóstico a la fuente: se registra en el `pubspec.yaml`
  /// de la app consumidora, ya sea desde assets locales o `google_fonts`.
  final String? fontFamily;

  /// Fuente de titulares (display, headline y titleLarge). Si es null se
  /// usa [fontFamily] en todos los estilos.
  final String? headingFontFamily;

  /// Colores de estado del tema claro.
  final SintiaStatusColors lightStatusColors;

  /// Colores de estado del tema oscuro.
  final SintiaStatusColors darkStatusColors;

  SintiaThemeConfig copyWith({
    Color? primary,
    Color? secondary,
    String? fontFamily,
    String? headingFontFamily,
    SintiaStatusColors? lightStatusColors,
    SintiaStatusColors? darkStatusColors,
  }) {
    return SintiaThemeConfig(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      fontFamily: fontFamily ?? this.fontFamily,
      headingFontFamily: headingFontFamily ?? this.headingFontFamily,
      lightStatusColors: lightStatusColors ?? this.lightStatusColors,
      darkStatusColors: darkStatusColors ?? this.darkStatusColors,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SintiaThemeConfig &&
        other.primary == primary &&
        other.secondary == secondary &&
        other.fontFamily == fontFamily &&
        other.headingFontFamily == headingFontFamily &&
        other.lightStatusColors == lightStatusColors &&
        other.darkStatusColors == darkStatusColors;
  }

  @override
  int get hashCode => Object.hash(
    primary,
    secondary,
    fontFamily,
    headingFontFamily,
    lightStatusColors,
    darkStatusColors,
  );
}
