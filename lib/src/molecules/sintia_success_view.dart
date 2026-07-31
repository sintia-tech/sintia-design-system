import 'package:flutter/material.dart';

import '../atoms/sintia_button.dart';
import '../atoms/sintia_text.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_text_style_extension.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_spacing.dart';

/// Vista de confirmación con ícono, título, mensaje y acción principal.
///
/// Pensada para pantallas de éxito (ej. "¡Contraseña actualizada!"). Si no
/// se pasa [icon], usa un check con el color de éxito del tema, por lo que
/// no requiere ningún asset del consumidor.
///
/// ```dart
/// SintiaSuccessView(
///   title: '¡Contraseña actualizada!',
///   message: 'Ya puedes iniciar sesión con tu nueva contraseña.',
///   actionLabel: 'Continuar',
///   onAction: () => context.go('/login'),
/// );
/// ```
class SintiaSuccessView extends StatelessWidget {
  const SintiaSuccessView({
    required this.title,
    required this.actionLabel,
    required this.onAction,
    super.key,
    this.message,
    this.icon,
  });

  final String title;
  final String actionLabel;
  final VoidCallback onAction;
  final String? message;

  /// Ícono superior. Por defecto un check con `statusColors.success`.
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final String? message = this.message;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SintiaSpacing.extraLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: SintiaSpacing.small,
          children: <Widget>[
            icon ??
                Icon(
                  Icons.check_circle_rounded,
                  size: SintiaIconSize.extraLarge,
                  color: context.statusColors.success,
                ),
            const SizedBox(height: SintiaSpacing.medium),
            SintiaText(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.headlineSmall?.bold,
            ),
            if (message != null)
              SintiaText(
                message,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.muted(context),
              ),
            const SizedBox(height: SintiaSpacing.large),
            SintiaButton(
              label: actionLabel,
              expanded: true,
              onPressed: onAction,
            ),
          ],
        ),
      ),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Operación exitosa', group: 'SintiaSuccessView')
Widget sintiaSuccessViewPreview() => SintiaSuccessView(
  title: '¡Contraseña actualizada!',
  message: 'Ya puedes iniciar sesión con tu nueva contraseña.',
  actionLabel: 'Continuar',
  onAction: () {},
);
// coverage:ignore-end
