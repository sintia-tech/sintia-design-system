import 'package:flutter/widgets.dart';

import 'component_entry.dart';

/// Una categoría del sistema: tokens, átomos, moléculas, organismos,
/// plantillas y páginas de ejemplo.
class ComponentCategory {
  const ComponentCategory({
    required this.route,
    required this.title,
    required this.icon,
    required this.entries,
  });

  /// Ruta usada por el drawer del showcase.
  final String route;

  final String title;
  final IconData icon;
  final List<ComponentEntry> entries;
}
