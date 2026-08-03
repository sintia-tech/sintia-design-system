import 'package:flutter/material.dart';

import '../foundations/sintia_size.dart';
import '../foundations/sintia_sizes.dart';
import '../models/sintia_segment.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_text_style_extension.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_duration.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_radius.dart';
import '../tokens/sintia_spacing.dart';

/// Selector de una sola opción entre varias, tipo *segmented control*.
///
/// Resuelve las decisiones excluyentes de una pantalla: idioma, periodo o
/// modo de vista. El segmento activo se rellena con el color de marca y el
/// resto queda plano, así que funciona sobre cualquier fondo sin caja.
///
/// Es genérico: [SintiaSegment.value] puede ser un `enum`, un `String` de
/// idioma o cualquier identificador. Es puro: no guarda la selección, la
/// recibe en [value] y notifica la nueva por [onChanged].
///
/// Para varias selecciones simultáneas (filtros) el componente es
/// `SintiaChip`; para un booleano suelto, el `Switch` de Material.
///
/// ```dart
/// SintiaSegmentedControl<String>(
///   value: locale,
///   segments: const <SintiaSegment<String>>[
///     SintiaSegment<String>(value: 'es', label: 'ES'),
///     SintiaSegment<String>(value: 'en', label: 'EN'),
///   ],
///   onChanged: (String value) => setState(() => locale = value),
/// );
/// ```
class SintiaSegmentedControl<T> extends StatelessWidget {
  const SintiaSegmentedControl({
    required this.segments,
    required this.value,
    required this.onChanged,
    super.key,
    this.size = SintiaSize.medium,
    this.expanded = false,
    this.semanticIdentifier,
  });

  /// Opciones disponibles, en el orden en que se dibujan.
  final List<SintiaSegment<T>> segments;

  /// Valor seleccionado. Si no coincide con ningún segmento, ninguno se
  /// resalta.
  final T value;

  /// Notifica el valor elegido. No se dispara al tocar el segmento activo.
  final ValueChanged<T> onChanged;

  /// Traduce a la altura y la tipografía del selector.
  final SintiaSize size;

  /// Ocupa todo el ancho disponible repartiéndolo en segmentos iguales.
  final bool expanded;

  /// Identificador semántico para pruebas de automatización.
  final String? semanticIdentifier;

  /// Altura del selector según [size].
  double get _height => switch (size) {
    SintiaSize.small => SintiaSizes.size32,
    SintiaSize.medium => SintiaSizes.size40,
    SintiaSize.large => SintiaSizes.size48,
  };

  /// Espacio horizontal interno de cada segmento según [size].
  double get _horizontalPadding => switch (size) {
    SintiaSize.small => SintiaSpacing.small,
    SintiaSize.medium => SintiaSpacing.medium,
    SintiaSize.large => SintiaSpacing.large,
  };

  /// Tamaño del ícono de cada segmento según [size].
  double get _iconSize => switch (size) {
    SintiaSize.small => SintiaIconSize.small,
    SintiaSize.medium => SintiaIconSize.small,
    SintiaSize.large => SintiaIconSize.medium,
  };

  /// Estilo base del texto de cada segmento según [size].
  TextStyle? _labelStyle(BuildContext context) => switch (size) {
    SintiaSize.small => context.textTheme.labelMedium,
    SintiaSize.medium => context.textTheme.labelLarge,
    SintiaSize.large => context.textTheme.titleSmall,
  };

  @override
  Widget build(BuildContext context) {
    final TextStyle? labelStyle = _labelStyle(context);

    return Semantics(
      identifier: semanticIdentifier ?? 'sintia_segmented_control',
      child: Row(
        mainAxisSize: expanded ? MainAxisSize.max : MainAxisSize.min,
        spacing: SintiaSpacing.extraSmall,
        children: <Widget>[
          for (final SintiaSegment<T> segment in segments)
            if (expanded)
              Expanded(child: _button(segment, labelStyle))
            else
              _button(segment, labelStyle),
        ],
      ),
    );
  }

  /// Construye el botón de [segment] resolviendo su estado y sus medidas.
  Widget _button(SintiaSegment<T> segment, TextStyle? labelStyle) {
    final bool selected = segment.value == value;
    return _SintiaSegmentButton(
      label: segment.label,
      icon: segment.icon,
      tooltip: segment.tooltip,
      selected: selected,
      height: _height,
      horizontalPadding: _horizontalPadding,
      iconSize: _iconSize,
      labelStyle: labelStyle,
      onTap: selected ? null : () => onChanged(segment.value),
    );
  }
}

/// Segmento individual: pastilla rellena cuando está activo, plana cuando no.
class _SintiaSegmentButton extends StatelessWidget {
  const _SintiaSegmentButton({
    required this.selected,
    required this.height,
    required this.horizontalPadding,
    required this.iconSize,
    required this.onTap,
    this.label,
    this.icon,
    this.tooltip,
    this.labelStyle,
  });

  final bool selected;
  final double height;
  final double horizontalPadding;
  final double iconSize;

  /// Null cuando el segmento ya está activo: evita notificar de más.
  final VoidCallback? onTap;
  final String? label;
  final IconData? icon;
  final String? tooltip;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final Color foreground = selected
        ? colorScheme.onPrimary
        : colorScheme.onSurfaceVariant;

    final String? label = this.label;
    final IconData? icon = this.icon;
    final String? tooltip = this.tooltip;

    final Widget button = AnimatedContainer(
      duration: SintiaDuration.fast,
      height: height,
      decoration: BoxDecoration(
        color: selected ? colorScheme.primary : Colors.transparent,
        borderRadius: SintiaRadius.borderFull,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: SintiaRadius.borderFull,
        child: InkWell(
          onTap: onTap,
          borderRadius: SintiaRadius.borderFull,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: SintiaSpacing.extraSmall,
              children: <Widget>[
                if (icon != null) Icon(icon, size: iconSize, color: foreground),
                if (label != null)
                  Text(
                    label,
                    style:
                        (selected ? labelStyle?.semiBold : labelStyle?.medium)
                            ?.withColor(foreground),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    return Semantics(
      button: true,
      selected: selected,
      child: tooltip == null
          ? button
          : Tooltip(message: tooltip, child: button),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Selector de idioma', group: 'SintiaSegmentedControl')
Widget sintiaSegmentedControlPreview() => SintiaSegmentedControl<String>(
  value: 'es',
  segments: const <SintiaSegment<String>>[
    SintiaSegment<String>(value: 'es', label: 'ES'),
    SintiaSegment<String>(value: 'en', label: 'EN'),
  ],
  onChanged: (_) {},
);

@SintiaPreview(name: 'Con íconos', group: 'SintiaSegmentedControl')
Widget sintiaSegmentedControlIconsPreview() => SintiaSegmentedControl<bool>(
  value: false,
  segments: const <SintiaSegment<bool>>[
    SintiaSegment<bool>(
      value: false,
      label: 'Lista',
      icon: Icons.view_list_outlined,
    ),
    SintiaSegment<bool>(
      value: true,
      label: 'Cuadros',
      icon: Icons.grid_view_outlined,
    ),
  ],
  onChanged: (_) {},
);
// coverage:ignore-end
