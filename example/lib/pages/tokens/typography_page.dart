import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Escala tipográfica del tema y pesos disponibles.
class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme text = context.textTheme;

    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Titulares',
          description: 'Usan headingFontFamily si la app la define.',
          stacked: true,
          children: <Widget>[
            _Style('displaySmall', text.displaySmall),
            _Style('headlineMedium', text.headlineMedium),
            _Style('headlineSmall', text.headlineSmall),
            _Style('titleLarge', text.titleLarge),
          ],
        ),
        ShowcaseSection(
          title: 'Contenido',
          stacked: true,
          children: <Widget>[
            _Style('titleMedium', text.titleMedium),
            _Style('bodyLarge', text.bodyLarge),
            _Style('bodyMedium', text.bodyMedium),
            _Style('bodySmall', text.bodySmall),
            _Style('labelLarge', text.labelLarge),
            _Style('labelSmall', text.labelSmall),
          ],
        ),
        ShowcaseSection(
          title: 'Pesos',
          description: 'Extensiones de TextStyle del sistema.',
          stacked: true,
          children: <Widget>[
            SintiaText('regular', style: text.bodyLarge?.regular),
            SintiaText('medium', style: text.bodyLarge?.medium),
            SintiaText('semiBold', style: text.bodyLarge?.semiBold),
            SintiaText('bold', style: text.bodyLarge?.bold),
          ],
        ),
      ],
    );
  }
}

/// Fila con el nombre del estilo y una muestra aplicada.
class _Style extends StatelessWidget {
  const _Style(this.name, this.style);

  final String name;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SintiaText(
          name,
          style: context.textTheme.labelSmall?.muted(context),
        ),
        SintiaText('Sistema de diseño Sintia', style: style),
      ],
    );
  }
}
