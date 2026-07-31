import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Composición de [SintiaDialog] por ranuras.
class DialogsPage extends StatelessWidget {
  const DialogsPage({super.key});

  Future<void> _showInfo(BuildContext context) {
    return SintiaDialog.show<void>(
      context: context,
      dialog: SintiaDialog(
        icon: const Icon(Icons.mark_email_read_outlined),
        title: 'Revisa tu correo',
        message: 'Te enviamos un enlace para restablecer tu contraseña.',
        showCloseButton: true,
        primaryAction: SintiaButton(
          label: 'Entendido',
          expanded: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Future<void> _showActions(BuildContext context) {
    return SintiaDialog.show<void>(
      context: context,
      dialog: SintiaDialog(
        title: '¿Guardar los cambios?',
        message: 'Si sales ahora perderás lo que escribiste.',
        primaryAction: SintiaButton(
          label: 'Guardar',
          expanded: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
        secondaryAction: SintiaButton(
          label: 'Descartar',
          variant: SintiaButtonVariant.ghost,
          expanded: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  Future<void> _showContent(BuildContext context) {
    return SintiaDialog.show<void>(
      context: context,
      dialog: SintiaDialog(
        title: 'Nuevo cliente',
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          spacing: SintiaSpacing.medium,
          children: <Widget>[
            SintiaTextField(label: 'Nombre'),
            SintiaTextField(label: 'Correo'),
          ],
        ),
        primaryAction: SintiaButton(
          label: 'Crear',
          expanded: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
        showCloseButton: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Ranuras',
          description:
              'Ícono, título, mensaje o contenido libre, y hasta dos '
              'acciones.',
          children: <Widget>[
            SintiaButton(
              label: 'Informativo',
              onPressed: () => _showInfo(context),
            ),
            SintiaButton(
              label: 'Dos acciones',
              variant: SintiaButtonVariant.outline,
              onPressed: () => _showActions(context),
            ),
            SintiaButton(
              label: 'Con formulario',
              variant: SintiaButtonVariant.secondary,
              onPressed: () => _showContent(context),
            ),
          ],
        ),
      ],
    );
  }
}
