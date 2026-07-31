# CLAUDE.md

Guía para trabajar en este repositorio. Es un **paquete de sistema de diseño
Flutter** (no una app): `sintia_system_design`.

## Comandos

```bash
flutter analyze                      # debe quedar en 0 issues (lints estrictos)
flutter test                         # suite del paquete
./coverage.sh                        # cobertura + reporte HTML
dart format .                        # formato (trailing_commas: preserve)

cd example && flutter test           # pruebas de la showcase
cd example && flutter run -d chrome  # showcase navegable
```

## Arquitectura (no negociable)

Pipeline de capas `foundations → tokens → theme → componentes`. Cada capa solo
consume la anterior:

```
lib/src/
├── foundations/   SintiaSizes (escala cruda 4px), SintiaSize, SintiaStatus
├── tokens/        misión a los valores: Spacing, Radius, IconSize,
│                  Breakpoints, Elevation, Shadows, Duration, NavDrawerMetrics
├── theme/         SintiaTheme + SintiaThemeConfig + SintiaStatusColors
│   └── extensions/  BuildContext (tema, responsive) y TextStyle
├── models/        datos inmutables que configuran componentes
├── atoms/ molecules/ organisms/ templates/
└── previews/      SintiaPreview
```

Reglas que se aplican en cada cambio:

1. **Cero colores y números hardcodeados en componentes.** El color sale de
   `context.colorScheme` / `context.statusColors`; las medidas, de los tokens.
   Si falta un valor, se agrega a `SintiaSizes` y se le da misión en un token.
2. **Los tokens no tienen semántica de componente** (no existe `buttonColor`).
   La excepción son los *tokens de componente* como `SintiaNavDrawerMetrics`,
   que se declaran cuando varias piezas y la app consumidora necesitan hablar de
   la misma medida.
3. **`SintiaSize` es vocabulario, no valores.** Cada componente traduce
   `small/medium/large` a su propia proporción, en un `switch` interno.
4. **Componentes puros.** Ni navegación ni estado global adentro: reciben datos y
   notifican por callbacks. Los helpers que sí navegan son estáticos y
   explícitos (`SintiaConfirmDialog.show`, `SintiaDialog.show`).
5. **Configuración como datos.** Listas de configuración (navegación, acciones,
   items) se declaran con modelos de `models/`, no con widgets sueltos.
6. **Imports relativos dentro del paquete.** Nunca
   `package:sintia_system_design/...` en `lib/src/`.
7. **Un solo barrel**: `lib/sintia_system_design.dart`, con los exports en orden
   alfabético (lo exige `directives_ordering`).

## Convenciones de código

- Los lints son estrictos: tipos explícitos en todas las declaraciones
  (`always_specify_types`), comas finales, comillas simples, líneas de 80
  caracteres, `discarded_futures`. Si `flutter analyze` marca algo, se corrige;
  no se silencia.
- Todo miembro público lleva dartdoc en español que explique **para qué sirve**
  (no qué tipo es) y, en los componentes, un ejemplo de uso en ```dart.
- Cada componente termina con sus previews entre
  `// coverage:ignore-start` / `// coverage:ignore-end`.
- Nombres de archivo `sintia_<nombre>.dart`; clases con prefijo `Sintia`.
- Los widgets privados de un archivo van al final, con `_` y su propio dartdoc
  de una línea.

## Al agregar o cambiar un componente

Checklist completo en el README (“Agregar un componente nuevo”). En resumen:
archivo en la capa correcta → export en el barrel → `@SintiaPreview` → test en
`test/<capa>/` → página en `example/lib/pages/<capa>/` + entrada en
`example/lib/catalog/catalog.dart` → fila en `PROJECT_INDEX.md` → entrada en
`CHANGELOG.md`.

## Cosas que ya se decidieron (no revertir sin hablarlo)

- **No hay paleta estática.** `AppColors` se eliminó en la 1.0.0: rompía el
  theming en runtime y el modo oscuro.
- **El paquete es agnóstico a la fuente.** No se empaquetan `.ttf`; la app
  registra sus fuentes y las pasa por `SintiaThemeConfig`. Los `.ttf` de
  `example/assets/fonts/` son solo demostración.
- **El único asset del paquete** es `assets/animations/loading.json`, que usa
  `SintiaLoader` con `package: 'sintia_system_design'`.
- En tests, `pumpAndSettle` no se estabiliza si hay un `SintiaLoader` visible (la
  animación Lottie es infinita). Para abrir diálogos en pruebas, usar un botón de
  Material en vez de `SintiaButton` con `onPressed` asíncrono.
