import 'package:flutter/widgets.dart';

import '../foundations/sintia_sizes.dart';

/// Escala de sombras del sistema de diseño, para usar en `BoxDecoration`.
///
/// Son sombras neutras (negro con baja opacidad) que funcionan sobre
/// cualquier superficie del tema. Para elevación Material nativa
/// (`Card`, `AppBar`, `Dialog`) usar `SintiaElevation`.
abstract final class SintiaShadows {
  /// Sombra sutil: tarjetas en reposo.
  static const List<BoxShadow> low = <BoxShadow>[
    BoxShadow(
      color: Color(0x0A000000),
      blurRadius: SintiaSizes.size12,
      offset: Offset(0, SintiaSizes.size2),
    ),
  ];

  /// Sombra media: elementos flotantes y superficies destacadas.
  static const List<BoxShadow> medium = <BoxShadow>[
    BoxShadow(
      color: Color(0x14000000),
      blurRadius: SintiaSizes.size16,
      offset: Offset(0, SintiaSizes.size4),
    ),
  ];

  /// Sombra fuerte: diálogos y hojas modales.
  static const List<BoxShadow> high = <BoxShadow>[
    BoxShadow(
      color: Color(0x26000000),
      blurRadius: SintiaSizes.size24,
      offset: Offset(0, SintiaSizes.size8),
    ),
  ];
}
