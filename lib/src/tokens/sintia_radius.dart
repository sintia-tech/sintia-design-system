import 'package:flutter/widgets.dart';

import '../foundations/sintia_sizes.dart';

/// Escala de radios de borde del sistema de diseño.
///
/// Da misión de "radio de esquina" a la escala cruda de [SintiaSizes].
/// Expone tanto el valor crudo (para `Radius.circular`) como el
/// [BorderRadius] listo para usar.
abstract final class SintiaRadius {
  static const double small = SintiaSizes.size4;
  static const double medium = SintiaSizes.size8;
  static const double large = SintiaSizes.size16;
  static const double extraLarge = SintiaSizes.size24;

  /// Radio "pastilla": cualquier valor mayor al alto del componente.
  static const double full = 999;

  static const BorderRadius borderSmall = BorderRadius.all(
    Radius.circular(small),
  );
  static const BorderRadius borderMedium = BorderRadius.all(
    Radius.circular(medium),
  );
  static const BorderRadius borderLarge = BorderRadius.all(
    Radius.circular(large),
  );
  static const BorderRadius borderExtraLarge = BorderRadius.all(
    Radius.circular(extraLarge),
  );
  static const BorderRadius borderFull = BorderRadius.all(
    Radius.circular(full),
  );
}
