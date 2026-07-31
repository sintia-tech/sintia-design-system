/// Escala de duraciones de animación del sistema de diseño.
///
/// Mantiene el ritmo de las transiciones consistente: micro-interacciones
/// rápidas, cambios de layout normales y entradas/salidas lentas.
abstract final class SintiaDuration {
  /// Micro-interacciones: hover, ripple, cambios de color.
  static const Duration fast = Duration(milliseconds: 150);

  /// Cambios de layout: colapsar el drawer, expandir una sección.
  static const Duration normal = Duration(milliseconds: 250);

  /// Entradas y salidas de superficies grandes.
  static const Duration slow = Duration(milliseconds: 400);
}
