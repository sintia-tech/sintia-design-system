import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintia_design_system/sintia_design_system.dart';

/// Marca usada en las pruebas.
const SintiaThemeConfig testConfig = SintiaThemeConfig(
  primary: Color(0xFF4F46E5),
);

/// Envuelve [child] en una app con el tema del sistema.
Widget wrapSintia(Widget child, {Brightness brightness = Brightness.light}) {
  return MaterialApp(
    theme: brightness == Brightness.dark
        ? SintiaTheme.dark(testConfig)
        : SintiaTheme.light(testConfig),
    home: Scaffold(body: Center(child: child)),
  );
}

/// Envuelve [child] sin `Scaffold`, para pantallas completas.
Widget wrapSintiaScreen(Widget child) {
  return MaterialApp(theme: SintiaTheme.light(testConfig), home: child);
}

/// Fija el tamaño de la ventana de prueba y lo restaura al terminar.
void setViewSize(WidgetTester tester, Size size) {
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.reset);
}
