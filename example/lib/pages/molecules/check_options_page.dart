import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// [SintiaCheckOption] con y sin enlace.
class CheckOptionsPage extends StatefulWidget {
  const CheckOptionsPage({super.key});

  @override
  State<CheckOptionsPage> createState() => _CheckOptionsPageState();
}

class _CheckOptionsPageState extends State<CheckOptionsPage> {
  bool _terms = false;
  bool _news = true;

  Future<void> _openTerms() {
    return SintiaDialog.show<void>(
      context: context,
      dialog: SintiaDialog(
        title: 'Términos y condiciones',
        message: 'Aquí iría el texto legal completo del servicio.',
        showCloseButton: true,
        primaryAction: SintiaButton(
          label: 'Entendido',
          expanded: true,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: 'Con enlace',
          description: 'El enlace abre un diálogo del sistema.',
          stacked: true,
          children: <Widget>[
            SintiaCheckOption(
              value: _terms,
              onChanged: (bool value) => setState(() => _terms = value),
              label: 'Acepto los',
              linkText: 'Términos y condiciones',
              onLinkTap: _openTerms,
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Simple',
          stacked: true,
          children: <Widget>[
            SintiaCheckOption(
              value: _news,
              onChanged: (bool value) => setState(() => _news = value),
              label: 'Quiero recibir novedades por correo',
            ),
          ],
        ),
      ],
    );
  }
}
