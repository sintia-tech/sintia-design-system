import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import 'widgets/showcase_list.dart';

/// Pantalla inicial del showcase: qué es el sistema y cómo se organiza.
class WelcomePage extends StatelessWidget {
  const WelcomePage({required this.onExplore, super.key});

  final VoidCallback onExplore;

  static const List<(String, String)> _layers = <(String, String)>[
    (
      'foundations',
      'Escala cruda de valores y vocabulario del sistema, sin misión.',
    ),
    (
      'tokens',
      'Dan misión a los valores: espaciado, radios, íconos, breakpoints.',
    ),
    (
      'theme',
      'Mapea tokens y marca a un ThemeData: única fuente de color y texto.',
    ),
    (
      'componentes',
      'Átomos, moléculas, organismos y plantillas. Sin colores hardcodeados.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        SintiaText(
          'Sistema de diseño Sintia',
          style: context.textTheme.headlineMedium?.bold,
        ),
        SintiaText(
          'Atomic Design sobre un pipeline de capas. Tu app inyecta la '
          'marca; el sistema aporta la consistencia.',
          style: context.textTheme.bodyLarge?.muted(context),
        ),
        SintiaCard(
          showBorder: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: SintiaSpacing.medium,
            children: <Widget>[
              for (final (String name, String description) layer in _layers)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: SintiaSpacing.small,
                  children: <Widget>[
                    SintiaChip(label: layer.$1),
                    Expanded(child: SintiaText(layer.$2)),
                  ],
                ),
            ],
          ),
        ),
        SintiaButton(
          label: 'Explorar componentes',
          icon: Icons.explore_outlined,
          onPressed: onExplore,
        ),
      ],
    );
  }
}
