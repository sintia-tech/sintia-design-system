import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Tamaños y usos de [SintiaLoader].
class LoadersPage extends StatelessWidget {
  const LoadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Tamaños',
          description:
              'La animación viene empaquetada en el sistema: la app no '
              'declara ningún asset.',
          children: <Widget>[
            SintiaLoader(size: SintiaSize.small),
            SintiaLoader(),
            SintiaLoader(size: SintiaSize.large),
          ],
        ),
        const ShowcaseSection(
          title: 'Con etiqueta',
          children: <Widget>[
            SintiaLoader(size: SintiaSize.large, label: 'Cargando pedidos…'),
          ],
        ),
        ShowcaseSection(
          title: 'Color explícito',
          children: <Widget>[
            SintiaLoader(color: context.colorScheme.primary),
            SintiaLoader(color: context.statusColors.success),
          ],
        ),
      ],
    );
  }
}
