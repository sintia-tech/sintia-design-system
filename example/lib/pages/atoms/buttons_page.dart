import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Variantes, tamaños y estados de [SintiaButton].
class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  Future<void> _simulateLoad() =>
      Future<void>.delayed(const Duration(seconds: 2));

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Variantes',
          description: 'Cinco niveles de énfasis con una sola API.',
          children: <Widget>[
            SintiaButton(label: 'Primary', onPressed: () {}),
            SintiaButton(
              label: 'Secondary',
              variant: SintiaButtonVariant.secondary,
              onPressed: () {},
            ),
            SintiaButton(
              label: 'Outline',
              variant: SintiaButtonVariant.outline,
              onPressed: () {},
            ),
            SintiaButton(
              label: 'Ghost',
              variant: SintiaButtonVariant.ghost,
              onPressed: () {},
            ),
            SintiaButton(
              label: 'Danger',
              variant: SintiaButtonVariant.danger,
              onPressed: () {},
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Tamaños',
          children: <Widget>[
            SintiaButton(
              label: 'Small',
              size: SintiaSize.small,
              onPressed: () {},
            ),
            SintiaButton(label: 'Medium', onPressed: () {}),
            SintiaButton(
              label: 'Large',
              size: SintiaSize.large,
              onPressed: () {},
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Con ícono',
          children: <Widget>[
            SintiaButton(
              label: 'Guardar',
              icon: Icons.check,
              onPressed: () {},
            ),
            SintiaButton(
              label: 'Continuar',
              trailingIcon: Icons.arrow_forward,
              variant: SintiaButtonVariant.outline,
              onPressed: () {},
            ),
            SintiaButton(
              label: 'Eliminar',
              icon: Icons.delete_outline,
              variant: SintiaButtonVariant.danger,
              onPressed: () {},
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Carga automática',
          description:
              'Si onPressed devuelve un Future, el botón se bloquea y '
              'muestra el loader hasta que termina.',
          children: <Widget>[
            SintiaButton(label: 'Guardar', onPressed: _simulateLoad),
            SintiaButton(
              label: 'Sincronizar',
              loadingLabel: 'Sincronizando…',
              variant: SintiaButtonVariant.outline,
              onPressed: _simulateLoad,
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Deshabilitado y expandido',
          stacked: true,
          children: <Widget>[
            const SintiaButton(label: 'Deshabilitado'),
            SintiaButton(
              label: 'Ocupa todo el ancho',
              expanded: true,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
