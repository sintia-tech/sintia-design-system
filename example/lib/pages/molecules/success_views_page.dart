import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// [SintiaSuccessView] al final de un flujo.
class SuccessViewsPage extends StatelessWidget {
  const SuccessViewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Por defecto',
          description: 'El check usa statusColors.success: sin assets.',
          stacked: true,
          children: <Widget>[
            SintiaCard(
              showBorder: true,
              child: SintiaSuccessView(
                title: '¡Contraseña actualizada!',
                message: 'Ya puedes iniciar sesión con tu nueva contraseña.',
                actionLabel: 'Continuar',
                onAction: () {},
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Con ícono propio',
          stacked: true,
          children: <Widget>[
            SintiaCard(
              showBorder: true,
              child: SintiaSuccessView(
                icon: Icon(
                  Icons.local_shipping_outlined,
                  size: SintiaIconSize.extraLarge,
                  color: context.colorScheme.primary,
                ),
                title: 'Pedido en camino',
                message: 'Llega mañana entre 8:00 a. m. y 12:00 m.',
                actionLabel: 'Ver detalle',
                onAction: () {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
