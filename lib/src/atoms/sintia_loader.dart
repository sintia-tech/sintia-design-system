import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../foundations/sintia_size.dart';
import '../foundations/sintia_sizes.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_assets.dart';
import '../tokens/sintia_spacing.dart';

/// Indicador de carga del sistema de diseño.
///
/// Renderiza una animación Lottie empaquetada dentro del propio sistema,
/// por lo que las apps consumidoras no necesitan declarar ningún asset.
///
/// ```dart
/// SintiaLoader(size: SintiaSize.large, label: 'Cargando…');
/// ```
class SintiaLoader extends StatelessWidget {
  const SintiaLoader({
    super.key,
    this.size = SintiaSize.medium,
    this.label,
    this.color,
  });

  final SintiaSize size;

  /// Texto opcional debajo del indicador.
  final String? label;

  /// Color de la animación. Si es null hereda el del `IconTheme`, que es lo
  /// que hace que dentro de un botón tome el color de su texto.
  final Color? color;

  /// Traduce el vocabulario [SintiaSize] al **ancho** del indicador,
  /// tomando los valores de la escala cruda [SintiaSizes].
  double get _width => switch (size) {
    SintiaSize.small => SintiaSizes.size48,
    SintiaSize.medium => SintiaSizes.size80,
    SintiaSize.large => SintiaSizes.size200,
  };

  @override
  Widget build(BuildContext context) {
    // Se dimensiona por ancho y el alto lo define la relación de aspecto de
    // la animación: los puntos están en fila, así que una caja cuadrada los
    // dejaría diminutos entre franjas vacías.
    final Widget indicator = Lottie.asset(
      SintiaAssets.loadingAnimation,
      package: SintiaAssets.package,
      width: _width,
      fit: BoxFit.contain,
      delegates: LottieDelegates(
        values: <ValueDelegate<dynamic>>[
          ValueDelegate.color(
            const <String>['**'],
            value:
                color ??
                IconTheme.of(context).color ??
                context.colorScheme.onSurface,
          ),
        ],
      ),
    );

    final String? label = this.label;
    if (label == null) return indicator;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        indicator,
        const SizedBox(height: SintiaSpacing.small),
        Text(label, style: context.textTheme.bodySmall),
      ],
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Con etiqueta', group: 'SintiaLoader')
Widget sintiaLoaderPreview() =>
    const SintiaLoader(size: SintiaSize.large, label: 'Cargando…');
// coverage:ignore-end
