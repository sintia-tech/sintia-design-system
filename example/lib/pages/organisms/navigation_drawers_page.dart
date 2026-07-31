import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// [SintiaNavigationDrawer] en modo expandido y rail.
class NavigationDrawersPage extends StatefulWidget {
  const NavigationDrawersPage({super.key});

  @override
  State<NavigationDrawersPage> createState() => _NavigationDrawersPageState();
}

class _NavigationDrawersPageState extends State<NavigationDrawersPage> {
  static const List<SintiaNavItem> _items = <SintiaNavItem>[
    SintiaNavItem(
      label: 'Inicio',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      route: '/',
    ),
    SintiaNavItem(
      label: 'Pedidos',
      icon: Icons.receipt_long_outlined,
      selectedIcon: Icons.receipt_long,
      route: '/orders',
      badgeCount: 12,
    ),
    SintiaNavItem(
      label: 'Clientes',
      icon: Icons.people_outline,
      selectedIcon: Icons.people,
      route: '/customers',
    ),
    SintiaNavItem(
      label: 'Inventario',
      icon: Icons.inventory_2_outlined,
      route: '/inventory',
      showBadge: true,
    ),
    SintiaNavItem(
      label: 'Reportes',
      icon: Icons.insert_chart_outlined,
      route: '/reports',
      dividerAbove: true,
    ),
  ];

  static const List<SintiaNavItem> _footerItems = <SintiaNavItem>[
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

  bool _collapsed = false;
  String _route = '/orders';

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Interactivo',
          description:
              'Colapsa a rail de 80px con tooltips. El estado vive en la '
              'app, así puede persistirse.',
          stacked: true,
          children: <Widget>[
            SizedBox(
              height: SintiaSizes.size600,
              child: SintiaCard(
                padding: EdgeInsets.zero,
                showBorder: true,
                child: Row(
                  children: <Widget>[
                    SintiaNavigationDrawer(
                      items: _items,
                      footerItems: _footerItems,
                      currentRoute: _route,
                      collapsed: _collapsed,
                      logo: const _DemoLogo(),
                      mark: const _DemoMark(),
                      onToggleCollapsed: () =>
                          setState(() => _collapsed = !_collapsed),
                      onItemSelected: (SintiaNavItem item) =>
                          setState(() => _route = item.route),
                    ),
                    Expanded(
                      child: Center(
                        child: SintiaText(
                          'Ruta activa: $_route',
                          style: context.textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Responsivo',
          description:
              'En móvil el drawer se abre como modal desde el botón de menú. '
              'Eso lo resuelve SintiaShellTemplate: mira "Shell con drawer" '
              'en Plantillas.',
          stacked: true,
          children: <Widget>[SizedBox.shrink()],
        ),
      ],
    );
  }
}

/// Logo de demostración del drawer.
class _DemoLogo extends StatelessWidget {
  const _DemoLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: SintiaSpacing.small,
      children: <Widget>[
        const _DemoMark(),
        SintiaText('Mi empresa', style: context.textTheme.titleMedium?.bold),
      ],
    );
  }
}

/// Isotipo de demostración del drawer.
class _DemoMark extends StatelessWidget {
  const _DemoMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SintiaSizes.size32,
      height: SintiaSizes.size32,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: SintiaRadius.borderSmall,
      ),
      child: Center(
        child: SintiaText(
          'M',
          style: context.textTheme.labelLarge?.bold.withColor(
            context.colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
