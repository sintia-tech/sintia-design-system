import 'package:flutter/material.dart';

import '../atoms/sintia_text.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_radius.dart';
import '../tokens/sintia_spacing.dart';

/// Tarjeta del sistema de diseño.
///
/// Hereda forma, color y elevación de `SintiaTheme` y agrega padding
/// consistente y soporte opcional de tap con efecto ripple. Los overrides
/// existen para casos excepcionales; por defecto todo sale del tema.
///
/// ```dart
/// SintiaCard(
///   onTap: () => context.push('/detail'),
///   child: SintiaText('Contenido'),
/// );
/// ```
class SintiaCard extends StatelessWidget {
  const SintiaCard({
    required this.child,
    super.key,
    this.onTap,
    this.padding = const EdgeInsets.all(SintiaSpacing.medium),
    this.backgroundColor,
    this.borderRadius,
    this.showBorder = false,
  });

  final Widget child;

  /// Si no es null, la tarjeta es interactiva (ripple incluido).
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  /// Si es null usa el color de tarjeta del tema.
  final Color? backgroundColor;

  /// Si es null usa el radio de tarjeta del tema.
  final BorderRadius? borderRadius;

  /// Dibuja un borde con el `outlineVariant` del tema.
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = borderRadius ?? SintiaRadius.borderLarge;
    final Widget content = Padding(padding: padding, child: child);

    return Card(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: radius,
        side: showBorder
            ? BorderSide(color: context.colorScheme.outlineVariant)
            : BorderSide.none,
      ),
      child: onTap != null
          ? InkWell(onTap: onTap, borderRadius: radius, child: content)
          : content,
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Simple y con borde', group: 'SintiaCard')
Widget sintiaCardPreview() => const Column(
  mainAxisSize: MainAxisSize.min,
  spacing: SintiaSpacing.medium,
  children: <Widget>[
    SintiaCard(child: SintiaText('Tarjeta simple')),
    SintiaCard(showBorder: true, child: SintiaText('Tarjeta con borde')),
  ],
);
// coverage:ignore-end
