import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Tamaños e iniciales de [SintiaAvatar].
class AvatarsPage extends StatelessWidget {
  const AvatarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Tamaños',
          children: <Widget>[
            SintiaAvatar(name: 'Victor García', size: SintiaSize.small),
            SintiaAvatar(name: 'Victor García'),
            SintiaAvatar(name: 'Victor García', size: SintiaSize.large),
          ],
        ),
        ShowcaseSection(
          title: 'Iniciales',
          description: 'Toma la inicial de las dos primeras palabras.',
          children: <Widget>[
            SintiaAvatar(name: 'Laura Pérez'),
            SintiaAvatar(name: 'Sintia'),
            SintiaAvatar(name: 'Juan Camilo Ríos Ortiz'),
          ],
        ),
      ],
    );
  }
}
