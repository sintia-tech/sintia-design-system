import 'package:flutter/material.dart';

import '../foundations/sintia_status.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_text_style_extension.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_spacing.dart';

/// Chip del sistema de diseño.
///
/// Sirve para etiquetas estáticas, chips de estado y filtros
/// seleccionables: si recibe [onSelected] se comporta como filtro con
/// estado; si recibe [status] se pinta con el color semántico del sistema.
///
/// Cuando está [selected] se rellena con el color de marca (o con el del
/// estado, si tiene uno) para que la selección se lea de un vistazo. Para
/// elegir **una** opción entre varias el componente es
/// `SintiaSegmentedControl`, no una fila de chips.
///
/// [backgroundColor], [foregroundColor] y [borderRadius] son overrides
/// puntuales para un chip que necesita salirse del tema (por ejemplo, un
/// diseño con acento propio); para toda la app, la vía es
/// `SintiaTheme` / `ChipThemeData`.
///
/// ```dart
/// SintiaChip(label: 'Activo', status: SintiaStatus.success);
///
/// SintiaChip(
///   label: 'Flutter',
///   icon: Icons.flutter_dash,
///   selected: isSelected,
///   onSelected: (bool value) => setState(() => isSelected = value),
/// );
///
/// SintiaChip(
///   label: 'FR',
///   selected: true,
///   backgroundColor: Colors.amber,
///   foregroundColor: Colors.black,
/// );
/// ```
class SintiaChip extends StatelessWidget {
  const SintiaChip({
    required this.label,
    super.key,
    this.icon,
    this.status,
    this.selected = false,
    this.onSelected,
    this.onDeleted,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
  });

  final String label;
  final IconData? icon;

  /// Si no es null, tiñe el chip con el color semántico del estado.
  final SintiaStatus? status;
  final bool selected;

  /// Callback al tocar el chip. Si es null, el chip es estático.
  final ValueChanged<bool>? onSelected;

  /// Muestra el ícono de borrar y lo invoca al tocarlo.
  final VoidCallback? onDeleted;

  /// Color de fondo para este chip puntual. Tiene precedencia sobre el
  /// color de [status] y el de marca, tanto seleccionado como no.
  final Color? backgroundColor;

  /// Color del texto y el ícono para este chip puntual. Tiene precedencia
  /// sobre el que resulta de [status] y [selected].
  final Color? foregroundColor;

  /// Radio de borde para este chip puntual. Si es null, usa
  /// `SintiaRadius.borderFull` del tema.
  final BorderRadius? borderRadius;

  /// Opacidad del color de estado usada como fondo del chip.
  static const double _statusBackgroundAlpha = 0.12;

  @override
  Widget build(BuildContext context) {
    final SintiaStatus? status = this.status;
    final Color? statusColor = status == null
        ? null
        : switch (status) {
            SintiaStatus.info => context.statusColors.info,
            SintiaStatus.success => context.statusColors.success,
            SintiaStatus.warning => context.statusColors.warning,
            SintiaStatus.error => context.colorScheme.error,
          };

    final ColorScheme colorScheme = context.colorScheme;

    // Acento del chip: el override puntual, el color del estado o, si no
    // tiene, el de marca.
    final Color accent = backgroundColor ?? statusColor ?? colorScheme.primary;

    // Contenido: contrasta con el relleno cuando está activo, usa el acento
    // cuando solo tiene estado y lo deja al tema cuando es neutral.
    final Color? foreground =
        foregroundColor ?? (selected ? colorScheme.onPrimary : statusColor);

    final BorderRadius? borderRadius = this.borderRadius;

    return RawChip(
      label: Text(label),
      avatar: icon != null
          ? Icon(icon, size: SintiaIconSize.small, color: foreground)
          : null,
      selected: selected,
      onSelected: onSelected,
      onDeleted: onDeleted,
      showCheckmark: false,
      backgroundColor:
          backgroundColor ??
          statusColor?.withValues(alpha: _statusBackgroundAlpha),
      selectedColor: accent,
      deleteIconColor: foreground,
      shape: borderRadius == null
          ? null
          : RoundedRectangleBorder(borderRadius: borderRadius),
      side: selected || statusColor != null || backgroundColor != null
          ? BorderSide(color: accent)
          : null,
      labelStyle: foreground == null
          ? null
          : context.textTheme.labelLarge?.withColor(foreground),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Estados', group: 'SintiaChip')
Widget sintiaChipStatusPreview() => const Wrap(
  spacing: SintiaSpacing.small,
  children: <Widget>[
    SintiaChip(label: 'Neutral'),
    SintiaChip(label: 'Activo', status: SintiaStatus.success),
    SintiaChip(label: 'Pendiente', status: SintiaStatus.warning),
    SintiaChip(label: 'Vencido', status: SintiaStatus.error),
  ],
);

@SintiaPreview(name: 'Filtros', group: 'SintiaChip')
Widget sintiaChipFilterPreview() => Wrap(
  spacing: SintiaSpacing.small,
  children: <Widget>[
    SintiaChip(label: 'Flutter', selected: true, onSelected: (_) {}),
    SintiaChip(label: 'Dart', onSelected: (_) {}),
  ],
);

@SintiaPreview(name: 'Personalizado', group: 'SintiaChip')
Widget sintiaChipCustomPreview() => const Wrap(
  spacing: SintiaSpacing.small,
  children: <Widget>[
    SintiaChip(
      label: 'FR',
      selected: true,
      backgroundColor: Colors.amber,
      foregroundColor: Colors.black,
    ),
    SintiaChip(
      label: 'Cuadrada',
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  ],
);
// coverage:ignore-end
