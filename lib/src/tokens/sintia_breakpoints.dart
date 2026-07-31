import '../foundations/sintia_sizes.dart';

/// Breakpoints de ancho (en píxeles lógicos) para layouts responsivos.
///
/// Da misión de "punto de quiebre" a la escala cruda de [SintiaSizes].
/// Los consume `SintiaResponsiveContextExtension` y las plantillas del
/// sistema para decidir su layout.
abstract final class SintiaBreakpoints {
  /// Límite superior de móvil: por debajo de este ancho es móvil.
  static const double mobile = SintiaSizes.size600;

  /// Límite superior de tablet.
  static const double tablet = SintiaSizes.size900;

  /// Desde este ancho se considera escritorio.
  static const double desktop = SintiaSizes.size1200;
}
