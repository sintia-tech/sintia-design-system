import '../foundations/sintia_sizes.dart';

/// Escala de tamaños de ícono del sistema de diseño.
///
/// Da misión de "tamaño de ícono" a la escala cruda de [SintiaSizes]. Usar
/// estos valores en lugar de números hardcodeados para que los íconos
/// mantengan proporciones consistentes entre componentes.
abstract final class SintiaIconSize {
  /// Íconos dentro de componentes compactos (botones, chips, cierre).
  static const double small = SintiaSizes.size18;

  /// Íconos acompañando contenido (banners, listas, navegación).
  static const double medium = SintiaSizes.size22;

  /// Íconos de acción destacados (app bar, encabezados).
  static const double large = SintiaSizes.size28;

  /// Íconos protagonistas (estados vacíos, ilustraciones).
  static const double extraLarge = SintiaSizes.size56;
}
