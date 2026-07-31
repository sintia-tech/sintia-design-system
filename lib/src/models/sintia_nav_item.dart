import 'package:flutter/widgets.dart';

/// Ítem de navegación del [SintiaNavigationDrawer].
///
/// Modelo puro: la app declara su navegación como datos (label, ícono y
/// ruta) y el sistema decide cómo se ve en cada estado (seleccionado,
/// colapsado, con badge).
///
/// ```dart
/// const List<SintiaNavItem> items = <SintiaNavItem>[
///   SintiaNavItem(
///     label: 'Pedidos',
///     icon: Icons.receipt_long_outlined,
///     selectedIcon: Icons.receipt_long,
///     route: '/orders',
///   ),
///   SintiaNavItem(
///     label: 'Clientes',
///     icon: Icons.people_outline,
///     route: '/customers',
///     badgeCount: 4,
///   ),
/// ];
/// ```
@immutable
class SintiaNavItem {
  const SintiaNavItem({
    required this.label,
    required this.icon,
    required this.route,
    this.selectedIcon,
    this.badgeCount,
    this.showBadge = false,
    this.dividerAbove = false,
  });

  /// Texto del ítem. También se usa como tooltip cuando está colapsado.
  final String label;

  /// Ícono en estado normal.
  final IconData icon;

  /// Ícono cuando el ítem está seleccionado. Si es null usa [icon].
  final IconData? selectedIcon;

  /// Identificador de la ruta. Es lo que se compara con la ruta activa
  /// para decidir el estado seleccionado.
  final String route;

  /// Si es mayor a 0 dibuja un badge con el número sobre el ícono.
  final int? badgeCount;

  /// Dibuja un badge sin número (punto). [badgeCount] tiene precedencia.
  final bool showBadge;

  /// Dibuja un separador arriba del ítem, para agrupar secciones.
  final bool dividerAbove;

  /// Ícono efectivo según el estado de selección.
  IconData iconFor({required bool selected}) =>
      selected ? (selectedIcon ?? icon) : icon;
}
