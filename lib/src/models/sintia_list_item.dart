import 'package:flutter/widgets.dart';

/// Elemento de una [SintiaListSection], renderizado como `SintiaListTile`.
///
/// Modelo puro para que las pantallas declaren el contenido de una lista
/// como datos.
@immutable
class SintiaListItem {
  const SintiaListItem({
    required this.title,
    this.subtitle,
    this.avatarName,
    this.avatarImage,
    this.tag,
    this.onTap,
  });

  final String title;
  final String? subtitle;

  /// Si no es null, el elemento muestra su avatar a la izquierda.
  final String? avatarName;
  final ImageProvider? avatarImage;

  /// Etiqueta opcional a la derecha, renderizada como chip.
  final String? tag;
  final VoidCallback? onTap;
}
