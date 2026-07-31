import 'package:flutter/material.dart';
import 'package:sintia_system_design/sintia_system_design.dart';

/// Envoltorio de una página de componente: app bar con botón de volver y el
/// contenido del componente.
class ShowcasePage extends StatelessWidget {
  const ShowcasePage({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SintiaAppBar(
        title: title,
        leading: SintiaAppBarLeading.back,
      ),
      body: child,
    );
  }
}
