import 'package:flutter/material.dart';

import '../foundations/sintia_status.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_spacing.dart';

/// Chip del sistema de diseño.
///
/// Sirve para etiquetas estáticas, chips de estado y filtros
/// seleccionables: si recibe [onSelected] se comporta como filtro con
/// estado; si recibe [status] se pinta con el color semántico del sistema.
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

    return RawChip(
      label: Text(label),
      avatar: icon != null
          ? Icon(icon, size: SintiaIconSize.small, color: statusColor)
          : null,
      selected: selected,
      onSelected: onSelected,
      onDeleted: onDeleted,
      showCheckmark: false,
      backgroundColor: statusColor?.withValues(alpha: _statusBackgroundAlpha),
      side: statusColor == null ? null : BorderSide(color: statusColor),
      labelStyle: statusColor == null
          ? null
          : context.textTheme.labelLarge?.copyWith(color: statusColor),
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
// coverage:ignore-end
