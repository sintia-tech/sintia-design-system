import 'package:flutter/material.dart';

import '../atoms/sintia_avatar.dart';
import '../atoms/sintia_chip.dart';
import '../previews/sintia_preview.dart';

/// Fila de lista del sistema de diseño.
///
/// Molécula que une átomos ([SintiaAvatar], [SintiaChip]) y texto en una
/// fila consistente: avatar opcional a la izquierda, título con subtítulo y
/// etiqueta o widget opcional a la derecha. Es la pieza que consumen
/// organismos como `SintiaListSection`, pero puede usarse suelta.
///
/// ```dart
/// SintiaListTile(
///   title: 'Victor García',
///   subtitle: 'Desarrollador móvil',
///   avatarName: 'Victor García',
///   tag: 'Admin',
///   onTap: _openProfile,
/// );
/// ```
class SintiaListTile extends StatelessWidget {
  const SintiaListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.avatarName,
    this.avatarImage,
    this.leadingIcon,
    this.tag,
    this.trailing,
    this.onTap,
  });

  final String title;
  final String? subtitle;

  /// Si no es null, la fila muestra un [SintiaAvatar] a la izquierda.
  final String? avatarName;
  final ImageProvider? avatarImage;

  /// Ícono a la izquierda. Se ignora si hay avatar.
  final IconData? leadingIcon;

  /// Etiqueta a la derecha, renderizada como [SintiaChip]. Se ignora si se
  /// pasa [trailing].
  final String? tag;

  /// Widget a la derecha, con precedencia sobre [tag].
  final Widget? trailing;

  final VoidCallback? onTap;

  Widget? _leading() {
    final String? avatarName = this.avatarName;
    if (avatarName != null) {
      return SintiaAvatar(name: avatarName, image: avatarImage);
    }
    final IconData? leadingIcon = this.leadingIcon;
    return leadingIcon != null ? Icon(leadingIcon) : null;
  }

  Widget? _trailing() {
    final Widget? trailing = this.trailing;
    if (trailing != null) return trailing;
    final String? tag = this.tag;
    return tag != null ? SintiaChip(label: tag) : null;
  }

  @override
  Widget build(BuildContext context) {
    final String? subtitle = this.subtitle;
    return ListTile(
      onTap: onTap,
      leading: _leading(),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: _trailing(),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Con avatar y etiqueta', group: 'SintiaListTile')
Widget sintiaListTilePreview() => const Column(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    SintiaListTile(
      title: 'Victor García',
      subtitle: 'Desarrollador móvil',
      avatarName: 'Victor García',
      tag: 'Admin',
    ),
    SintiaListTile(
      title: 'Configuración',
      leadingIcon: Icons.settings_outlined,
      trailing: Icon(Icons.chevron_right),
    ),
  ],
);
// coverage:ignore-end
