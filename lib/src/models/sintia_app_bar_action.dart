import 'package:flutter/widgets.dart';

/// Acción de la [SintiaAppBar]: un ícono con callback y badge opcional.
///
/// Es un modelo puro (sin widgets) para que las pantallas declaren sus
/// acciones como datos y la app bar decida cómo renderizarlas.
///
/// ```dart
/// SintiaAppBar(
///   title: 'Mis pedidos',
///   actions: <SintiaAppBarAction>[
///     SintiaAppBarAction(
///       icon: Icons.shopping_cart_outlined,
///       tooltip: 'Carrito',
///       badgeCount: 3,
///       onPressed: _openCart,
///     ),
///   ],
/// );
/// ```
@immutable
class SintiaAppBarAction {
  const SintiaAppBarAction({
    required this.icon,
    this.onPressed,
    this.badgeCount,
    this.tooltip,
  });

  /// Ícono de la acción.
  final IconData icon;

  /// Si es null la acción se muestra deshabilitada.
  final VoidCallback? onPressed;

  /// Si es mayor a 0 se dibuja un badge con el número.
  final int? badgeCount;

  /// Texto de ayuda (y etiqueta de accesibilidad).
  final String? tooltip;
}
