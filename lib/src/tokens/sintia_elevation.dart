import '../foundations/sintia_sizes.dart';

/// Escala de elevación (eje Z) del sistema de diseño.
///
/// Da misión de "elevación Material" a la escala cruda de [SintiaSizes].
/// Para sombras propias en `BoxDecoration` usar `SintiaShadows`.
abstract final class SintiaElevation {
  /// Superficies planas: el default del sistema.
  static const double none = SintiaSizes.size0;

  /// Tarjetas y superficies apenas despegadas del fondo.
  static const double low = SintiaSizes.size2;

  /// Barras y superficies fijas sobre contenido desplazable.
  static const double medium = SintiaSizes.size4;

  /// Menús y popovers.
  static const double high = SintiaSizes.size8;

  /// Diálogos y hojas modales.
  static const double highest = SintiaSizes.size12;
}
