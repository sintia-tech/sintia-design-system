import 'package:flutter/material.dart';

import '../models/sintia_app_bar_action.dart';
import '../organisms/sintia_app_bar.dart';
import '../tokens/sintia_breakpoints.dart';
import '../tokens/sintia_spacing.dart';

/// Plantilla de página del sistema de diseño.
///
/// Define la estructura de una pantalla sin conocer su contenido real: app
/// bar con título y acciones, secciones apiladas con ancho máximo
/// responsivo y una barra de acción inferior opcional. Las páginas se
/// construyen instanciando esta plantilla con organismos y datos concretos.
///
/// ```dart
/// SintiaPageTemplate(
///   title: 'Mi equipo',
///   sections: <Widget>[banner, listadoDeIntegrantes],
///   footer: SintiaButton(
///     label: 'Agregar',
///     expanded: true,
///     onPressed: _add,
///   ),
/// );
/// ```
class SintiaPageTemplate extends StatelessWidget {
  const SintiaPageTemplate({
    required this.title,
    required this.sections,
    super.key,
    this.leading = SintiaAppBarLeading.none,
    this.onLeadingPressed,
    this.actions = const <SintiaAppBarAction>[],
    this.footer,
    this.maxWidth = SintiaBreakpoints.tablet,
    this.padding = const EdgeInsets.all(SintiaSpacing.large),
    this.sectionSpacing = SintiaSpacing.extraLarge,
    this.floatingActionButton,
  });

  final String title;

  /// Secciones del cuerpo, típicamente organismos, apiladas verticalmente.
  final List<Widget> sections;

  final SintiaAppBarLeading leading;
  final VoidCallback? onLeadingPressed;
  final List<SintiaAppBarAction> actions;

  /// Barra inferior fija, típicamente con el botón de acción principal.
  final Widget? footer;

  /// Ancho máximo del contenido en pantallas grandes.
  final double maxWidth;

  final EdgeInsetsGeometry padding;
  final double sectionSpacing;
  final Widget? floatingActionButton;

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
          child: ListView.separated(
            padding: padding,
            itemCount: sections.length,
            separatorBuilder: (_, _) => SizedBox(height: sectionSpacing),
            itemBuilder: (_, int index) => sections[index],
          ),
        ),
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: footer == null
          ? null
          : SintiaPageFooter(maxWidth: maxWidth, child: footer!),
    );
  }
}

/// Barra inferior de las plantillas: respeta el área segura y el ancho
/// máximo del contenido.
class SintiaPageFooter extends StatelessWidget {
  const SintiaPageFooter({
    required this.child,
    super.key,
    this.maxWidth = SintiaBreakpoints.tablet,
  });

  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // heightFactor: 1 evita que el Center se expanda verticalmente y le
      // quite espacio al body.
      child: Center(
        heightFactor: 1,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              SintiaSpacing.large,
              SintiaSpacing.small,
              SintiaSpacing.large,
              SintiaSpacing.large,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
