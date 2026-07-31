import 'package:flutter/material.dart';

import '../atoms/sintia_text.dart';
import '../models/sintia_list_item.dart';
import '../molecules/sintia_card.dart';
import '../molecules/sintia_empty_state.dart';
import '../molecules/sintia_list_tile.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_spacing.dart';

/// Sección de lista del sistema de diseño.
///
/// Organismo que une moléculas ([SintiaCard], [SintiaListTile],
/// [SintiaEmptyState]) en una sección completa de interfaz: encabezado con
/// título y acción opcional, más el listado de elementos. Cuando [items]
/// está vacío muestra [emptyState].
///
/// ```dart
/// SintiaListSection(
///   title: 'Integrantes',
///   action: SintiaButton(
///     label: 'Agregar',
///     variant: SintiaButtonVariant.ghost,
///     onPressed: _add,
///   ),
///   items: <SintiaListItem>[
///     SintiaListItem(
///       title: 'Victor García',
///       subtitle: 'victor@sintia.tech',
///       avatarName: 'Victor García',
///       tag: 'Admin',
///     ),
///   ],
/// );
/// ```
class SintiaListSection extends StatelessWidget {
  const SintiaListSection({
    required this.title,
    required this.items,
    super.key,
    this.action,
    this.emptyState = const SintiaEmptyState(title: 'Sin elementos'),
  });

  final String title;
  final List<SintiaListItem> items;

  /// Acción opcional del encabezado, típicamente un botón ghost.
  final Widget? action;

  /// Contenido mostrado cuando [items] está vacío.
  final Widget emptyState;

  @override
  Widget build(BuildContext context) {
    final Widget? action = this.action;
    return SintiaCard(
      padding: const EdgeInsets.symmetric(vertical: SintiaSpacing.small),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SintiaSpacing.medium,
              vertical: SintiaSpacing.extraSmall,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: SintiaText(
                    title,
                    style: context.textTheme.titleMedium,
                  ),
                ),
                if (action != null) action,
              ],
            ),
          ),
          if (items.isEmpty)
            emptyState
          else
            for (final SintiaListItem item in items)
              SintiaListTile(
                title: item.title,
                subtitle: item.subtitle,
                avatarName: item.avatarName,
                avatarImage: item.avatarImage,
                tag: item.tag,
                onTap: item.onTap,
              ),
        ],
      ),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Con elementos', group: 'SintiaListSection')
Widget sintiaListSectionPreview() => const SintiaListSection(
  title: 'Integrantes',
  items: <SintiaListItem>[
    SintiaListItem(
      title: 'Victor García',
      subtitle: 'victor@sintia.tech',
      avatarName: 'Victor García',
      tag: 'Admin',
    ),
    SintiaListItem(title: 'Laura Pérez', avatarName: 'Laura Pérez'),
  ],
);
// coverage:ignore-end
