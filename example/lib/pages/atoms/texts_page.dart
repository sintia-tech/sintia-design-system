import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Uso de [SintiaText] y composición de estilos.
class TextsPage extends StatelessWidget {
  const TextsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Por defecto',
          description: 'Sin style hereda bodyMedium del tema.',
          stacked: true,
          children: <Widget>[SintiaText('Texto sin estilo explícito')],
        ),
        ShowcaseSection(
          title: 'Color por rol',
          stacked: true,
          children: <Widget>[
            SintiaText(
              'primary',
              style: context.textTheme.bodyLarge?.primary(context),
            ),
            SintiaText(
              'secondary',
              style: context.textTheme.bodyLarge?.secondary(context),
            ),
            SintiaText(
              'error',
              style: context.textTheme.bodyLarge?.error(context),
            ),
            SintiaText(
              'muted',
              style: context.textTheme.bodyLarge?.muted(context),
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Recorte',
          description: 'maxLines + overflow para textos largos.',
          stacked: true,
          children: <Widget>[
            SintiaText(
              'Un título muy largo que no cabe en una sola línea y por lo '
              'tanto se recorta con puntos suspensivos.',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}
