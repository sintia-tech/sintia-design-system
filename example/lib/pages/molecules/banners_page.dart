import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Estados y opciones de [SintiaBanner].
class BannersPage extends StatefulWidget {
  const BannersPage({super.key});

  @override
  State<BannersPage> createState() => _BannersPageState();
}

class _BannersPageState extends State<BannersPage> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Estados',
          stacked: true,
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
        ),
        ShowcaseSection(
          title: 'Con acción y cierre',
          stacked: true,
          children: <Widget>[
            if (_visible)
              SintiaBanner(
                status: SintiaStatus.error,
                title: 'Sincronización pendiente',
                message: 'Quedaron 2 pedidos sin enviar al servidor.',
                onClose: () => setState(() => _visible = false),
                action: SintiaButton(
                  label: 'Reintentar',
                  size: SintiaSize.small,
                  variant: SintiaButtonVariant.ghost,
                  onPressed: () {},
                ),
              )
            else
              SintiaButton(
                label: 'Mostrar de nuevo',
                variant: SintiaButtonVariant.outline,
                onPressed: () => setState(() => _visible = true),
              ),
          ],
        ),
      ],
    );
  }
}
