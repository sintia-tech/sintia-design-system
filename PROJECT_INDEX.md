# Project Index

> Inventario de recursos **compartidos y reutilizables** del proyecto.
> Lo leen `/plan` y `/build` antes de implementar para no duplicar lo que ya existe.
>
> Agregá recursos con el comando `/index-add <ruta>` o editando a mano.
> Registrá solo lo **compartido entre features**; no registres componentes privados
> (`_Nombre`) ni específicos de una sola feature.

Este proyecto **es** el sistema de diseño: todo lo que está en `lib/src/` se
expone por el barrel `lib/sintia_design_system.dart` y está pensado para
reutilizarse en cualquier app de Sintia.

---

## Componentes / Widgets compartidos

UI reutilizable entre features.

| Nombre | Archivo | Descripción |
|---|---|---|
| `SintiaText` | `lib/src/atoms/sintia_text.dart` | Texto que hereda `bodyMedium` si no recibe estilo |
| `SintiaButton` | `lib/src/atoms/sintia_button.dart` | Botón con 5 variantes, 3 tamaños y carga automática si `onPressed` es asíncrono |
| `SintiaTextField` | `lib/src/atoms/sintia_text_field.dart` | Campo de texto con etiqueta externa, ayuda, error y toggle de contraseña |
| `SintiaChip` | `lib/src/atoms/sintia_chip.dart` | Etiqueta, chip de estado (`SintiaStatus`) o filtro seleccionable |
| `SintiaIconAction` | `lib/src/atoms/sintia_icon_action.dart` | Botón de ícono compacto con badge opcional |
| `SintiaLoader` | `lib/src/atoms/sintia_loader.dart` | Indicador de carga Lottie empaquetado en el paquete |
| `SintiaAvatar` | `lib/src/atoms/sintia_avatar.dart` | Avatar con imagen o iniciales, en tres tamaños |
| `SintiaCard` | `lib/src/molecules/sintia_card.dart` | Superficie con padding, borde y tap opcionales |
| `SintiaBanner` | `lib/src/molecules/sintia_banner.dart` | Mensaje contextual por estado, con cierre y acción |
| `SintiaEmptyState` | `lib/src/molecules/sintia_empty_state.dart` | Estado vacío o de error con acción |
| `SintiaListTile` | `lib/src/molecules/sintia_list_tile.dart` | Fila con avatar/ícono, textos y etiqueta o trailing |
| `SintiaConfirmDialog` | `lib/src/molecules/sintia_confirm_dialog.dart` | Confirmación con helper `show` que resuelve `bool?` |
| `SintiaCheckOption` | `lib/src/molecules/sintia_check_option.dart` | Aceptación con enlace legal |
| `SintiaOtpField` | `lib/src/molecules/sintia_otp_field.dart` | Código OTP con casillas y foco automático |
| `SintiaSuccessView` | `lib/src/molecules/sintia_success_view.dart` | Cierre de flujo exitoso con acción principal |
| `SintiaAppBarTitle` | `lib/src/molecules/sintia_app_bar_title.dart` | Título con prefijo/sufijo, táctil opcional |
| `SintiaNavDrawerHeader` | `lib/src/molecules/sintia_nav_drawer_header.dart` | Encabezado de marca del drawer (logo ↔ isotipo) |
| `SintiaNavDrawerItem` | `lib/src/molecules/sintia_nav_drawer_item.dart` | Ítem del drawer con badge, divisor y tooltip |
| `SintiaAppBar` | `lib/src/organisms/sintia_app_bar.dart` | App bar con leading `none`/`back`/`menu` y acciones |
| `SintiaNavigationDrawer` | `lib/src/organisms/sintia_navigation_drawer.dart` | Menú lateral colapsable a rail de 80px |
| `SintiaDialog` | `lib/src/organisms/sintia_dialog.dart` | Diálogo compuesto por ranuras, con helper `show` |
| `SintiaListSection` | `lib/src/organisms/sintia_list_section.dart` | Sección con encabezado, acción y elementos |
| `SintiaProfileHeader` | `lib/src/organisms/sintia_profile_header.dart` | Cabecera de entidad con avatar, etiquetas y acciones |
| `SintiaPageTemplate` | `lib/src/templates/sintia_page_template.dart` | Plantilla de pantalla: app bar + secciones + footer |
| `SintiaDetailPageTemplate` | `lib/src/templates/sintia_detail_page_template.dart` | Plantilla de detalle con encabezado fijo |
| `SintiaShellTemplate` | `lib/src/templates/sintia_shell_template.dart` | Estructura maestra con drawer, responsiva |

---

## Estado compartido (hooks / notifiers / providers)

Lógica de estado reutilizable entre features.

| Nombre | Archivo | Descripción |
|---|---|---|
| — | — | El sistema de diseño no gestiona estado: los componentes son puros y notifican por callbacks |

---

## Servicios

Servicios de infraestructura/core reutilizables (HTTP, storage, etc.).

| Nombre | Archivo | Descripción |
|---|---|---|
| — | — | Aún no hay registrados |

---

## Helpers / Utilidades

Funciones puras y utilidades compartidas.

| Nombre | Archivo | Descripción |
|---|---|---|
| `SintiaPreview` | `lib/src/previews/sintia_preview.dart` | Anotación de Widget Preview con el tema del sistema aplicado |

---

## Extensiones

Extension methods compartidos.

| Nombre | Archivo | Descripción |
|---|---|---|
| `SintiaThemeContextExtension` | `lib/src/theme/extensions/sintia_theme_context_extension.dart` | `context.theme`, `colorScheme`, `textTheme`, `statusColors`, `isDarkMode`, colores de atajo |
| `SintiaResponsiveContextExtension` | `lib/src/theme/extensions/sintia_responsive_context_extension.dart` | `context.isMobile/isTablet/isDesktop`, tamaños de pantalla y `responsiveValue` |
| `SintiaTextStyleExtension` | `lib/src/theme/extensions/sintia_text_style_extension.dart` | Colores (`primary`, `secondary`, `error`, `muted`, `withColor`) y pesos (`regular`…`bold`) |

---

## Tokens, foundations y theming

Base del sistema: valores, tokens y construcción del tema.

| Nombre | Archivo | Descripción |
|---|---|---|
| `SintiaSizes` | `lib/src/foundations/sintia_sizes.dart` | Escala cruda en píxeles lógicos (grilla de 4px) |
| `SintiaSize` | `lib/src/foundations/sintia_size.dart` | Vocabulario de tamaños (`small`, `medium`, `large`) |
| `SintiaStatus` | `lib/src/foundations/sintia_status.dart` | Vocabulario de estados (`info`, `success`, `warning`, `error`) |
| `SintiaSpacing` | `lib/src/tokens/sintia_spacing.dart` | Escala de espaciado |
| `SintiaRadius` | `lib/src/tokens/sintia_radius.dart` | Radios de borde, como `double` y como `BorderRadius` |
| `SintiaIconSize` | `lib/src/tokens/sintia_icon_size.dart` | Tamaños de ícono |
| `SintiaBreakpoints` | `lib/src/tokens/sintia_breakpoints.dart` | Puntos de quiebre responsivos |
| `SintiaElevation` | `lib/src/tokens/sintia_elevation.dart` | Elevación Material |
| `SintiaShadows` | `lib/src/tokens/sintia_shadows.dart` | Sombras para `BoxDecoration` |
| `SintiaDuration` | `lib/src/tokens/sintia_duration.dart` | Duraciones de animación |
| `SintiaNavDrawerMetrics` | `lib/src/tokens/sintia_nav_drawer_metrics.dart` | Token de componente: medidas del navigation drawer |
| `SintiaTheme` | `lib/src/theme/sintia_theme.dart` | Construye el `ThemeData` claro y oscuro del sistema |
| `SintiaThemeConfig` | `lib/src/theme/sintia_theme_config.dart` | Identidad visual que inyecta la app consumidora |
| `SintiaStatusColors` | `lib/src/theme/sintia_status_colors.dart` | `ThemeExtension` con `success`, `warning` e `info` |

---

## Modelos compartidos

Datos que las pantallas declaran para configurar componentes.

| Nombre | Archivo | Descripción |
|---|---|---|
| `SintiaNavItem` | `lib/src/models/sintia_nav_item.dart` | Ítem de navegación del drawer (label, íconos, ruta, badge, divisor) |
| `SintiaAppBarAction` | `lib/src/models/sintia_app_bar_action.dart` | Acción de la app bar (ícono, callback, badge, tooltip) |
| `SintiaListItem` | `lib/src/models/sintia_list_item.dart` | Elemento de `SintiaListSection` |
