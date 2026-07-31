import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Botones de ícono con badge: [SintiaIconAction].
class IconActionsPage extends StatelessWidget {
  const IconActionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Sin badge',
          children: <Widget>[
            SintiaIconAction(
              icon: Icons.search,
              tooltip: 'Buscar',
              onPressed: () {},
            ),
            SintiaIconAction(
              icon: Icons.filter_list,
              tooltip: 'Filtrar',
              onPressed: () {},
            ),
            const SintiaIconAction(icon: Icons.share_outlined),
          ],
        ),
        ShowcaseSection(
          title: 'Con badge',
          description: 'badgeCount muestra el número; showBadge solo el punto.',
          children: <Widget>[
            SintiaIconAction(
              icon: Icons.shopping_cart_outlined,
              tooltip: 'Carrito',
              badgeCount: 3,
              onPressed: () {},
            ),
            SintiaIconAction(
              icon: Icons.notifications_outlined,
              tooltip: 'Notificaciones',
              badgeCount: 24,
              onPressed: () {},
            ),
            SintiaIconAction(
              icon: Icons.mail_outline,
              tooltip: 'Mensajes',
              showBadge: true,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
