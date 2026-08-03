import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Selección única entre varias opciones con [SintiaSegmentedControl].
class SegmentedControlsPage extends StatefulWidget {
  const SegmentedControlsPage({super.key});

  @override
  State<SegmentedControlsPage> createState() => _SegmentedControlsPageState();
}

class _SegmentedControlsPageState extends State<SegmentedControlsPage> {
  String _locale = 'es';
  SintiaSize _size = SintiaSize.medium;
  bool _grid = false;
  String _period = 'week';

  static const List<SintiaSegment<String>> _locales = <SintiaSegment<String>>[
    SintiaSegment<String>(value: 'es', label: 'ES'),
    SintiaSegment<String>(value: 'en', label: 'EN'),
    SintiaSegment<String>(value: 'fr', label: 'FR'),
  ];

  static const List<SintiaSegment<SintiaSize>> _sizes =
      <SintiaSegment<SintiaSize>>[
        SintiaSegment<SintiaSize>(value: SintiaSize.small, label: 'Small'),
        SintiaSegment<SintiaSize>(value: SintiaSize.medium, label: 'Medium'),
        SintiaSegment<SintiaSize>(value: SintiaSize.large, label: 'Large'),
      ];

  static const List<SintiaSegment<bool>> _views = <SintiaSegment<bool>>[
    SintiaSegment<bool>(
      value: false,
      icon: Icons.view_list_outlined,
      tooltip: 'Lista',
    ),
    SintiaSegment<bool>(
      value: true,
      icon: Icons.grid_view_outlined,
      tooltip: 'Cuadrícula',
    ),
  ];

  static const List<SintiaSegment<String>> _periods = <SintiaSegment<String>>[
    SintiaSegment<String>(value: 'day', label: 'Día'),
    SintiaSegment<String>(value: 'week', label: 'Semana'),
    SintiaSegment<String>(value: 'month', label: 'Mes'),
  ];

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Selector de idioma',
          description: 'Una sola opción activa, rellena con el color de marca.',
          children: <Widget>[
            SintiaSegmentedControl<String>(
              value: _locale,
              segments: _locales,
              size: SintiaSize.small,
              onChanged: (String value) => setState(() => _locale = value),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Tamaños',
          description: 'El tamaño elegido se aplica al propio selector.',
          children: <Widget>[
            SintiaSegmentedControl<SintiaSize>(
              value: _size,
              segments: _sizes,
              size: _size,
              onChanged: (SintiaSize value) => setState(() => _size = value),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Solo íconos',
          description: 'Sin label, el tooltip explica cada opción.',
          children: <Widget>[
            SintiaSegmentedControl<bool>(
              value: _grid,
              segments: _views,
              onChanged: (bool value) => setState(() => _grid = value),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Ancho completo',
          description: 'expanded reparte el ancho en segmentos iguales.',
          stacked: true,
          children: <Widget>[
            SintiaSegmentedControl<String>(
              value: _period,
              segments: _periods,
              expanded: true,
              onChanged: (String value) => setState(() => _period = value),
            ),
          ],
        ),
      ],
    );
  }
}
