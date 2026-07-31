import 'package:flutter/material.dart';

import '../atoms/sintia_text.dart';
import '../previews/sintia_preview.dart';
import '../tokens/sintia_radius.dart';
import '../tokens/sintia_spacing.dart';

/// Título de la app bar, con prefijo y sufijo opcionales.
///
/// Si se pasa [onPressed], toda el área del título se vuelve táctil (patrón
/// típico de un selector de sede, sucursal o contexto activo).
///
/// ```dart
/// SintiaAppBarTitle(
///   text: 'Tienda el Centro',
///   suffix: Icon(Icons.keyboard_arrow_down),
///   onPressed: _openStorePicker,
/// );
/// ```
class SintiaAppBarTitle extends StatelessWidget {
  const SintiaAppBarTitle({
    required this.text,
    super.key,
    this.style,
    this.prefix,
    this.suffix,
    this.onPressed,
  });

  final String text;
  final TextStyle? style;
  final Widget? prefix;
  final Widget? suffix;

  /// Si no es null, el título completo es táctil.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final Widget? prefix = this.prefix;
    final Widget? suffix = this.suffix;

    final Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      spacing: SintiaSpacing.extraSmall,
      children: <Widget>[
        if (prefix != null) prefix,
        Flexible(
          child: SintiaText(
            text,
            style: style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (suffix != null) suffix,
      ],
    );

    if (onPressed == null) return content;

    return InkWell(
      onTap: onPressed,
      borderRadius: SintiaRadius.borderSmall,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SintiaSpacing.extraSmall,
          vertical: SintiaSpacing.extraExtraSmall,
        ),
        child: content,
      ),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Con selector', group: 'SintiaAppBarTitle')
Widget sintiaAppBarTitlePreview() => SintiaAppBarTitle(
  text: 'Tienda el Centro',
  suffix: const Icon(Icons.keyboard_arrow_down),
  onPressed: () {},
);
// coverage:ignore-end
