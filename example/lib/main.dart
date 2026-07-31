import 'package:flutter/material.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

import 'showcase/showcase_shell.dart';

void main() => runApp(const ShowcaseApp());

/// Showcase del sistema de diseño Sintia.
///
/// La identidad visual (marca y fuentes) se define una sola vez aquí; todo
/// lo demás sale del sistema. Las fuentes se registran en el `pubspec.yaml`
/// de esta app: el paquete es agnóstico a la fuente.
class ShowcaseApp extends StatefulWidget {
  const ShowcaseApp({super.key});

  @override
  State<ShowcaseApp> createState() => _ShowcaseAppState();
}

class _ShowcaseAppState extends State<ShowcaseApp> {
  static const SintiaThemeConfig _config = SintiaThemeConfig(
    primary: Color(0xFF4F46E5),
    secondary: Color(0xFF0D9488),
    fontFamily: 'OpenSans',
    headingFontFamily: 'Montserrat',
  );

  ThemeMode _themeMode = ThemeMode.light;

  bool get _isDark => _themeMode == ThemeMode.dark;

  void _toggleTheme() {
    setState(() => _themeMode = _isDark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sintia Design System',
      debugShowCheckedModeBanner: false,
      theme: SintiaTheme.light(_config),
      darkTheme: SintiaTheme.dark(_config),
      themeMode: _themeMode,
      home: ShowcaseShell(isDark: _isDark, onToggleTheme: _toggleTheme),
    );
  }
}
