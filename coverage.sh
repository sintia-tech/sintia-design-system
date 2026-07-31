#!/bin/bash
set -e

echo "🧪 Ejecutando pruebas con cobertura..."
flutter test --coverage

echo ""
echo "🧹 Filtrando archivos generados y previews..."
lcov --remove coverage/lcov.info \
  '**/*.g.dart' \
  '**/*.freezed.dart' \
  '**/generated/**' \
  '**/.dart_tool/**' \
  -o coverage/lcov_filtered.info

echo ""
echo "📊 Generando reporte HTML..."
genhtml coverage/lcov_filtered.info -o coverage/html

echo ""
echo "✅ Reporte generado en coverage/html/index.html"
open coverage/html/index.html
