import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// [SintiaEmptyState] como lista vacía y como estado de error.
class EmptyStatesPage extends StatelessWidget {
  const EmptyStatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Sin contenido',
          stacked: true,
          children: <Widget>[
            SintiaCard(
              showBorder: true,
              child: SintiaEmptyState(
                title: 'Sin pedidos',
                message: 'Cuando registres un pedido aparecerá aquí.',
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Como estado de error',
          description: 'Mismo componente con ícono y acción de reintento.',
          stacked: true,
          children: <Widget>[
            SintiaCard(
              showBorder: true,
              child: SintiaEmptyState(
                icon: Icons.cloud_off_outlined,
                title: 'No pudimos cargar los datos',
                message: 'Revisa tu conexión e intenta de nuevo.',
                action: SintiaButton(
                  label: 'Reintentar',
                  icon: Icons.refresh,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
