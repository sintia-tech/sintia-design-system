import 'package:flutter/widgets.dart';

/// Un componente navegable del showcase.
class ComponentEntry {
  const ComponentEntry({
    required this.title,
    required this.builder,
    this.description,
    this.fullScreen = false,
  });

  final String title;

  /// Descripción corta mostrada en el listado de la categoría.
  final String? description;

  final WidgetBuilder builder;

  /// Si es true, [builder] ya devuelve una pantalla completa (con su propio
  /// `Scaffold`) y el showcase la abre tal cual.
  final bool fullScreen;
}
