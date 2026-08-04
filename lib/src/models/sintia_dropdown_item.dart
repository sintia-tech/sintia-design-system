import 'package:flutter/widgets.dart';

/// Opción de un [SintiaDropdown].
///
/// Modelo puro: la app declara las opciones como datos (valor, texto e
/// ícono) y el sistema decide cómo se ven. El valor es genérico, así que
/// puede ser un `enum`, un `String` o cualquier identificador.
///
/// ```dart
/// const List<SintiaDropdownItem<String>> countries =
///     <SintiaDropdownItem<String>>[
///       SintiaDropdownItem<String>(value: 'co', label: 'Colombia'),
///       SintiaDropdownItem<String>(value: 'mx', label: 'México'),
///     ];
/// ```
@immutable
class SintiaDropdownItem<T> {
  const SintiaDropdownItem({
    required this.value,
    required this.label,
    this.icon,
    this.enabled = true,
  });

  /// Valor que se notifica al elegir la opción.
  final T value;

  /// Texto de la opción.
  final String label;

  /// Ícono antes del texto, en el menú desplegado.
  final IconData? icon;

  /// Si es false, la opción aparece en el menú pero no se puede elegir.
  final bool enabled;
}
