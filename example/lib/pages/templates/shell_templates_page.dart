import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Estructura de [SintiaShellTemplate].
class ShellTemplatesPage extends StatelessWidget {
  const ShellTemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Qué resuelve',
          description:
              'Orquesta el drawer y el contenido: en escritorio el menú es '
              'permanente y colapsable; en móvil se abre como modal desde el '
              'botón de menú y se cierra al elegir una ruta. Este showcase '
              'está construido con esta plantilla.',
          stacked: true,
          children: <Widget>[
            SintiaCard(
              showBorder: true,
              child: SintiaText(
                'items / footerItems: <SintiaNavItem>[…]\n'
                'currentRoute + onRouteSelected\n'
                'logo / mark + body',
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Demo aislada',
          description: 'Reduce el ancho de la ventana para ver el modo móvil.',
          stacked: true,
          children: <Widget>[
            SintiaButton(
              label: 'Abrir demo del shell',
              icon: Icons.open_in_full,
              onPressed: () => unawaited(
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const _ShellDemo()),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// App mínima construida con [SintiaShellTemplate].
class _ShellDemo extends StatefulWidget {
  const _ShellDemo();

  @override
  State<_ShellDemo> createState() => _ShellDemoState();
}

class _ShellDemoState extends State<_ShellDemo> {
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
      route: '/orders',
      badgeCount: 12,
    ),
    SintiaNavItem(
      label: 'Clientes',
      icon: Icons.people_outline,
      route: '/customers',
    ),
  ];

  static const List<SintiaNavItem> _footerItems = <SintiaNavItem>[
    SintiaNavItem(
      label: 'Configuración',
      icon: Icons.settings_outlined,
      route: '/settings',
    ),
  ];

  String _route = '/';

  @override
  Widget build(BuildContext context) {
    return SintiaShellTemplate(
      items: _items,
      footerItems: _footerItems,
      currentRoute: _route,
      onRouteSelected: (String route) => setState(() => _route = route),
      logo: SintiaText(
        'Mi empresa',
        style: context.textTheme.titleMedium?.bold,
      ),
      mark: const Icon(Icons.workspaces_outline),
      actions: <SintiaAppBarAction>[
        SintiaAppBarAction(
          icon: Icons.close,
          tooltip: 'Salir de la demo',
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      body: Center(
        child: SintiaText(
          'Contenido de $_route',
          style: context.textTheme.headlineSmall,
        ),
      ),
    );
  }
}
