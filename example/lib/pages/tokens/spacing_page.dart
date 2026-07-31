import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Escala de espaciado, radios, sombras y elevaciones.
class SpacingPage extends StatelessWidget {
  const SpacingPage({super.key});

  static const List<(String, double)> _spacings = <(String, double)>[
    ('extraExtraSmall', SintiaSpacing.extraExtraSmall),
    ('extraSmall', SintiaSpacing.extraSmall),
    ('small', SintiaSpacing.small),
    ('medium', SintiaSpacing.medium),
    ('large', SintiaSpacing.large),
    ('extraLarge', SintiaSpacing.extraLarge),
    ('extraExtraLarge', SintiaSpacing.extraExtraLarge),
  ];

  static const List<(String, BorderRadius)> _radii = <(String, BorderRadius)>[
    ('small', SintiaRadius.borderSmall),
    ('medium', SintiaRadius.borderMedium),
    ('large', SintiaRadius.borderLarge),
    ('extraLarge', SintiaRadius.borderExtraLarge),
    ('full', SintiaRadius.borderFull),
  ];

  static const List<(String, List<BoxShadow>)> _shadows =
      <(String, List<BoxShadow>)>[
        ('low', SintiaShadows.low),
        ('medium', SintiaShadows.medium),
        ('high', SintiaShadows.high),
      ];

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Espaciado',
          description: 'Grilla de 4px sobre la escala cruda SintiaSizes.',
          stacked: true,
          children: <Widget>[
            for (final (String name, double value) spacing in _spacings)
              Row(
                spacing: SintiaSpacing.medium,
                children: <Widget>[
                  SizedBox(
                    width: SintiaSizes.size120,
                    child: SintiaText(
                      spacing.$1,
                      style: context.textTheme.labelMedium,
                    ),
                  ),
                  Container(
                    width: spacing.$2,
                    height: SintiaSizes.size16,
                    color: context.colorScheme.primary,
                  ),
                  SintiaText(
                    '${spacing.$2.toInt()}',
                    style: context.textTheme.labelSmall?.muted(context),
                  ),
                ],
              ),
          ],
        ),
        ShowcaseSection(
          title: 'Radios',
          children: <Widget>[
            for (final (String name, BorderRadius radius) item in _radii)
              _Box(label: item.$1, borderRadius: item.$2),
          ],
        ),
        ShowcaseSection(
          title: 'Sombras',
          children: <Widget>[
            for (final (String name, List<BoxShadow> shadow) item in _shadows)
              _Box(label: item.$1, shadow: item.$2),
          ],
        ),
      ],
    );
  }
}

/// Caja de muestra para radios y sombras.
class _Box extends StatelessWidget {
  const _Box({required this.label, this.borderRadius, this.shadow});

  final String label;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SintiaSizes.size120,
      height: SintiaSizes.size64,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainerHigh,
        borderRadius: borderRadius ?? SintiaRadius.borderMedium,
        boxShadow: shadow,
      ),
      child: SintiaText(label, style: context.textTheme.labelMedium),
    );
  }
}
