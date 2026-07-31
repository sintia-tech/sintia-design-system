import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

/// Página de ejemplo: [SintiaPageTemplate] con organismos y datos reales.
///
/// Las páginas son el último nivel de Atomic Design y viven en la app
/// consumidora, no en el sistema: son una plantilla instanciada con datos.
class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  static const List<SintiaListItem> _members = <SintiaListItem>[
    SintiaListItem(
      title: 'Victor García',
      subtitle: 'victor@sintia.tech',
      avatarName: 'Victor García',
      tag: 'Admin',
    ),
    SintiaListItem(
      title: 'Laura Pérez',
      subtitle: 'laura@sintia.tech',
      avatarName: 'Laura Pérez',
    ),
    SintiaListItem(
      title: 'Juan Camilo Ríos',
      subtitle: 'juan@sintia.tech',
      avatarName: 'Juan Camilo Ríos',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SintiaPageTemplate(
      title: 'Mi equipo',
      leading: SintiaAppBarLeading.back,
      actions: <SintiaAppBarAction>[
        SintiaAppBarAction(
          icon: Icons.search,
          tooltip: 'Buscar',
          onPressed: () {},
        ),
      ],
      sections: <Widget>[
        const SintiaBanner(
          title: 'Plan Team',
          message: 'Puedes invitar hasta 10 integrantes.',
        ),
        SintiaListSection(
          title: 'Integrantes',
          action: SintiaButton(
            label: 'Agregar',
            size: SintiaSize.small,
            variant: SintiaButtonVariant.ghost,
            onPressed: () {},
          ),
          items: _members,
        ),
        const SintiaListSection(
          title: 'Invitaciones',
          items: <SintiaListItem>[],
          emptyState: SintiaEmptyState(
            icon: Icons.mail_outline,
            title: 'Sin invitaciones',
            message: 'Las invitaciones enviadas aparecerán aquí.',
          ),
        ),
      ],
      footer: SintiaButton(
        label: 'Invitar integrante',
        icon: Icons.person_add_outlined,
        expanded: true,
        onPressed: () {},
      ),
    );
  }
}
