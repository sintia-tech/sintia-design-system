import 'package:flutter/material.dart';

import '../atoms/sintia_text.dart';
import '../foundations/sintia_status.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_text_style_extension.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_radius.dart';
import '../tokens/sintia_spacing.dart';

/// Banner para mensajes contextuales (información, éxito, advertencia o
/// error).
///
/// El estado se expresa con el vocabulario compartido [SintiaStatus]; los
/// colores salen de `SintiaStatusColors` y del `ColorScheme`, por lo que se
/// adaptan al tema claro/oscuro y a los overrides del consumidor.
///
/// ```dart
/// SintiaBanner(
///   status: SintiaStatus.success,
///   title: 'Cambios guardados',
///   message: 'Tu perfil se actualizó correctamente.',
///   onClose: () => setState(() => showBanner = false),
/// );
/// ```
class SintiaBanner extends StatelessWidget {
  const SintiaBanner({
    required this.message,
    super.key,
    this.status = SintiaStatus.info,
    this.title,
    this.onClose,
    this.action,
  });

  final String message;
  final SintiaStatus status;

  /// Título opcional destacado sobre el mensaje.
  final String? title;

  /// Si no es null, muestra el botón de cerrar.
  final VoidCallback? onClose;

  /// Acción opcional bajo el mensaje, típicamente un botón ghost.
  final Widget? action;

  /// Opacidad del color de estado usada como fondo del banner.
  static const double _backgroundAlpha = 0.12;

  /// Opacidad del color de estado usada en el borde del banner.
  static const double _borderAlpha = 0.4;

  @override
  Widget build(BuildContext context) {
    final String? title = this.title;
    final Widget? action = this.action;
    final Color color = switch (status) {
      SintiaStatus.info => context.statusColors.info,
      SintiaStatus.success => context.statusColors.success,
      SintiaStatus.warning => context.statusColors.warning,
      SintiaStatus.error => context.colorScheme.error,
    };
    final IconData icon = switch (status) {
      SintiaStatus.info => Icons.info_outline,
      SintiaStatus.success => Icons.check_circle_outline,
      SintiaStatus.warning => Icons.warning_amber_outlined,
      SintiaStatus.error => Icons.error_outline,
    };

    return Container(
      padding: const EdgeInsets.all(SintiaSpacing.medium),
      decoration: BoxDecoration(
        color: color.withValues(alpha: _backgroundAlpha),
        borderRadius: SintiaRadius.borderMedium,
        border: Border.all(color: color.withValues(alpha: _borderAlpha)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: SintiaSpacing.small,
        children: <Widget>[
          Icon(icon, color: color, size: SintiaIconSize.medium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: SintiaSpacing.extraSmall,
              children: <Widget>[
                if (title != null)
                  SintiaText(
                    title,
                    style: context.textTheme.titleSmall?.semiBold.withColor(
                      color,
                    ),
                  ),
                SintiaText(message),
                if (action != null) action,
              ],
            ),
          ),
          if (onClose != null)
            IconButton(
              onPressed: onClose,
              tooltip: 'Cerrar',
              iconSize: SintiaIconSize.small,
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.close),
            ),
        ],
      ),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Estados', group: 'SintiaBanner')
Widget sintiaBannerPreview() => const Column(
  mainAxisSize: MainAxisSize.min,
  spacing: SintiaSpacing.medium,
  children: <Widget>[
    SintiaBanner(message: 'Tu sesión expira en 5 minutos.'),
    SintiaBanner(
      status: SintiaStatus.success,
      title: 'Cambios guardados',
      message: 'Tu perfil se actualizó correctamente.',
    ),
    SintiaBanner(
      status: SintiaStatus.warning,
      message: 'Hay 3 pedidos sin confirmar.',
    ),
    SintiaBanner(
      status: SintiaStatus.error,
      title: 'No pudimos sincronizar',
      message: 'Revisa tu conexión e intenta de nuevo.',
    ),
  ],
);
// coverage:ignore-end
