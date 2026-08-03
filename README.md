# Sintia Design System

Sistema de diseño de **Sintia** para Flutter, organizado con **Atomic Design**.

Tu app inyecta la identidad visual (marca, fuentes y colores de estado); el
sistema aporta la consistencia (tokens, theming y componentes). Ningún
componente hardcodea colores: todo sale del tema.

```dart
MaterialApp(
  theme: SintiaTheme.light(config),
  darkTheme: SintiaTheme.dark(config),
  home: const HomePage(),
);
```

## Arquitectura

La base es un pipeline de capas
`foundations → tokens → theme → componentes`:

```
lib/
├── sintia_design_system.dart   # único barrel público
└── src/
    ├── foundations/   # SintiaSizes (escala cruda), SintiaSize, SintiaStatus
    ├── tokens/        # SintiaSpacing, SintiaRadius, SintiaIconSize,
    │                  # SintiaBreakpoints, SintiaElevation, SintiaShadows,
    │                  # SintiaDuration, SintiaNavDrawerMetrics
    ├── theme/         # SintiaTheme, SintiaThemeConfig, SintiaStatusColors
    │   └── extensions/# BuildContext (tema + responsive) y TextStyle
    ├── models/        # SintiaNavItem, SintiaAppBarAction, SintiaListItem
    ├── atoms/         # piezas indivisibles
    ├── molecules/     # combinaciones de átomos
    ├── organisms/     # secciones completas de interfaz
    ├── templates/     # estructura de pantalla sin contenido
    └── previews/      # SintiaPreview (Widget Previews con el tema aplicado)
```

Las **páginas** (último nivel de Atomic Design) son instancias de una plantilla
con datos reales, por lo que viven en la app consumidora y no en el paquete. La
showcase incluye dos de ejemplo.

### Reglas del sistema

- Las **foundations** son la base sin misión concreta: la escala cruda de
  valores (`SintiaSizes`, grilla de 4px) y el vocabulario que nombra sin decidir
  valores (`SintiaSize` para tamaños, `SintiaStatus` para estados). La escala
  solo la consumen los tokens y las traducciones internas de los componentes.
- Los **tokens** dan misión a los valores crudos (`SintiaSpacing.medium`,
  `SintiaRadius.small`), sin semántica de componente: no existe, por ejemplo, un
  `buttonColor`. Cuando una medida es propia de un componente y varias piezas
  necesitan hablar de ella, se declara como **token de componente**
  (`SintiaNavDrawerMetrics`).
- Los **componentes** traducen internamente el vocabulario a su propia
  proporción: el `SintiaSize.small` de un avatar no mide lo mismo que el de un
  loader, y esa decisión vive en el componente, no en la base.
- El **theme** mapea tokens + marca a un `ThemeData`, la única fuente de color y
  tipografía. Como la marca se inyecta en runtime, la semántica de color no son
  alias estáticos sino los roles de `ColorScheme` + `SintiaStatusColors`.
- Los **componentes** nunca usan colores hardcodeados: todo llega del tema vía
  `context.colorScheme`, `context.textTheme` y `context.statusColors`.
- Los **organismos y plantillas son puros**: no navegan ni guardan estado de
  ruta. Reciben datos y notifican por callbacks, así funcionan igual con
  GoRouter, Navigator 1.0 o un `IndexedStack`.

## Instalación

```yaml
dependencies:
  sintia_design_system: ^1.0.0
```

```dart
import 'package:sintia_design_system/sintia_design_system.dart';
```

> Este paquete se llamaba `sintia_system_design` hasta la 0.6.0. El nombre
> anterior está descontinuado en pub.dev: "design system" es el término correcto
> para un sistema de diseño ("system design" es arquitectura de sistemas). Si
> venís de una versión 0.x, cambiá el nombre de la dependencia y del import; el
> resto de la migración está en el [CHANGELOG](CHANGELOG.md).

## Theming

La identidad visual se define **una sola vez** con `SintiaThemeConfig` y
alimenta tanto el tema claro como el oscuro:

```dart
const SintiaThemeConfig config = SintiaThemeConfig(
  primary: Color(0xFF4F46E5),        // semilla de todo el ColorScheme
  secondary: Color(0xFF0D9488),      // opcional
  fontFamily: 'OpenSans',            // opcional: body, title, label
  headingFontFamily: 'Montserrat',   // opcional: display, headline, titleLarge
);

MaterialApp(
  theme: SintiaTheme.light(config),
  darkTheme: SintiaTheme.dark(config),
  themeMode: ThemeMode.system,
);
```

El paquete es **agnóstico a la fuente**: se registran en el `pubspec.yaml` de tu
app, desde assets locales o con `google_fonts`. Si no defines ninguna, se usa la
del sistema.

| Roles de texto | Fuente |
|---|---|
| `display*`, `headline*`, `titleLarge` | `headingFontFamily` (o `fontFamily`) |
| `title*`, `body*`, `label*` | `fontFamily` |

### Colores de estado

`ColorScheme` de Material solo trae `error`. El sistema agrega `success`,
`warning` e `info` como `ThemeExtension`, con defaults sobreescribibles:

```dart
SintiaTheme.light(
  config.copyWith(
    lightStatusColors: const SintiaStatusColors(
      success: Color(0xFF15803D),
      warning: Color(0xFFB45309),
      info: Color(0xFF1D4ED8),
    ),
  ),
);
```

Se leen en cualquier parte con `context.statusColors.success`.

## Componentes

### Átomos

| Componente | Para qué |
|---|---|
| `SintiaText` | Texto que nunca queda sin estilo (hereda `bodyMedium`) |
| `SintiaButton` | 5 variantes, 3 tamaños e indicador de carga automático |
| `SintiaTextField` | Campo con etiqueta externa, ayuda, error y contraseña |
| `SintiaChip` | Etiqueta, chip de estado o filtro seleccionable (relleno de marca al seleccionar) |
| `SintiaIconAction` | Botón de ícono compacto con badge |
| `SintiaLoader` | Indicador Lottie empaquetado en el paquete |
| `SintiaAvatar` | Imagen o iniciales en tres tamaños |

`SintiaButton` acepta callbacks sincrónicos y asíncronos. Si `onPressed`
devuelve un `Future`, el botón se bloquea y muestra el loader hasta que termina,
sin que tengas que manejar el estado:

```dart
SintiaButton(
  label: 'Guardar',
  icon: Icons.check,
  onPressed: () async => repository.save(form),
);
```

La etiqueta que `SintiaTextField` dibuja **sobre** el campo se configura una
sola vez para toda la app con `inputLabelColor`, sin repetirla campo a campo:

```dart
const SintiaThemeConfig config = SintiaThemeConfig(
  primary: Color(0xFFFDF663),
  inputLabelColor: Color(0xFFFDF663),   // etiquetas en el color de marca
);
```

Viaja al tema como `inputDecorationTheme.labelStyle`. Si un campo suelto
necesita otra cosa, `SintiaTextField.labelStyle` tiene precedencia.

### Moléculas

| Componente | Para qué |
|---|---|
| `SintiaCard` | Superficie con padding y tap opcional |
| `SintiaBanner` | Mensaje contextual por `SintiaStatus` |
| `SintiaEmptyState` | Lista vacía o estado de error con acción |
| `SintiaListTile` | Fila con avatar/ícono, textos y etiqueta |
| `SintiaConfirmDialog` | Confirmación con helper `show` que resuelve `bool?` |
| `SintiaCheckOption` | Aceptación con enlace legal |
| `SintiaSegmentedControl<T>` | Selección única entre varias opciones |
| `SintiaOtpField` | Código con casillas y foco automático |
| `SintiaSuccessView` | Cierre de flujo exitoso |
| `SintiaAppBarTitle` | Título con prefijo/sufijo, táctil opcional |
| `SintiaNavDrawerHeader`, `SintiaNavDrawerItem` | Piezas del drawer |

`SintiaSegmentedControl` es el componente para elegir **una** opción entre
varias (idioma, periodo, modo de vista). Es genérico, así que el valor puede
ser un `enum` o cualquier identificador, y declara sus opciones como datos:

```dart
SintiaSegmentedControl<String>(
  value: locale,
  size: SintiaSize.small,
  segments: const <SintiaSegment<String>>[
    SintiaSegment<String>(value: 'es', label: 'ES'),
    SintiaSegment<String>(value: 'en', label: 'EN'),
  ],
  onChanged: (String value) => setState(() => locale = value),
);
```

Para varias selecciones a la vez el componente es `SintiaChip` con
`onSelected`; para un booleano suelto, el `Switch` de Material.

### Organismos

| Componente | Para qué |
|---|---|
| `SintiaAppBar` | App bar con leading (`none`/`back`/`menu`) y acciones |
| `SintiaNavigationDrawer` | Menú lateral colapsable (rail ↔ expandido) |
| `SintiaDialog` | Diálogo compuesto por ranuras |
| `SintiaListSection` | Sección con encabezado, acción y elementos |
| `SintiaProfileHeader` | Cabecera de una entidad |

### Plantillas

| Plantilla | Para qué |
|---|---|
| `SintiaPageTemplate` | App bar + secciones + footer, con ancho máximo |
| `SintiaDetailPageTemplate` | Igual, con encabezado fijo |
| `SintiaShellTemplate` | Estructura maestra con drawer, responsiva |

## Navegación lateral

`SintiaShellTemplate` resuelve el patrón completo de una app con menú:

- **Escritorio y tablet**: drawer permanente y colapsable a rail de 80px, con
  tooltips en los íconos.
- **Móvil**: el drawer se abre como modal desde el botón de menú de la app bar y
  se cierra al elegir una ruta.

```dart
const List<SintiaNavItem> items = <SintiaNavItem>[
  SintiaNavItem(
    label: 'Inicio',
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
    route: '/',
  ),
  SintiaNavItem(
    label: 'Pedidos',
    icon: Icons.receipt_long_outlined,
    route: '/orders',
    badgeCount: 12,
  ),
  SintiaNavItem(
    label: 'Reportes',
    icon: Icons.insert_chart_outlined,
    route: '/reports',
    dividerAbove: true,
  ),
];

SintiaShellTemplate(
  logo: Image.asset('assets/logo.png', height: 32),    // drawer expandido
  mark: Image.asset('assets/isotipo.png', height: 32), // drawer colapsado
  items: items,
  footerItems: <SintiaNavItem>[settingsItem, logoutItem],
  currentRoute: state.uri.path,
  onRouteSelected: context.go,
  body: child,
);
```

Si necesitas controlar el drawer por tu cuenta (por ejemplo, para persistir el
estado colapsado), usa `SintiaNavigationDrawer` directamente con `collapsed` +
`onToggleCollapsed`. Sus medidas están en `SintiaNavDrawerMetrics`, por si tu
layout necesita animarse junto al menú.

## Extensiones

### `BuildContext`

```dart
context.theme;          context.colorScheme;   context.textTheme;
context.statusColors;   context.isDarkMode;    context.primaryColor;
context.onPrimaryColor; context.errorColor;    context.surfaceColor;

context.isMobile;       context.isTablet;      context.isDesktop;
context.screenWidth;    context.screenHeight;

final int columns = context.responsiveValue<int>(
  mobile: 1,
  tablet: 2,
  desktop: 4,
);
```

### `TextStyle`

```dart
context.textTheme.titleMedium!.semiBold.primary(context);
context.textTheme.bodySmall!.muted(context);
someStyle.withColor(context.statusColors.success);
// pesos:   regular · medium · semiBold · bold
// colores: primary · secondary · error · muted · withColor
```

## Widget Previews

Cada componente trae previews anotados con `@SintiaPreview`, que aplican el tema
del sistema. Se ven directamente en el IDE (Flutter Widget Previews) y la
anotación también sirve en tu app:

```dart
@SintiaPreview(name: 'Formulario', group: 'Login')
Widget loginFormPreview() => const LoginForm();
```

## Showcase

App navegable con todos los tokens y componentes, construida con la propia
`SintiaShellTemplate`:

```bash
cd example && flutter run -d chrome
```

## Desarrollo

```bash
flutter analyze          # análisis estricto (ver analysis_options.yaml)
flutter test             # suite del paquete
./coverage.sh            # cobertura + reporte HTML
cd example && flutter test
```

### Agregar un componente nuevo

1. **Ubica la capa** por composición, no por complejidad: ¿es indivisible
   (átomo), combina átomos (molécula), es una sección completa (organismo) o
   define estructura sin contenido (plantilla)?
2. **Crea el archivo** en `lib/src/<capa>/sintia_<nombre>.dart`, con dartdoc que
   explique **para qué sirve** y un ejemplo de uso.
3. **Usa tokens y tema**: nada de números ni colores hardcodeados. Si necesitas
   una medida nueva, agrégala a `SintiaSizes` y dale misión en un token.
4. **Datos como modelos**: si el componente recibe una lista de configuración,
   declara un modelo inmutable en `models/` en lugar de aceptar widgets sueltos.
5. **Mantenlo puro**: sin navegación ni estado global adentro; callbacks hacia
   afuera.
6. **Agrega un `@SintiaPreview`** entre marcas `// coverage:ignore-start/end`.
7. **Expórtalo** en `lib/sintia_design_system.dart` (orden alfabético).
8. **Escribe el test** en `test/<capa>/` y **la página** de la showcase en
   `example/lib/pages/<capa>/`, con su entrada en `catalog.dart`.
9. **Regístralo** en [PROJECT_INDEX.md](PROJECT_INDEX.md) y en el
   [CHANGELOG](CHANGELOG.md).

## Enlaces

- Sitio: [sintia.tech](https://sintia.tech)
- Repositorio:
  [github.com/sintia-tech/sintia-design-system](https://github.com/sintia-tech/sintia-design-system)
- Issues:
  [github.com/sintia-tech/sintia-design-system/issues](https://github.com/sintia-tech/sintia-design-system/issues)
