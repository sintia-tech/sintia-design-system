import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Etiquetas, estados y filtros con [SintiaChip].
class ChipsPage extends StatefulWidget {
  const ChipsPage({super.key});

  @override
  State<ChipsPage> createState() => _ChipsPageState();
}

class _ChipsPageState extends State<ChipsPage> {
  final Set<String> _selected = <String>{'Flutter'};

  static const List<String> _filters = <String>[
    'Flutter',
    'Dart',
    'Supabase',
    'Next.js',
  ];

  void _toggle({required String filter, required bool selected}) {
    setState(() {
      if (selected) {
        _selected.add(filter);
      } else {
        _selected.remove(filter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Etiquetas',
          children: <Widget>[
            SintiaChip(label: 'Admin'),
            SintiaChip(label: 'Flutter', icon: Icons.flutter_dash),
          ],
        ),
        const ShowcaseSection(
          title: 'Estados',
          description: 'El color sale de SintiaStatusColors.',
          children: <Widget>[
            SintiaChip(label: 'Activo', status: SintiaStatus.success),
            SintiaChip(label: 'Pendiente', status: SintiaStatus.warning),
            SintiaChip(label: 'Vencido', status: SintiaStatus.error),
            SintiaChip(label: 'Borrador', status: SintiaStatus.info),
          ],
        ),
        ShowcaseSection(
          title: 'Filtros',
          description: 'Con onSelected el chip mantiene estado.',
          children: <Widget>[
            for (final String filter in _filters)
              SintiaChip(
                label: filter,
                selected: _selected.contains(filter),
                onSelected: (bool selected) =>
                    _toggle(filter: filter, selected: selected),
              ),
          ],
        ),
      ],
    );
  }
}
