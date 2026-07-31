import 'package:flutter/material.dart';

import '../atoms/sintia_text.dart';
import '../previews/sintia_preview.dart';
import '../theme/extensions/sintia_text_style_extension.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_spacing.dart';

/// Estado vacío para listas o pantallas sin contenido.
///
/// También sirve como estado de error pasando el ícono y la acción de
/// reintento correspondientes.
///
/// ```dart
/// SintiaEmptyState(
///   icon: Icons.inbox_outlined,
///   title: 'Sin mensajes',
///   message: 'Cuando recibas mensajes aparecerán aquí.',
///   action: SintiaButton(label: 'Actualizar', onPressed: _refresh),
/// );
/// ```
class SintiaEmptyState extends StatelessWidget {
  const SintiaEmptyState({
    required this.title,
    super.key,
    this.icon = Icons.inbox_outlined,
    this.message,
    this.action,
  });

  final String title;
  final IconData icon;
  final String? message;

  /// Acción opcional debajo del mensaje, típicamente un `SintiaButton`.
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final String? message = this.message;
    final Widget? action = this.action;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SintiaSpacing.extraLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: SintiaSpacing.small,
          children: <Widget>[
            Icon(
              icon,
              size: SintiaIconSize.extraLarge,
              color: context.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: SintiaSpacing.small),
            SintiaText(
              title,
              style: context.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            if (message != null)
              SintiaText(
                message,
                style: context.textTheme.bodyMedium?.muted(context),
                textAlign: TextAlign.center,
              ),
            if (action != null) ...<Widget>[
              const SizedBox(height: SintiaSpacing.medium),
              action,
            ],
          ],
        ),
      ),
    );
  }
}

// coverage:ignore-start
@SintiaPreview(name: 'Sin contenido', group: 'SintiaEmptyState')
Widget sintiaEmptyStatePreview() => const SintiaEmptyState(
  title: 'Sin resultados',
  message: 'Intenta con otra búsqueda.',
);
// coverage:ignore-end
