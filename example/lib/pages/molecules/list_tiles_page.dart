import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Variantes de [SintiaListTile].
class ListTilesPage extends StatelessWidget {
  const ListTilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Con avatar',
          stacked: true,
          children: <Widget>[
            SintiaCard(
              padding: EdgeInsets.zero,
              showBorder: true,
              child: Column(
                children: <Widget>[
                  SintiaListTile(
                    title: 'Victor García',
                    subtitle: 'victor@sintia.tech',
                    avatarName: 'Victor García',
                    tag: 'Admin',
                    onTap: () {},
                  ),
                  SintiaListTile(
                    title: 'Laura Pérez',
                    subtitle: 'laura@sintia.tech',
                    avatarName: 'Laura Pérez',
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Con ícono y trailing libre',
          stacked: true,
          children: <Widget>[
            SintiaCard(
              padding: EdgeInsets.zero,
              showBorder: true,
              child: Column(
                children: <Widget>[
                  SintiaListTile(
                    title: 'Notificaciones',
                    leadingIcon: Icons.notifications_outlined,
                    trailing: Switch(value: true, onChanged: (_) {}),
                  ),
                  SintiaListTile(
                    title: 'Configuración',
                    subtitle: 'Preferencias de la cuenta',
                    leadingIcon: Icons.settings_outlined,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
