import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../catalog/component_category.dart';
import '../catalog/component_entry.dart';
import 'widgets/showcase_list.dart';
import 'widgets/showcase_page.dart';

/// Listado de los componentes de una categoría.
class CategoryPage extends StatelessWidget {
  const CategoryPage({required this.category, super.key});

  final ComponentCategory category;

  void _open(BuildContext context, ComponentEntry entry) {
    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (BuildContext context) => entry.fullScreen
              ? entry.builder(context)
              : ShowcasePage(title: entry.title, child: entry.builder(context)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        for (final ComponentEntry entry in category.entries)
          SintiaCard(
            showBorder: true,
            onTap: () => _open(context, entry),
            padding: EdgeInsets.zero,
            child: SintiaListTile(
              title: entry.title,
              subtitle: entry.description,
              leadingIcon: category.icon,
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
      ],
    );
  }
}
