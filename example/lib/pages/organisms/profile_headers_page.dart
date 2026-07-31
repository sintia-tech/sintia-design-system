import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// [SintiaProfileHeader] con etiquetas y acciones.
class ProfileHeadersPage extends StatelessWidget {
  const ProfileHeadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Completo',
          stacked: true,
          children: <Widget>[
            SintiaProfileHeader(
              name: 'Victor García',
              subtitle: 'Desarrollador móvil · Sintia',
              tags: const <String>['Flutter', 'Dart', 'Supabase'],
              actions: <Widget>[
                SintiaButton(
                  label: 'Editar perfil',
                  size: SintiaSize.small,
                  onPressed: () {},
                ),
                SintiaButton(
                  label: 'Compartir',
                  size: SintiaSize.small,
                  variant: SintiaButtonVariant.outline,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Mínimo',
          stacked: true,
          children: <Widget>[SintiaProfileHeader(name: 'Laura Pérez')],
        ),
      ],
    );
  }
}
