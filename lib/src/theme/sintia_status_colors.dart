import 'package:flutter/material.dart';

/// Colores de estado que el [ColorScheme] de Material no cubre nativamente
/// (solo trae `error`). Los usan componentes como banners, badges y chips
/// de estado.
///
/// Se registra como [ThemeExtension] en `SintiaTheme`, por lo que el
/// consumidor puede sobreescribir los defaults al construir su tema y
/// leerlos en cualquier parte con `context.statusColors`.
///
/// ```dart
/// SintiaTheme.light(
///   const SintiaThemeConfig(
///     primary: Color(0xFF4F46E5),
///     lightStatusColors: SintiaStatusColors(
///       success: Color(0xFF15803D),
///       warning: Color(0xFFB45309),
///       info: Color(0xFF1D4ED8),
///     ),
///   ),
/// );
/// ```
@immutable
class SintiaStatusColors extends ThemeExtension<SintiaStatusColors> {
  const SintiaStatusColors({
    required this.success,
    required this.warning,
    required this.info,
  });

  /// Confirmaciones y operaciones exitosas.
  final Color success;

  /// Advertencias que requieren atención del usuario.
  final Color warning;

  /// Información neutral.
  final Color info;

  /// Valores por defecto para tema claro.
  static const SintiaStatusColors light = SintiaStatusColors(
    success: Color(0xFF16A34A),
    warning: Color(0xFFD97706),
    info: Color(0xFF2563EB),
  );

  /// Valores por defecto para tema oscuro.
  static const SintiaStatusColors dark = SintiaStatusColors(
    success: Color(0xFF4ADE80),
    warning: Color(0xFFFBBF24),
    info: Color(0xFF60A5FA),
  );

  @override
  SintiaStatusColors copyWith({Color? success, Color? warning, Color? info}) {
    return SintiaStatusColors(
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
    );
  }

  @override
  SintiaStatusColors lerp(ThemeExtension<SintiaStatusColors>? other, double t) {
    if (other is! SintiaStatusColors) return this;
    return SintiaStatusColors(
      success: Color.lerp(success, other.success, t) ?? other.success,
      warning: Color.lerp(warning, other.warning, t) ?? other.warning,
      info: Color.lerp(info, other.info, t) ?? other.info,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SintiaStatusColors &&
        other.success == success &&
        other.warning == warning &&
        other.info == info;
  }

  @override
  int get hashCode => Object.hash(success, warning, info);
}
