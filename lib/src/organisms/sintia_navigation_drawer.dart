import 'package:flutter/material.dart';

import '../models/sintia_nav_item.dart';
import '../molecules/sintia_nav_drawer_header.dart';
import '../molecules/sintia_nav_drawer_item.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_duration.dart';
import '../tokens/sintia_nav_drawer_metrics.dart';
import '../tokens/sintia_spacing.dart';

/// Menú lateral de navegación del sistema de diseño.
///
/// Organismo colapsable: alterna entre modo rail (solo íconos, con tooltip)
/// y expandido (íconos + etiquetas), animando el ancho. Es **puro**: no
/// navega ni guarda estado de ruta; recibe la ruta activa y notifica la
/// selección, de modo que funciona igual con GoRouter, Navigator 1.0 o un
/// `IndexedStack`.
///
/// El estado colapsado también se controla desde fuera ([collapsed] +
/// [onToggleCollapsed]) para que la app pueda persistirlo. Para no manejarlo
/// a mano, usar `SintiaShellTemplate`, que ya resuelve el estado y el
/// comportamiento responsivo.
///
/// ```dart
/// SintiaNavigationDrawer(
///   logo: Image.asset('assets/logo.png', height: 32),
///   mark: Image.asset('assets/isotipo.png', height: 32),
///   items: navItems,
///   footerItems: <SintiaNavItem>[settingsItem, logoutItem],
///   currentRoute: currentRoute,
///   collapsed: collapsed,
///   onToggleCollapsed: () => setState(() => collapsed = !collapsed),
///   onItemSelected: (SintiaNavItem item) => context.go(item.route),
/// );
/// ```
class SintiaNavigationDrawer extends StatelessWidget {
  const SintiaNavigationDrawer({
    required this.items,
    required this.currentRoute,
    required this.onItemSelected,
    super.key,
    this.footerItems = const <SintiaNavItem>[],
    this.logo,
    this.mark,
    this.header,
    this.footer,
    this.collapsed = false,
    this.onToggleCollapsed,
    this.collapseLabel = 'Colapsar',
    this.expandLabel = 'Expandir',
    this.showBorder = true,
  });

  /// Ítems principales, en la parte superior.
  final List<SintiaNavItem> items;

  /// Ítems secundarios, anclados abajo (ajustes, cerrar sesión…).
  final List<SintiaNavItem> footerItems;

  /// Ruta activa. Se compara con `SintiaNavItem.route` para marcar el ítem
  /// seleccionado.
  final String currentRoute;

  final ValueChanged<SintiaNavItem> onItemSelected;

  /// Logo completo, visible cuando está expandido.
  final Widget? logo;

  /// Versión compacta del logo, visible cuando está colapsado.
  final Widget? mark;

  /// Reemplaza por completo el encabezado de marca.
  final Widget? header;

  /// Contenido extra al final (por ejemplo, la tarjeta del usuario).
  final Widget? footer;

  final bool collapsed;

  /// Si es null no se muestra el botón de colapsar (drawer fijo).
  final VoidCallback? onToggleCollapsed;

  final String collapseLabel;
  final String expandLabel;

  /// Dibuja el borde derecho que separa el drawer del contenido.
  final bool showBorder;

  /// Ruta reservada del ítem que colapsa o expande el drawer.
  static const String toggleRoute = '_sintia_drawer_toggle';

  Widget? _buildHeader() {
    final Widget? header = this.header;
    if (header != null) return header;
    final Widget? logo = this.logo;
    if (logo == null) return null;
    return SintiaNavDrawerHeader(logo: logo, mark: mark, collapsed: collapsed);
  }

  @override
  Widget build(BuildContext context) {
    final Widget? header = _buildHeader();
    final Widget? footer = this.footer;
    final VoidCallback? onToggleCollapsed = this.onToggleCollapsed;

    return AnimatedContainer(
      duration: SintiaDuration.normal,
      curve: Curves.easeInOut,
      width: collapsed
          ? SintiaNavDrawerMetrics.collapsedWidth
          : SintiaNavDrawerMetrics.expandedWidth,
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: showBorder
            ? Border(
                right: BorderSide(color: context.colorScheme.outlineVariant),
              )
            : null,
      ),
      child: SafeArea(
        right: false,
        child: Column(
          children: <Widget>[
            if (header != null) header,
            const SizedBox(height: SintiaSpacing.small),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  for (final SintiaNavItem item in items) _tile(item),
                ],
              ),
            ),
            for (final SintiaNavItem item in footerItems) _tile(item),
            if (onToggleCollapsed != null)
              SintiaNavDrawerItem(
                item: SintiaNavItem(
                  label: collapsed ? expandLabel : collapseLabel,
                  icon: collapsed ? Icons.menu : Icons.menu_open,
                  route: toggleRoute,
                  dividerAbove: true,
                ),
                selected: false,
                collapsed: collapsed,
                onSelected: (_) => onToggleCollapsed(),
              ),
            if (footer != null) footer,
            const SizedBox(height: SintiaSpacing.small),
          ],
        ),
      ),
    );
  }

  Widget _tile(SintiaNavItem item) {
    return SintiaNavDrawerItem(
      item: item,
      selected: item.route == currentRoute,
      collapsed: collapsed,
      onSelected: onItemSelected,
    );
  }
}

// coverage:ignore-start
const List<SintiaNavItem> _previewItems = <SintiaNavItem>[
  SintiaNavItem(
    label: 'Inicio',
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
    route: '/',
  ),
  SintiaNavItem(
    label: 'Pedidos',
    icon: Icons.receipt_long_outlined,
    route: '/orders',
    badgeCount: 12,
  ),
  SintiaNavItem(
    label: 'Clientes',
    icon: Icons.people_outline,
    route: '/customers',
  ),
  SintiaNavItem(
    label: 'Reportes',
    icon: Icons.insert_chart_outlined,
    route: '/reports',
    dividerAbove: true,
  ),
];

const List<SintiaNavItem> _previewFooterItems = <SintiaNavItem>[
  SintiaNavItem(
    label: 'Configuración',
    icon: Icons.settings_outlined,
    route: '/settings',
  ),
  SintiaNavItem(
    label: 'Cerrar sesión',
    icon: Icons.logout,
    route: '/logout',
  ),
];

@SintiaPreview(name: 'Expandido', group: 'SintiaNavigationDrawer')
Widget sintiaNavigationDrawerExpandedPreview() => Scaffold(
  body: SintiaNavigationDrawer(
    items: _previewItems,
    footerItems: _previewFooterItems,
    currentRoute: '/orders',
    onToggleCollapsed: () {},
    onItemSelected: (_) {},
  ),
);

@SintiaPreview(name: 'Colapsado', group: 'SintiaNavigationDrawer')
Widget sintiaNavigationDrawerCollapsedPreview() => Scaffold(
  body: SintiaNavigationDrawer(
    items: _previewItems,
    footerItems: _previewFooterItems,
    currentRoute: '/orders',
    collapsed: true,
    onToggleCollapsed: () {},
    onItemSelected: (_) {},
  ),
);
// coverage:ignore-end
