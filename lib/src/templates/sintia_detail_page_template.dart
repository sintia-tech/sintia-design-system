import 'package:flutter/material.dart';

import '../models/sintia_app_bar_action.dart';
import '../organisms/sintia_app_bar.dart';
import '../tokens/sintia_breakpoints.dart';
import '../tokens/sintia_spacing.dart';
import 'sintia_page_template.dart';

/// Plantilla de página de detalle del sistema de diseño.
///
/// A diferencia de [SintiaPageTemplate], reserva un lugar para un
/// encabezado fijo (típicamente un organismo como `SintiaProfileHeader`)
/// que permanece visible mientras las secciones se desplazan debajo.
///
/// ```dart
/// SintiaDetailPageTemplate(
///   title: 'Perfil',
///   leading: SintiaAppBarLeading.back,
///   header: SintiaProfileHeader(name: 'Victor García'),
///   sections: <Widget>[actividadReciente, proyectos],
/// );
/// ```
class SintiaDetailPageTemplate extends StatelessWidget {
  const SintiaDetailPageTemplate({
    required this.title,
    required this.header,
    required this.sections,
    super.key,
    this.leading = SintiaAppBarLeading.back,
    this.onLeadingPressed,
    this.actions = const <SintiaAppBarAction>[],
    this.footer,
    this.maxWidth = SintiaBreakpoints.tablet,
    this.sectionSpacing = SintiaSpacing.extraLarge,
  });

  final String title;

  /// Encabezado fijo bajo la app bar, típicamente un organismo.
  final Widget header;

  /// Secciones desplazables bajo el encabezado.
  final List<Widget> sections;

  final SintiaAppBarLeading leading;
  final VoidCallback? onLeadingPressed;
  final List<SintiaAppBarAction> actions;

  /// Barra inferior fija, típicamente con el botón de acción principal.
  final Widget? footer;

  final double maxWidth;
  final double sectionSpacing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SintiaAppBar(
        title: title,
        leading: leading,
        onLeadingPressed: onLeadingPressed,
        actions: actions,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  SintiaSpacing.large,
                  SintiaSpacing.large,
                  SintiaSpacing.large,
                  0,
                ),
                child: header,
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(SintiaSpacing.large),
                  itemCount: sections.length,
                  separatorBuilder: (_, _) => SizedBox(height: sectionSpacing),
                  itemBuilder: (_, int index) => sections[index],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: footer == null
          ? null
          : SintiaPageFooter(maxWidth: maxWidth, child: footer!),
    );
  }
}
