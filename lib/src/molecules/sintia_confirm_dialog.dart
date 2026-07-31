import 'package:flutter/material.dart';

import '../atoms/sintia_button.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_spacing.dart';

/// Diálogo de confirmación del sistema de diseño.
///
/// Molécula que une átomos ([SintiaButton]) y texto para ofrecer una
/// confirmación consistente en toda la app. El widget es puro: no conoce el
/// `Navigator`, solo notifica por [onConfirm] y [onCancel]. El helper [show]
/// lo abre con `showDialog` y cablea los callbacks al `Navigator`:
///
/// ```dart
/// final bool? confirmed = await SintiaConfirmDialog.show(
///   context: context,
///   title: '¿Eliminar elemento?',
///   message: 'Esta acción no se puede deshacer.',
///   confirmLabel: 'Eliminar',
///   danger: true,
/// );
/// if (confirmed ?? false) _delete();
/// ```
class SintiaConfirmDialog extends StatelessWidget {
  const SintiaConfirmDialog({
    required this.title,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
    super.key,
    this.confirmLabel = 'Confirmar',
    this.cancelLabel = 'Cancelar',
    this.danger = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  /// Invocado al tocar la acción de confirmar.
  final VoidCallback onConfirm;

  /// Invocado al tocar la acción de cancelar.
  final VoidCallback onCancel;

  /// Resalta la acción de confirmar con el color de error del tema.
  final bool danger;

  /// Abre el diálogo y resuelve con `true` si el usuario confirma, `false`
  /// si cancela y `null` si lo descarta.
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Confirmar',
    String cancelLabel = 'Cancelar',
    bool danger = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => SintiaConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        danger: danger,
        onConfirm: () => Navigator.of(dialogContext).pop(true),
        onCancel: () => Navigator.of(dialogContext).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: danger
          ? Icon(
              Icons.warning_amber_outlined,
              color: context.colorScheme.error,
            )
          : null,
      title: Text(title),
      content: Text(message, style: context.textTheme.bodyMedium),
      actionsPadding: const EdgeInsets.all(SintiaSpacing.medium),
      actions: <Widget>[
        SintiaButton(
          label: cancelLabel,
          variant: SintiaButtonVariant.ghost,
          onPressed: onCancel,
        ),
        SintiaButton(
          label: confirmLabel,
          variant: danger
              ? SintiaButtonVariant.danger
              : SintiaButtonVariant.primary,
          onPressed: onConfirm,
        ),
      ],
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Destructivo', group: 'SintiaConfirmDialog')
Widget sintiaConfirmDialogPreview() => SintiaConfirmDialog(
  title: '¿Eliminar elemento?',
  message: 'Esta acción no se puede deshacer.',
  confirmLabel: 'Eliminar',
  danger: true,
  onConfirm: () {},
  onCancel: () {},
);
// coverage:ignore-end
