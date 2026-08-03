/// Sistema de diseño de Sintia para Flutter, organizado con **Atomic
/// Design**.
///
/// El consumidor controla la identidad visual (colores de marca, fuentes y
/// colores de estado) vía `SintiaThemeConfig`; el sistema aporta la
/// consistencia: tokens, theming y componentes.
///
/// La base es un pipeline de capas
/// `foundations → tokens → theme → componentes`:
///
/// * **foundations**: escala cruda de valores (`SintiaSizes`) y vocabulario
///   del sistema sin valores (`SintiaSize`, `SintiaStatus`).
/// * **tokens**: dan misión a los valores crudos (`SintiaSpacing.medium`,
///   `SintiaRadius.small`), sin semántica de componente.
/// * **theme**: mapea tokens + marca a un `ThemeData`, la única fuente de
///   color y tipografía del sistema.
/// * **componentes**: átomos, moléculas, organismos y plantillas. Nunca
///   hardcodean colores: todo llega del tema vía `context.colorScheme`,
///   `context.textTheme` y `context.statusColors`.
library;

export 'src/atoms/sintia_avatar.dart';
export 'src/atoms/sintia_button.dart';
export 'src/atoms/sintia_chip.dart';
export 'src/atoms/sintia_icon_action.dart';
export 'src/atoms/sintia_loader.dart';
export 'src/atoms/sintia_text.dart';
export 'src/atoms/sintia_text_field.dart';
export 'src/foundations/sintia_size.dart';
export 'src/foundations/sintia_sizes.dart';
export 'src/foundations/sintia_status.dart';
export 'src/models/sintia_app_bar_action.dart';
export 'src/models/sintia_list_item.dart';
export 'src/models/sintia_nav_item.dart';
export 'src/models/sintia_segment.dart';
export 'src/molecules/sintia_app_bar_title.dart';
export 'src/molecules/sintia_banner.dart';
export 'src/molecules/sintia_card.dart';
export 'src/molecules/sintia_check_option.dart';
export 'src/molecules/sintia_confirm_dialog.dart';
export 'src/molecules/sintia_empty_state.dart';
export 'src/molecules/sintia_list_tile.dart';
export 'src/molecules/sintia_nav_drawer_header.dart';
export 'src/molecules/sintia_nav_drawer_item.dart';
export 'src/molecules/sintia_otp_field.dart';
export 'src/molecules/sintia_segmented_control.dart';
export 'src/molecules/sintia_success_view.dart';
export 'src/organisms/sintia_app_bar.dart';
export 'src/organisms/sintia_dialog.dart';
export 'src/organisms/sintia_list_section.dart';
export 'src/organisms/sintia_navigation_drawer.dart';
export 'src/organisms/sintia_profile_header.dart';
export 'src/previews/sintia_preview.dart';
export 'src/templates/sintia_detail_page_template.dart';
export 'src/templates/sintia_page_template.dart';
export 'src/templates/sintia_shell_template.dart';
export 'src/theme/extensions/sintia_responsive_context_extension.dart';
export 'src/theme/extensions/sintia_text_style_extension.dart';
export 'src/theme/extensions/sintia_theme_context_extension.dart';
export 'src/theme/sintia_status_colors.dart';
export 'src/theme/sintia_theme.dart';
export 'src/theme/sintia_theme_config.dart';
export 'src/tokens/sintia_breakpoints.dart';
export 'src/tokens/sintia_duration.dart';
export 'src/tokens/sintia_elevation.dart';
export 'src/tokens/sintia_icon_size.dart';
export 'src/tokens/sintia_nav_drawer_metrics.dart';
export 'src/tokens/sintia_radius.dart';
export 'src/tokens/sintia_shadows.dart';
export 'src/tokens/sintia_spacing.dart';
