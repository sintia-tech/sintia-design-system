import '../foundations/sintia_sizes.dart';

/// Escala de espaciado del sistema de diseño.
///
/// Da misión de "espaciado" a la escala cruda de [SintiaSizes] (grilla de
/// 4px). Usar estos valores en lugar de números hardcodeados para mantener
/// un ritmo visual consistente entre pantallas.
abstract final class SintiaSpacing {
  static const double extraExtraSmall = SintiaSizes.size2;
  static const double extraSmall = SintiaSizes.size4;
  static const double small = SintiaSizes.size8;
  static const double medium = SintiaSizes.size16;
  static const double large = SintiaSizes.size24;
  static const double extraLarge = SintiaSizes.size32;
  static const double extraExtraLarge = SintiaSizes.size48;
}
