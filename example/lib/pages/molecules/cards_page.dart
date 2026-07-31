import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Variantes de [SintiaCard].
class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Superficie',
          stacked: true,
          children: <Widget>[
            const SintiaCard(child: SintiaText('Tarjeta simple')),
            const SintiaCard(
              showBorder: true,
              child: SintiaText('Tarjeta con borde'),
            ),
            SintiaCard(
              onTap: () {},
              child: Row(
                children: <Widget>[
                  const Expanded(child: SintiaText('Tarjeta táctil')),
                  Icon(Icons.chevron_right, color: context.colorScheme.outline),
                ],
              ),
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Contenido compuesto',
          stacked: true,
          children: <Widget>[
            SintiaCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: SintiaSpacing.small,
                children: <Widget>[
                  SintiaText(
                    'Pedido #10245',
                    style: context.textTheme.titleMedium?.semiBold,
                  ),
                  const SintiaText('4 productos · Entrega mañana'),
                  const Wrap(
                    spacing: SintiaSpacing.small,
                    children: <Widget>[
                      SintiaChip(
                        label: 'Confirmado',
                        status: SintiaStatus.success,
                      ),
                      SintiaChip(label: 'Contado'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
