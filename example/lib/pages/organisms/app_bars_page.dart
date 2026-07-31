import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Variantes de [SintiaAppBar].
class AppBarsPage extends StatelessWidget {
  const AppBarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Título táctil con acciones',
          description:
              'Patrón de selector de sede o sucursal, con carrito y badge.',
          stacked: true,
          children: <Widget>[
            _AppBarFrame(
              child: SintiaAppBar(
                title: 'Tienda el Centro',
                titleSuffix: const Icon(Icons.keyboard_arrow_down),
                onTitlePressed: () {},
                actions: <SintiaAppBarAction>[
                  SintiaAppBarAction(
                    icon: Icons.shopping_cart_outlined,
                    tooltip: 'Carrito',
                    badgeCount: 3,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Con botón de volver',
          description: 'Centra el título automáticamente.',
          stacked: true,
          children: <Widget>[
            _AppBarFrame(
              child: SintiaAppBar(
                title: 'Detalle del producto',
                leading: SintiaAppBarLeading.back,
                onLeadingPressed: () {},
                actions: <SintiaAppBarAction>[
                  SintiaAppBarAction(
                    icon: Icons.search,
                    tooltip: 'Buscar',
                    onPressed: () {},
                  ),
                  SintiaAppBarAction(
                    icon: Icons.more_vert,
                    tooltip: 'Más opciones',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Sin acciones',
          stacked: true,
          children: <Widget>[
            _AppBarFrame(child: SintiaAppBar(title: 'Configuración')),
          ],
        ),
      ],
    );
  }
}

/// Marco que permite mostrar una app bar fuera de un `Scaffold`.
class _AppBarFrame extends StatelessWidget {
  const _AppBarFrame({required this.child});

  final PreferredSizeWidget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: SintiaRadius.borderMedium,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.outlineVariant),
          borderRadius: SintiaRadius.borderMedium,
        ),
        child: SizedBox(height: child.preferredSize.height, child: child),
      ),
    );
  }
}
