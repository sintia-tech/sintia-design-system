import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Estados y variantes de [SintiaDropdown].
class DropdownsPage extends StatefulWidget {
  const DropdownsPage({super.key});

  @override
  State<DropdownsPage> createState() => _DropdownsPageState();
}

class _DropdownsPageState extends State<DropdownsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _country;
  String _category = 'home';

  static const List<SintiaDropdownItem<String>> _countries =
      <SintiaDropdownItem<String>>[
        SintiaDropdownItem<String>(value: 'co', label: 'Colombia'),
        SintiaDropdownItem<String>(value: 'mx', label: 'México'),
        SintiaDropdownItem<String>(value: 'ar', label: 'Argentina'),
      ];

  static const List<SintiaDropdownItem<String>> _categories =
      <SintiaDropdownItem<String>>[
        SintiaDropdownItem<String>(
          value: 'home',
          label: 'Hogar',
          icon: Icons.home_outlined,
        ),
        SintiaDropdownItem<String>(
          value: 'work',
          label: 'Trabajo',
          icon: Icons.work_outline,
        ),
        SintiaDropdownItem<String>(
          value: 'other',
          label: 'Otro',
          icon: Icons.category_outlined,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Básico',
          description: 'Misma decoración que SintiaTextField.',
          stacked: true,
          children: <Widget>[
            SintiaDropdown<String>(
              label: 'País',
              hint: 'Elige un país',
              value: _country,
              items: _countries,
              onChanged: (String? value) => setState(() => _country = value),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Con ícono',
          stacked: true,
          children: <Widget>[
            SintiaDropdown<String>(
              label: 'Categoría',
              value: _category,
              items: _categories,
              onChanged: (String? value) =>
                  setState(() => _category = value ?? _category),
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Con ayuda, error y deshabilitado',
          stacked: true,
          children: <Widget>[
            SintiaDropdown<String>(
              label: 'Ciudad',
              hint: 'Elige una ciudad',
              helperText: 'Según el país elegido arriba.',
              items: <SintiaDropdownItem<String>>[],
            ),
            SintiaDropdown<String>(
              label: 'Documento',
              hint: 'Tipo de documento',
              errorText: 'Elige un tipo de documento',
              items: <SintiaDropdownItem<String>>[],
            ),
            SintiaDropdown<String>(
              label: 'No disponible',
              hint: 'Deshabilitado',
              enabled: false,
              items: <SintiaDropdownItem<String>>[],
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Con validación',
          description: 'Toca "Validar" para ver el validator en acción.',
          stacked: true,
          children: <Widget>[
            Form(
              key: _formKey,
              child: SintiaDropdown<String>(
                label: 'País',
                hint: 'Elige un país',
                items: _countries,
                onChanged: (_) {},
                validator: (String? value) =>
                    value == null ? 'Elige un país' : null,
              ),
            ),
            SintiaButton(
              label: 'Validar',
              variant: SintiaButtonVariant.outline,
              onPressed: () => _formKey.currentState?.validate(),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Color y radio personalizados',
          description:
              'itemTextStyle, menuBackgroundColor y borderRadius pintan '
              'el menú desplegado por fuera del tema.',
          stacked: true,
          children: <Widget>[
            SintiaDropdown<String>(
              label: 'Idioma',
              value: 'es',
              items: const <SintiaDropdownItem<String>>[
                SintiaDropdownItem<String>(value: 'es', label: 'Español'),
                SintiaDropdownItem<String>(value: 'en', label: 'English'),
              ],
              itemTextStyle: const TextStyle(fontWeight: FontWeight.bold),
              menuBackgroundColor: Colors.amber,
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              onChanged: (_) {},
            ),
          ],
        ),
      ],
    );
  }
}
