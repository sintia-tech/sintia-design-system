import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';
import '../examples/profile_page.dart';

/// Estructura de [SintiaDetailPageTemplate].
class DetailTemplatesPage extends StatelessWidget {
  const DetailTemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Qué resuelve',
          description:
              'Igual que la plantilla de página, pero con un encabezado fijo '
              'bajo la app bar que permanece visible mientras las secciones '
              'se desplazan.',
          stacked: true,
          children: <Widget>[
            SintiaCard(
              showBorder: true,
              child: SintiaText(
                'header: SintiaProfileHeader(…)\n'
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
              label: 'Ver detalle a pantalla completa',
              icon: Icons.open_in_full,
              onPressed: () => unawaited(
                Navigator.of(context).push(
                  MaterialPageRoute<void>(builder: (_) => const ProfilePage()),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
