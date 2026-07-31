import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

/// Página de ejemplo: [SintiaDetailPageTemplate] con encabezado fijo.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SintiaDetailPageTemplate(
      title: 'Perfil',
      actions: <SintiaAppBarAction>[
        SintiaAppBarAction(
          icon: Icons.more_vert,
          tooltip: 'Más opciones',
          onPressed: () {},
        ),
      ],
      header: SintiaProfileHeader(
        name: 'Victor García',
        subtitle: 'Desarrollador móvil · Sintia',
        tags: const <String>['Flutter', 'Dart', 'Supabase'],
        actions: <Widget>[
          SintiaButton(
            label: 'Editar',
            size: SintiaSize.small,
            onPressed: () {},
          ),
        ],
      ),
      sections: <Widget>[
        SintiaListSection(
          title: 'Actividad reciente',
          items: <SintiaListItem>[
            SintiaListItem(
              title: 'Cerró el pedido #10245',
              subtitle: 'Hace 2 horas',
              onTap: () {},
            ),
            SintiaListItem(
              title: 'Creó el cliente Ferretería El Sol',
              subtitle: 'Ayer',
              onTap: () {},
            ),
          ],
        ),
        const SintiaListSection(
          title: 'Proyectos',
          items: <SintiaListItem>[
            SintiaListItem(title: 'Sintia System Design', tag: 'Activo'),
            SintiaListItem(title: 'App de pedidos B2B', tag: 'Activo'),
          ],
        ),
      ],
      footer: SintiaButton(
        label: 'Contactar',
        icon: Icons.chat_bubble_outline,
        expanded: true,
        onPressed: () {},
      ),
    );
  }
}
