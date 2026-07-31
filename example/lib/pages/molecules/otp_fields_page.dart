import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import '../../showcase/widgets/showcase_list.dart';
import '../../showcase/widgets/showcase_section.dart';

/// [SintiaOtpField] con distintas longitudes.
class OtpFieldsPage extends StatefulWidget {
  const OtpFieldsPage({super.key});

  @override
  State<OtpFieldsPage> createState() => _OtpFieldsPageState();
}

class _OtpFieldsPageState extends State<OtpFieldsPage> {
  String? _code;

  @override
  Widget build(BuildContext context) {
    final String? code = _code;
    return ShowcaseList(
      children: <Widget>[
        ShowcaseSection(
          title: '6 dígitos',
          description: 'Longitud por defecto, la del OTP por correo.',
          stacked: true,
          children: <Widget>[
            SintiaOtpField(
              onCompleted: (String value) => setState(() => _code = value),
            ),
          ],
        ),
        if (code != null)
          SintiaBanner(
            status: SintiaStatus.success,
            title: 'Código completo',
            message: code,
          ),
        ShowcaseSection(
          title: '4 dígitos',
          stacked: true,
          children: <Widget>[
            SintiaOtpField(length: 4, onCompleted: (_) {}),
          ],
        ),
      ],
    );
  }
}
