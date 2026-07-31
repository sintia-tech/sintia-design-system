import 'package:flutter/material.dart';

import '../atoms/sintia_avatar.dart';
import '../atoms/sintia_chip.dart';
import '../atoms/sintia_text.dart';
import '../foundations/sintia_size.dart';
import '../molecules/sintia_card.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_text_style_extension.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_spacing.dart';

/// Encabezado de perfil del sistema de diseño.
///
/// Organismo que une átomos ([SintiaAvatar], [SintiaChip]) y moléculas
/// ([SintiaCard]) en la cabecera de una entidad: avatar, nombre, subtítulo,
/// etiquetas y acciones opcionales.
///
/// ```dart
/// SintiaProfileHeader(
///   name: 'Victor García',
///   subtitle: 'Desarrollador móvil',
///   tags: <String>['Flutter', 'Dart'],
///   actions: <Widget>[SintiaButton(label: 'Editar', onPressed: _edit)],
/// );
/// ```
class SintiaProfileHeader extends StatelessWidget {
  const SintiaProfileHeader({
    required this.name,
    super.key,
    this.subtitle,
    this.image,
    this.tags = const <String>[],
    this.actions = const <Widget>[],
  });

  final String name;
  final String? subtitle;

  /// Imagen del avatar; si es null se usan las iniciales de [name].
  final ImageProvider? image;

  /// Etiquetas renderizadas como [SintiaChip].
  final List<String> tags;

  /// Acciones bajo el encabezado, típicamente `SintiaButton`.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final String? subtitle = this.subtitle;
    return SintiaCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SintiaSpacing.medium,
        children: <Widget>[
          Row(
            spacing: SintiaSpacing.medium,
            children: <Widget>[
              SintiaAvatar(name: name, image: image, size: SintiaSize.large),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: SintiaSpacing.extraSmall,
                  children: <Widget>[
                    SintiaText(name, style: context.textTheme.titleLarge),
                    if (subtitle != null)
                      SintiaText(
                        subtitle,
                        style: context.textTheme.bodyMedium?.muted(context),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (tags.isNotEmpty)
            Wrap(
              spacing: SintiaSpacing.small,
              runSpacing: SintiaSpacing.small,
              children: <Widget>[
                for (final String tag in tags) SintiaChip(label: tag),
              ],
            ),
          if (actions.isNotEmpty)
            Wrap(
              spacing: SintiaSpacing.small,
              runSpacing: SintiaSpacing.small,
              children: actions,
            ),
        ],
      ),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Perfil', group: 'SintiaProfileHeader')
Widget sintiaProfileHeaderPreview() => const SintiaProfileHeader(
  name: 'Victor García',
  subtitle: 'Desarrollador móvil',
  tags: <String>['Flutter', 'Dart'],
);
// coverage:ignore-end
