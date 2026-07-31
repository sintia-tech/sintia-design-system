import 'package:flutter/material.dart';

import '../foundations/sintia_size.dart';
import '../foundations/sintia_sizes.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_spacing.dart';

/// Avatar del sistema de diseño.
///
/// Muestra la imagen si está disponible; si no, las iniciales derivadas de
/// [name] sobre el contenedor de marca del tema.
///
/// ```dart
/// SintiaAvatar(name: 'Victor García', size: SintiaSize.large);
/// SintiaAvatar(name: 'Victor', image: NetworkImage(photoUrl));
/// ```
class SintiaAvatar extends StatelessWidget {
  const SintiaAvatar({
    required this.name,
    super.key,
    this.image,
    this.size = SintiaSize.medium,
  });

  /// Nombre usado para las iniciales (y como semántica del avatar).
  final String name;
  final ImageProvider? image;
  final SintiaSize size;

  /// Proporción de las iniciales respecto al diámetro del avatar.
  static const double _initialsFontScale = 0.36;

  /// Traduce el vocabulario [SintiaSize] al diámetro del avatar, tomando
  /// los valores de la escala cruda [SintiaSizes].
  double get _dimension => switch (size) {
    SintiaSize.small => SintiaSizes.size32,
    SintiaSize.medium => SintiaSizes.size44,
    SintiaSize.large => SintiaSizes.size64,
  };

  /// Iniciales de las dos primeras palabras del nombre.
  String get _initials {
    final List<String> words = name.trim().split(RegExp(r'\s+'));
    return words
        .where((String word) => word.isNotEmpty)
        .take(2)
        .map((String word) => word.characters.first.toUpperCase())
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: _dimension / 2,
      foregroundImage: image,
      backgroundColor: context.colorScheme.primaryContainer,
      child: Text(
        _initials,
        style: context.textTheme.titleMedium?.copyWith(
          color: context.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.w600,
          fontSize: _dimension * _initialsFontScale,
        ),
      ),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Tamaños', group: 'SintiaAvatar')
Widget sintiaAvatarSizesPreview() => const Row(
  mainAxisSize: MainAxisSize.min,
  spacing: SintiaSpacing.medium,
  children: <Widget>[
    SintiaAvatar(name: 'Victor García', size: SintiaSize.small),
    SintiaAvatar(name: 'Victor García'),
    SintiaAvatar(name: 'Victor García', size: SintiaSize.large),
  ],
);
// coverage:ignore-end
