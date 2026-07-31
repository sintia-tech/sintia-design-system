## 1.0.0

Reconstrucción completa del sistema de diseño sobre un pipeline de capas
(`foundations → tokens → theme → componentes`), con `lib/src` privado y un único
barrel público. **Rompe la API respecto a la 0.6.0**: cambia el nombre del
paquete, los nombres de las clases, las rutas de importación y el theming (ver
**Migración**).

### Renombrado del paquete

El paquete pasó de `sintia_system_design` a **`sintia_design_system`**: en inglés
"design system" es un sistema de diseño, mientras que "system design" significa
arquitectura de sistemas. El nombre anterior queda descontinuado en pub.dev
apuntando a este.

```yaml
dependencies:
  sintia_design_system: ^1.0.0   # antes: sintia_system_design
```

```dart
import 'package:sintia_design_system/sintia_design_system.dart';
```

### Arquitectura

* Estructura reorganizada en `lib/src/`, expuesta solo a través de
  `sintia_design_system.dart`. Se eliminan los imports profundos
  (`package:sintia_design_system/tokens/...`).
* Capas explícitas:
  * **`foundations/`**: escala cruda `SintiaSizes` (grilla de 4px) y vocabulario
    sin valores (`SintiaSize`, `SintiaStatus`).
  * **`tokens/`**: `SintiaSpacing`, `SintiaRadius`, `SintiaIconSize`,
    `SintiaBreakpoints`, `SintiaElevation`, `SintiaShadows`, `SintiaDuration` y
    el token de componente `SintiaNavDrawerMetrics`.
  * **`theme/`**: `SintiaTheme`, `SintiaThemeConfig` y `SintiaStatusColors`.
  * **`models/`**, **`atoms/`**, **`molecules/`**, **`organisms/`**,
    **`templates/`** y **`previews/`**.
* `analysis_options.yaml` estricto: `strict-casts`, `strict-inference`,
  `strict-raw-types`, `always_specify_types`, `require_trailing_commas`,
  `discarded_futures`, `directives_ordering`, entre otros. `flutter analyze`
  queda en cero issues, en el paquete y en la showcase.

### Agregado

* **Theming**
  * `SintiaTheme.light/dark(SintiaThemeConfig)` deriva todo el `ColorScheme`
    desde la marca (`ColorScheme.fromSeed`) y define los estilos de botones,
    campos, tarjetas, chips, app bar, diálogos, drawer, listas, tooltips,
    snackbars y menús desde los tokens.
  * `SintiaStatusColors` como `ThemeExtension` (`success`, `warning`, `info`),
    con defaults para claro y oscuro, sobreescribibles por la app.
  * `SintiaThemeConfig` inmutable, con `copyWith` y comparación por valor.
* **Átomos**: `SintiaChip`, `SintiaIconAction`, `SintiaLoader` (animación Lottie
  empaquetada) y `SintiaAvatar`.
* **Moléculas**: `SintiaBanner`, `SintiaEmptyState`, `SintiaListTile`,
  `SintiaConfirmDialog`, `SintiaCheckOption`, `SintiaOtpField`,
  `SintiaSuccessView` y `SintiaAppBarTitle`.
* **Organismos**: `SintiaNavigationDrawer` (menú lateral colapsable a rail de
  80px, con badges, divisores, ítems de pie y tooltips), `SintiaListSection` y
  `SintiaProfileHeader`.
* **Plantillas**: `SintiaPageTemplate`, `SintiaDetailPageTemplate` y
  `SintiaShellTemplate` (estructura maestra: drawer permanente y colapsable en
  escritorio, modal en móvil).
* **Modelos**: `SintiaNavItem`, `SintiaListItem` y `SintiaAppBarAction`.
* **Extensiones**: `context.statusColors`, `context.isDarkMode`,
  `context.surfaceColor`; y en `TextStyle` los colores `error` y `muted` más los
  pesos `regular`, `medium`, `semiBold` y `bold`.
* **Showcase** (`example/`): app navegable construida con la propia
  `SintiaShellTemplate`, con catálogo por categorías, páginas por componente,
  toggle claro/oscuro y pruebas de navegación. Corre en web, Android e iOS.
* **Tests**: 112 pruebas del paquete (theming, tokens, átomos, moléculas,
  organismos y plantillas) y 5 de la showcase.
* **Dependencia**: `lottie` para la animación empaquetada del loader.

### Cambiado

* Todas las clases usan el prefijo `Sintia`. `SintiaButton` pasó de molécula a
  átomo y `SintiaCard` de átomo a molécula, por composición.
* `SintiaButton`: nuevas variantes (`primary`, `secondary`, `outline`, `ghost`,
  `danger`) y tamaños (`SintiaSize`). `onPressed` es `FutureOr<void> Function()?`
  y acepta callbacks sincrónicos o asíncronos: si devuelve un `Future`, el botón
  gestiona su propio estado de carga. Además, `loading` permite controlarlo
  desde fuera.
* `SintiaTextField`: la decoración sale del `inputDecorationTheme` en lugar de 12
  overrides de borde; los campos de contraseña traen el botón de
  mostrar/ocultar. La etiqueta sigue mostrándose sobre el campo.
* `SintiaAppBar`: `leading` es un enum (`none`, `back`, `menu`); el botón de menú
  abre el drawer del `Scaffold` y se oculta si no hay drawer. `trailingActions`
  pasó a llamarse `actions`.
* `SintiaDialog`: el ícono es un `Widget` en lugar de una ruta de asset, gana el
  helper `show`, contenido desplazable y forma/elevación del tema.
* `SintiaText`: hereda `bodyMedium` cuando no se le pasa estilo, y acepta
  `softWrap` y `semanticsLabel`.
* Los espaciados y radios pasan a la grilla de 4px (`SintiaSpacing.medium` = 16)
  en lugar de la escala anterior (`SintiaSizes.size1` = 10).

### Eliminado

* **`AppColors`**: la paleta estática hardcodeada. Todo el color viene del tema
  (`context.colorScheme` + `context.statusColors`), que es lo que permite marca
  en runtime y modo oscuro real.
* **`SintiaSizes` anterior** (escala 10/20/30/50/80…) y `SintiaElevations`,
  reemplazados por la escala de 4px y `SintiaElevation`.
* **Fuentes empaquetadas** (`Montserrat`, `OpenSans`): el paquete es agnóstico a
  la fuente; ahora se registran en la app consumidora. Los `.ttf` quedaron en
  `example/assets/fonts/` como demostración.
* `foundation/colors.dart`, que estaba vacío y se exportaba.
* La familia de átomos y moléculas específicos de la app bar
  (`SintiaAppBarActionButton`, `SintiaAppBarBadgeButton`,
  `SintiaAppBarBackButton`, `SintiaAppBarTitle` como átomo,
  `SintiaAppBarLeading`, `SintiaAppBarTrailing`, `SintiaAppBarTitleSection`),
  reemplazada por `SintiaIconAction` + `SintiaAppBarTitle`.
* `SintiaAppBarAction.cart`: era específico de comercio. Se construye igual en
  una línea con el constructor normal.

### Migración desde 0.6.0

| Antes | Ahora |
|---|---|
| `import '.../tokens/colors.dart'` | `import 'package:sintia_design_system/sintia_design_system.dart'` |
| `SintiaThemeConfig(primaryColor:, secondaryColor:, primaryFont:, secondaryFont:)` | `SintiaThemeConfig(primary:, secondary:, headingFontFamily:, fontFamily:)` |
| `AppColors.statusDanger01` | `context.colorScheme.error` |
| `AppColors.statusSuccess01` | `context.statusColors.success` |
| `AppColors.statusWarning` | `context.statusColors.warning` |
| `AppColors.statusInfo` | `context.statusColors.info` |
| `AppColors.scale00` / `bgWhite` | `context.colorScheme.surface` |
| `AppColors.scale02` / `borderColor` | `context.colorScheme.outlineVariant` |
| `AppColors.scale06` | `context.colorScheme.onSurface` |
| `AppColors.statusDisabled` | lo resuelve el tema en cada componente |
| `SintiaSizes.size1` (10) | `SintiaSpacing.small` (8) o `SintiaSpacing.medium` (16) |
| `SintiaSizes.size2` (20) | `SintiaSpacing.large` (24) |
| `SintiaSizes.radius1` | `SintiaRadius.medium` / `SintiaRadius.borderMedium` |
| `SintiaShadows.s1/s2/s3` | `SintiaShadows.low/medium/high` |
| `SintiaElevations.s1…s6` | `SintiaElevation.low/medium/high/highest` |
| `SintiaAppBar(trailingActions:)` | `SintiaAppBar(actions:)` |
| `SintiaAppBar(leadingType: SintiaAppBarLeadingType.back)` | `SintiaAppBar(leading: SintiaAppBarLeading.back)` |
| `SintiaButton(variant: SintiaButtonVariant.destructive)` | `SintiaButton(variant: SintiaButtonVariant.danger)` |
| `SintiaButton(size: SintiaButtonSize.medium)` | `SintiaButton(size: SintiaSize.medium)` |
| `SintiaButton(leftIcon: Icon(...), rightIcon: Icon(...))` | `SintiaButton(icon: Icons..., trailingIcon: Icons...)` |
| `SintiaDialog(icon: 'assets/alert.png')` | `SintiaDialog(icon: Image.asset('assets/alert.png'))` |
| `SintiaText('Hola')` sin estilo (sin estilo aplicado) | `SintiaText('Hola')` (hereda `bodyMedium`) |

---

## 0.6.0

- Add `SintiaDialog` component for customizable dialog functionality in the
  Sintia design system

## 0.5.3

- Add onTap callback to `SintiaTextField` for enhanced interactivity

## 0.5.2

- Allow customization of label style in `SintiaTextField` for improved text
  presentation

## 0.5.1

- Export `SintiaTextField` component for improved text input functionality

## 0.5.0

- Add `SintiaTextField` component with customizable properties for enhanced text
  input experience

## 0.4.0

- Change trailingAction to trailingActions in `SintiaAppBar` for multiple action
  support

## 0.3.0

- Created `SintiaAppBar` with leading, title, and trailing components, including
  action buttons and badge support

## 0.2.0

- Streamline imports in components and changing iconData to widgets.

## 0.1.0

- Created `BuildContext` extension for responsive support.

## 0.0.1

- Initial version of Sintia Design System.
