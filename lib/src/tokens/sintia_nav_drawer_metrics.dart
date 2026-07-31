import '../foundations/sintia_sizes.dart';
import 'sintia_icon_size.dart';
import 'sintia_spacing.dart';

/// Métricas del navigation drawer del sistema de diseño.
///
/// Token **de componente**: da misión de "medida del drawer" a la escala
/// cruda de [SintiaSizes]. Vive fuera del widget porque tanto el organismo
/// (`SintiaNavigationDrawer`) como sus moléculas y la plantilla que lo
/// alberga necesitan hablar de las mismas medidas, y porque las apps que
/// animan contenido junto al drawer necesitan conocer su ancho.
abstract final class SintiaNavDrawerMetrics {
  /// Ancho del drawer colapsado (modo rail).
  static const double collapsedWidth = SintiaSizes.size80;

  /// Ancho del drawer expandido.
  static const double expandedWidth = SintiaSizes.size280;

  /// Alto del encabezado de marca.
  static const double headerHeight = SintiaSizes.size80;

  /// Alto de cada ítem de navegación.
  static const double itemHeight = SintiaSizes.size48;

  /// Margen horizontal de cada ítem respecto al borde del drawer.
  static const double itemMargin = SintiaSpacing.small;

  /// Ancho del ítem cuando el drawer está expandido.
  ///
  /// El contenido del ítem siempre se maqueta con este ancho y se recorta
  /// cuando el drawer se colapsa: así el texto no genera overflow durante
  /// la animación de ancho.
  static const double itemContentWidth = expandedWidth - itemMargin * 2;

  /// Ancho visible del ítem cuando el drawer está colapsado.
  static const double itemCollapsedWidth = collapsedWidth - itemMargin * 2;

  /// Espacio antes del ícono, calculado para que quede centrado en el
  /// ítem cuando el drawer está colapsado.
  static const double iconLeadingSpace =
      (itemCollapsedWidth - SintiaIconSize.medium) / 2;

  /// Separación entre el ícono y la etiqueta del ítem.
  static const double iconLabelGap = SintiaSpacing.medium;
}
