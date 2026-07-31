import 'package:flutter/material.dart';

import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_text_style_extension.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';

/// Texto del sistema de diseño.
///
/// Envuelve [Text] garantizando que nunca haya texto sin estilo: si no se
/// pasa [style], hereda `textTheme.bodyMedium` del tema activo. Componer
/// estilos con las extensiones del sistema
/// (`context.textTheme.titleMedium!.semiBold`).
///
/// ```dart
/// SintiaText('Hola', style: context.textTheme.titleLarge?.bold);
/// ```
class SintiaText extends StatelessWidget {
  const SintiaText(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.semanticsLabel,
  });

  final String data;

  /// Si es null usa `textTheme.bodyMedium`.
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  /// Etiqueta alterna para lectores de pantalla.
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style ?? context.textTheme.bodyMedium,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      semanticsLabel: semanticsLabel,
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Escala tipográfica', group: 'SintiaText')
Widget sintiaTextScalePreview() => Builder(
  builder: (BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SintiaText('Display small', style: context.textTheme.displaySmall),
      SintiaText('Headline medium', style: context.textTheme.headlineMedium),
      SintiaText('Title large', style: context.textTheme.titleLarge?.semiBold),
      SintiaText('Body medium', style: context.textTheme.bodyMedium),
      SintiaText('Label small', style: context.textTheme.labelSmall),
    ],
  ),
);
// coverage:ignore-end
