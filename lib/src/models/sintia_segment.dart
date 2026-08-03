import 'package:flutter/widgets.dart';

/// Opción de un [SintiaSegmentedControl].
///
/// Modelo puro: la app declara las opciones como datos (valor, texto e ícono)
/// y el sistema decide cómo se ven en cada estado. El valor es genérico, así
/// que puede ser un `enum`, un `String` de idioma o cualquier identificador.
///
/// ```dart
/// const List<SintiaSegment<String>> idiomas = <SintiaSegment<String>>[
///   SintiaSegment<String>(value: 'es', label: 'ES'),
///   SintiaSegment<String>(value: 'en', label: 'EN'),
/// ];
///
/// const List<SintiaSegment<bool>> vistas = <SintiaSegment<bool>>[
///   SintiaSegment<bool>(
///     value: false,
///     icon: Icons.view_list,
///     tooltip: 'Lista',
///   ),
///   SintiaSegment<bool>(
///     value: true,
///     icon: Icons.grid_view,
///     tooltip: 'Cuadrícula',
///   ),
/// ];
/// ```
@immutable
class SintiaSegment<T> {
  const SintiaSegment({
    required this.value,
    this.label,
    this.icon,
    this.tooltip,
  }) : assert(
         label != null || icon != null,
         'Un segmento necesita al menos label o icon',
       );

  /// Valor que se notifica al seleccionar el segmento.
  final T value;

  /// Texto del segmento. Si es null el segmento es solo ícono.
  final String? label;

  /// Ícono del segmento. Se dibuja antes de [label].
  final IconData? icon;

  /// Tooltip del segmento. Útil cuando solo tiene ícono.
  final String? tooltip;
}
