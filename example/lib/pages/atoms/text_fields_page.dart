import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// Estados y variantes de [SintiaTextField].
class TextFieldsPage extends StatefulWidget {
  const TextFieldsPage({super.key});

  @override
  State<TextFieldsPage> createState() => _TextFieldsPageState();
}

class _TextFieldsPageState extends State<TextFieldsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ShowcaseList(
      children: <Widget>[
        const ShowcaseSection(
          title: 'Básicos',
          stacked: true,
          children: <Widget>[
            SintiaTextField(
              label: 'Nombre',
              hint: 'Como aparece en tu documento',
            ),
            SintiaTextField(
              label: 'Correo',
              hint: 'tu@correo.com',
              prefixIcon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
            ),
            SintiaTextField(
              label: 'Contraseña',
              hint: 'Mínimo 8 caracteres',
              obscureText: true,
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Con ayuda y error',
          stacked: true,
          children: <Widget>[
            SintiaTextField(
              label: 'Teléfono',
              helperText: 'Lo usamos solo para avisos de entrega.',
              keyboardType: TextInputType.phone,
            ),
            SintiaTextField(
              label: 'Documento',
              errorText: 'El documento es requerido',
            ),
          ],
        ),
        const ShowcaseSection(
          title: 'Multilínea y deshabilitado',
          stacked: true,
          children: <Widget>[
            SintiaTextField(label: 'Observaciones', maxLines: 4),
            SintiaTextField(
              label: 'Documento verificado',
              initialValue: '1.020.304.050',
              enabled: false,
            ),
          ],
        ),
        ShowcaseSection(
          title: 'Con validación',
          description: 'Toca "Validar" para ver el validator en acción.',
          stacked: true,
          children: <Widget>[
            Form(
              key: _formKey,
              child: SintiaTextField(
                label: 'Correo',
                hint: 'tu@correo.com',
                validator: (String? value) => (value ?? '').contains('@')
                    ? null
                    : 'Ingresa un correo válido',
              ),
            ),
            SintiaButton(
              label: 'Validar',
              variant: SintiaButtonVariant.outline,
              onPressed: () => _formKey.currentState?.validate(),
            ),
          ],
        ),
      ],
    );
  }
}
