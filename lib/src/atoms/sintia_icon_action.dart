import 'package:flutter/material.dart';

import '../previews/sintia_preview.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_spacing.dart';

/// Botón de ícono del sistema de diseño, con badge opcional.
///
/// Átomo compartido por la app bar, los encabezados y cualquier acción
/// compacta. El badge solo se dibuja si [badgeCount] es mayor a 0 o si
/// [showBadge] es true.
///
/// ```dart
/// SintiaIconAction(
///   icon: Icons.notifications_outlined,
///   tooltip: 'Notificaciones',
///   badgeCount: 3,
///   onPressed: _openNotifications,
/// );
/// ```
class SintiaIconAction extends StatelessWidget {
  const SintiaIconAction({
    required this.icon,
    super.key,
    this.onPressed,
    this.tooltip,
    this.badgeCount,
    this.showBadge = false,
    this.color,
    this.size = SintiaIconSize.large,
  });

  final IconData icon;

  /// Si es null el botón se muestra deshabilitado.
  final VoidCallback? onPressed;
  final String? tooltip;

  /// Si es mayor a 0 dibuja un badge con el número.
  final int? badgeCount;

  /// Dibuja un badge sin número (punto). [badgeCount] tiene precedencia.
  final bool showBadge;

  /// Color del ícono. Si es null hereda el del `IconTheme`.
  final Color? color;
  final double size;

  int? get _count {
    final int? badgeCount = this.badgeCount;
    if (badgeCount == null || badgeCount <= 0) return null;
    return badgeCount;
  }

  @override
  Widget build(BuildContext context) {
    final int? count = _count;
    final bool visible = count != null || showBadge;
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      color: color,
      iconSize: size,
      icon: Badge(
        isLabelVisible: visible,
        label: count == null ? null : Text('$count'),
        child: Icon(icon),
      ),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Con y sin badge', group: 'SintiaIconAction')
Widget sintiaIconActionPreview() => Row(
  mainAxisSize: MainAxisSize.min,
  spacing: SintiaSpacing.small,
  children: <Widget>[
    SintiaIconAction(icon: Icons.search, tooltip: 'Buscar', onPressed: () {}),
    SintiaIconAction(
      icon: Icons.shopping_cart_outlined,
      tooltip: 'Carrito',
      badgeCount: 3,
      onPressed: () {},
    ),
    SintiaIconAction(
      icon: Icons.notifications_outlined,
      tooltip: 'Notificaciones',
      showBadge: true,
      onPressed: () {},
    ),
  ],
);
// coverage:ignore-end
