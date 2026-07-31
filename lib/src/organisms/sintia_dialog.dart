import 'package:flutter/material.dart';

import '../atoms/sintia_text.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_text_style_extension.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_spacing.dart';

/// Diálogo compuesto del sistema de diseño.
///
/// Organismo con ranuras opcionales: ícono, título, mensaje (o [content]
/// libre), acciones y botón de cierre. Para una confirmación simple usar
/// `SintiaConfirmDialog`, que ya resuelve los dos botones y el resultado.
///
/// Forma, color y elevación salen del `dialogTheme` de `SintiaTheme`.
///
/// ```dart
/// await SintiaDialog.show<void>(
///   context: context,
///   dialog: SintiaDialog(
///     icon: Icon(Icons.mark_email_read_outlined),
///     title: 'Revisa tu correo',
///     message: 'Te enviamos un enlace para restablecer tu contraseña.',
///     primaryAction: SintiaButton(
///       label: 'Entendido',
///       expanded: true,
///       onPressed: () => Navigator.of(context).pop(),
///     ),
///   ),
/// );
/// ```
class SintiaDialog extends StatelessWidget {
  const SintiaDialog({
    super.key,
    this.icon,
    this.title,
    this.message,
    this.content,
    this.primaryAction,
    this.secondaryAction,
    this.showCloseButton = false,
    this.onClose,
    this.padding = const EdgeInsets.all(SintiaSpacing.large),
  });

  /// Ícono o ilustración sobre el título.
  final Widget? icon;
  final String? title;

  /// Mensaje del diálogo. Se ignora si se pasa [content].
  final String? message;

  /// Contenido libre, con precedencia sobre [message].
  final Widget? content;

  /// Acción principal, típicamente un `SintiaButton` primario.
  final Widget? primaryAction;

  /// Acción secundaria, típicamente un `SintiaButton` ghost u outline.
  final Widget? secondaryAction;

  /// Muestra la "X" de cierre en la esquina superior derecha.
  final bool showCloseButton;

  /// Acción del botón de cierre. Por defecto hace `Navigator.pop`.
  final VoidCallback? onClose;

  final EdgeInsetsGeometry padding;

  /// Proporción máxima del alto de pantalla que puede ocupar el diálogo.
  static const double _maxHeightFactor = 0.8;

  /// Abre el diálogo con `showDialog` y devuelve su resultado.
  static Future<T?> show<T>({
    required BuildContext context,
    required SintiaDialog dialog,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget? icon = this.icon;
    final String? title = this.title;
    final String? message = this.message;
    final Widget? content = this.content;
    final Widget? primaryAction = this.primaryAction;
    final Widget? secondaryAction = this.secondaryAction;

    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * _maxHeightFactor,
        ),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              padding: padding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: SintiaSpacing.small,
                children: <Widget>[
                  if (icon != null)
                    IconTheme.merge(
                      data: IconThemeData(
                        size: SintiaIconSize.extraLarge,
                        color: context.colorScheme.primary,
                      ),
                      child: Center(child: icon),
                    ),
                  if (title != null)
                    SintiaText(
                      title,
                      textAlign: TextAlign.center,
                      style: context.textTheme.titleLarge?.semiBold,
                    ),
                  if (content != null)
                    content
                  else if (message != null)
                    SintiaText(
                      message,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium?.muted(context),
                    ),
                  if (primaryAction != null) ...<Widget>[
                    const SizedBox(height: SintiaSpacing.small),
                    primaryAction,
                  ],
                  if (secondaryAction != null) secondaryAction,
                ],
              ),
            ),
            if (showCloseButton)
              Positioned(
                top: SintiaSpacing.small,
                right: SintiaSpacing.small,
                child: IconButton(
                  tooltip: MaterialLocalizations.of(context).closeButtonLabel,
                  iconSize: SintiaIconSize.small,
                  onPressed: onClose ?? () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Informativo', group: 'SintiaDialog')
Widget sintiaDialogPreview() => const SintiaDialog(
  icon: Icon(Icons.mark_email_read_outlined),
  title: 'Revisa tu correo',
  message: 'Te enviamos un enlace para restablecer tu contraseña.',
  showCloseButton: true,
);
// coverage:ignore-end
