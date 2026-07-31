import 'package:flutter/material.dart';

import '../../tokens/sintia_breakpoints.dart';

/// Utilidades de diseño responsivo sobre el [BuildContext].
///
/// Facilita el acceso a las dimensiones de pantalla y permite adaptar
/// valores o layouts según el tamaño (móvil, tablet o escritorio), usando
/// los [SintiaBreakpoints] del sistema.
///
/// ```dart
/// if (context.isMobile) return const _MobileView();
///
/// final int columns = context.responsiveValue<int>(
///   mobile: 1,
///   tablet: 2,
///   desktop: 4,
/// );
/// ```
extension SintiaResponsiveContextExtension on BuildContext {
  /// Ancho actual de la pantalla (o del `MediaQuery` más cercano).
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Alto actual de la pantalla (o del `MediaQuery` más cercano).
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// `true` si el ancho corresponde a un móvil.
  bool get isMobile => screenWidth < SintiaBreakpoints.mobile;

  /// `true` si el ancho corresponde a una tablet.
  bool get isTablet =>
      screenWidth >= SintiaBreakpoints.mobile &&
      screenWidth < SintiaBreakpoints.desktop;

  /// `true` si el ancho corresponde a un escritorio.
  bool get isDesktop => screenWidth >= SintiaBreakpoints.desktop;

  /// Resuelve el valor correspondiente al breakpoint actual.
  ///
  /// [desktop] es el valor base y obligatorio; [tablet] y [mobile] son
  /// opcionales y caen en [desktop] si no se especifican.
  T responsiveValue<T>({required T desktop, T? tablet, T? mobile}) {
    if (isMobile && mobile != null) return mobile;
    if (isTablet && tablet != null) return tablet;
    return desktop;
  }
}
