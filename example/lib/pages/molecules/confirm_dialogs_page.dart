import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// [SintiaConfirmDialog] y su helper `show`.
class ConfirmDialogsPage extends StatefulWidget {
  const ConfirmDialogsPage({super.key});

  @override
  State<ConfirmDialogsPage> createState() => _ConfirmDialogsPageState();
}

class _ConfirmDialogsPageState extends State<ConfirmDialogsPage> {
  String? _result;

  Future<void> _confirm({required bool danger}) async {
    final bool? confirmed = await SintiaConfirmDialog.show(
      context: context,
      title: danger ? '¿Eliminar pedido?' : '¿Enviar pedido?',
      message: danger
          ? 'Esta acción no se puede deshacer.'
          : 'Se notificará al cliente por correo.',
      confirmLabel: danger ? 'Eliminar' : 'Enviar',
      danger: danger,
    );
    if (!mounted) return;
    setState(() {
      _result = switch (confirmed) {
        true => 'Confirmado',
        false => 'Cancelado',
        null => 'Descartado',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final String? result = _result;
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Con helper show',
          description:
              'Resuelve true al confirmar, false al cancelar y null si se '
              'descarta.',
          children: <Widget>[
            SintiaButton(
              label: 'Confirmación normal',
              onPressed: () => _confirm(danger: false),
            ),
            SintiaButton(
              label: 'Confirmación destructiva',
              variant: SintiaButtonVariant.danger,
              onPressed: () => _confirm(danger: true),
            ),
          ],
        ),
        if (result != null)
          SintiaBanner(
            message: 'Resultado: $result',
          ),
        const ShowcaseSection(
          title: 'Widget puro',
          description: 'Sin Navigator: solo notifica por onConfirm y onCancel.',
          stacked: true,
          children: <Widget>[
            SintiaCard(
              showBorder: true,
              child: SintiaText(
                'SintiaConfirmDialog también se usa embebido en pruebas y '
                'flujos propios, porque no conoce la navegación.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
