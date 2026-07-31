import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Roles de color del tema y colores de estado del sistema.
class ColorsPage extends StatelessWidget {
  const ColorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = context.colorScheme;
    final SintiaStatusColors status = context.statusColors;

    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Marca',
          description:
              'Todo el esquema se deriva del primary que inyecta la app.',
          children: <Widget>[
            _Swatch('primary', scheme.primary, scheme.onPrimary),
            _Swatch(
              'primaryContainer',
              scheme.primaryContainer,
              scheme.onPrimaryContainer,
            ),
            _Swatch('secondary', scheme.secondary, scheme.onSecondary),
            _Swatch(
              'secondaryContainer',
              scheme.secondaryContainer,
              scheme.onSecondaryContainer,
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Superficies',
          children: <Widget>[
            _Swatch('surface', scheme.surface, scheme.onSurface),
            _Swatch(
              'surfaceContainerLow',
              scheme.surfaceContainerLow,
              scheme.onSurface,
            ),
            _Swatch(
              'surfaceContainer',
              scheme.surfaceContainer,
              scheme.onSurface,
            ),
            _Swatch(
              'surfaceContainerHigh',
              scheme.surfaceContainerHigh,
              scheme.onSurface,
            ),
            _Swatch('outlineVariant', scheme.outlineVariant, scheme.onSurface),
          ],
        ),
        ShowcaseSection(
          title: 'Estados',
          description:
              'error viene del ColorScheme; success, warning e info son '
              'SintiaStatusColors, sobreescribibles por la app.',
          children: <Widget>[
            _Swatch('error', scheme.error, scheme.onError),
            _Swatch('success', status.success, scheme.surface),
            _Swatch('warning', status.warning, scheme.surface),
            _Swatch('info', status.info, scheme.surface),
          ],
        ),
      ],
    );
  }
}

/// Muestra de color con su nombre.
class _Swatch extends StatelessWidget {
  const _Swatch(this.name, this.color, this.onColor);

  final String name;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SintiaSizes.size200,
      height: SintiaSizes.size64,
      padding: const EdgeInsets.all(SintiaSpacing.small),
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: color,
        borderRadius: SintiaRadius.borderMedium,
        border: Border.all(color: context.colorScheme.outlineVariant),
      ),
      child: SintiaText(
        name,
        style: context.textTheme.labelMedium?.withColor(onColor),
      ),
    );
  }
}
