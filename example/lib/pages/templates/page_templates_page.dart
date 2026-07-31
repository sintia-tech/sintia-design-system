import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';
import '../examples/team_page.dart';

/// Estructura de [SintiaPageTemplate].
class PageTemplatesPage extends StatelessWidget {
  const PageTemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Qué resuelve',
          description:
              'App bar, secciones apiladas con ancho máximo responsivo y '
              'barra inferior fija. No conoce el contenido: define la '
              'estructura.',
          stacked: true,
          children: <Widget>[
            SintiaCard(
              showBorder: true,
              child: SintiaText(
                'title + leading + actions\n'
                'sections: <Widget>[…]\n'
                'footer: SintiaButton(expanded: true)',
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Ejemplo real',
          stacked: true,
          children: <Widget>[
            SintiaButton(
              label: 'Ver página a pantalla completa',
              icon: Icons.open_in_full,
              onPressed: () => unawaited(
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const TeamPage()),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
