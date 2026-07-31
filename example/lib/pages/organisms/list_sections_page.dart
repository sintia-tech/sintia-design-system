import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// [SintiaListSection] con y sin elementos.
class ListSectionsPage extends StatelessWidget {
  const ListSectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Con elementos',
          stacked: true,
          children: <Widget>[
            SintiaListSection(
              title: 'Integrantes',
              action: SintiaButton(
                label: 'Agregar',
                size: SintiaSize.small,
                variant: SintiaButtonVariant.ghost,
                onPressed: () {},
              ),
              items: <SintiaListItem>[
                SintiaListItem(
                  title: 'Victor García',
                  subtitle: 'victor@sintia.tech',
                  avatarName: 'Victor García',
                  tag: 'Admin',
                  onTap: () {},
                ),
                SintiaListItem(
                  title: 'Laura Pérez',
                  subtitle: 'laura@sintia.tech',
                  avatarName: 'Laura Pérez',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Vacía',
          description: 'Muestra el emptyState configurado.',
          stacked: true,
          children: <Widget>[
            SintiaListSection(
              title: 'Invitaciones',
              items: <SintiaListItem>[],
              emptyState: SintiaEmptyState(
                icon: Icons.mail_outline,
                title: 'Sin invitaciones',
                message: 'Las invitaciones enviadas aparecerán aquí.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
