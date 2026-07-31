import 'package:flutter/material.dart';

import '../pages/atoms/avatars_page.dart';
import '../pages/atoms/buttons_page.dart';
import '../pages/atoms/chips_page.dart';
import '../pages/atoms/icon_actions_page.dart';
import '../pages/atoms/loaders_page.dart';
import '../pages/atoms/text_fields_page.dart';
import '../pages/atoms/texts_page.dart';
import '../pages/examples/profile_page.dart';
import '../pages/examples/team_page.dart';
import '../pages/molecules/banners_page.dart';
import '../pages/molecules/cards_page.dart';
import '../pages/molecules/check_options_page.dart';
import '../pages/molecules/confirm_dialogs_page.dart';
import '../pages/molecules/empty_states_page.dart';
import '../pages/molecules/list_tiles_page.dart';
import '../pages/molecules/otp_fields_page.dart';
import '../pages/molecules/success_views_page.dart';
import '../pages/organisms/app_bars_page.dart';
import '../pages/organisms/dialogs_page.dart';
import '../pages/organisms/list_sections_page.dart';
import '../pages/organisms/navigation_drawers_page.dart';
import '../pages/organisms/profile_headers_page.dart';
import '../pages/templates/detail_templates_page.dart';
import '../pages/templates/page_templates_page.dart';
import '../pages/templates/shell_templates_page.dart';
import '../pages/tokens/colors_page.dart';
import '../pages/tokens/spacing_page.dart';
import '../pages/tokens/typography_page.dart';
import 'component_category.dart';
import 'component_entry.dart';

/// Catálogo completo del showcase, organizado por Atomic Design.
final List<ComponentCategory> catalog = <ComponentCategory>[
  ComponentCategory(
    route: '/tokens',
    title: 'Tokens',
    icon: Icons.palette_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(
        title: 'Colores',
        description: 'Roles del ColorScheme y colores de estado.',
        builder: (_) => const ColorsPage(),
      ),
      ComponentEntry(
        title: 'Tipografía',
        description: 'Escala de texto y pesos del sistema.',
        builder: (_) => const TypographyPage(),
      ),
      ComponentEntry(
        title: 'Espaciado, radios y sombras',
        description: 'Grilla de 4px, radios de borde y elevación.',
        builder: (_) => const SpacingPage(),
      ),
    ],
  ),
  ComponentCategory(
    route: '/atoms',
    title: 'Átomos',
    icon: Icons.circle_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(
        title: 'Textos',
        description: 'SintiaText y composición de estilos.',
        builder: (_) => const TextsPage(),
      ),
      ComponentEntry(
        title: 'Botones',
        description: 'Variantes, tamaños y carga automática.',
        builder: (_) => const ButtonsPage(),
      ),
      ComponentEntry(
        title: 'Campos de texto',
        description: 'Etiqueta, ayuda, error y contraseña.',
        builder: (_) => const TextFieldsPage(),
      ),
      ComponentEntry(
        title: 'Chips',
        description: 'Etiquetas, estados y filtros.',
        builder: (_) => const ChipsPage(),
      ),
      ComponentEntry(
        title: 'Acciones de ícono',
        description: 'Botones compactos con badge.',
        builder: (_) => const IconActionsPage(),
      ),
      ComponentEntry(
        title: 'Loaders',
        description: 'Indicador de carga con animación empaquetada.',
        builder: (_) => const LoadersPage(),
      ),
      ComponentEntry(
        title: 'Avatares',
        description: 'Imagen o iniciales en tres tamaños.',
        builder: (_) => const AvatarsPage(),
      ),
    ],
  ),
  ComponentCategory(
    route: '/molecules',
    title: 'Moléculas',
    icon: Icons.hub_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(
        title: 'Tarjetas',
        description: 'Superficie con padding y tap opcional.',
        builder: (_) => const CardsPage(),
      ),
      ComponentEntry(
        title: 'Banners',
        description: 'Mensajes contextuales por estado.',
        builder: (_) => const BannersPage(),
      ),
      ComponentEntry(
        title: 'Estados vacíos',
        description: 'Listas sin contenido y errores.',
        builder: (_) => const EmptyStatesPage(),
      ),
      ComponentEntry(
        title: 'Filas de lista',
        description: 'Avatar, textos y etiqueta.',
        builder: (_) => const ListTilesPage(),
      ),
      ComponentEntry(
        title: 'Diálogos de confirmación',
        description: 'Confirmar o cancelar, con variante destructiva.',
        builder: (_) => const ConfirmDialogsPage(),
      ),
      ComponentEntry(
        title: 'Opción de aceptación',
        description: 'Checkbox con enlace legal.',
        builder: (_) => const CheckOptionsPage(),
      ),
      ComponentEntry(
        title: 'Código OTP',
        description: 'Casillas con avance automático de foco.',
        builder: (_) => const OtpFieldsPage(),
      ),
      ComponentEntry(
        title: 'Vista de éxito',
        description: 'Confirmación con acción principal.',
        builder: (_) => const SuccessViewsPage(),
      ),
    ],
  ),
  ComponentCategory(
    route: '/organisms',
    title: 'Organismos',
    icon: Icons.widgets_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(
        title: 'App bars',
        description: 'Título táctil, volver, menú y acciones.',
        builder: (_) => const AppBarsPage(),
      ),
      ComponentEntry(
        title: 'Navigation drawer',
        description: 'Menú lateral colapsable y responsivo.',
        builder: (_) => const NavigationDrawersPage(),
      ),
      ComponentEntry(
        title: 'Diálogos',
        description: 'Diálogo compuesto por ranuras.',
        builder: (_) => const DialogsPage(),
      ),
      ComponentEntry(
        title: 'Secciones de lista',
        description: 'Encabezado, acción y elementos.',
        builder: (_) => const ListSectionsPage(),
      ),
      ComponentEntry(
        title: 'Encabezado de perfil',
        description: 'Avatar, datos, etiquetas y acciones.',
        builder: (_) => const ProfileHeadersPage(),
      ),
    ],
  ),
  ComponentCategory(
    route: '/templates',
    title: 'Plantillas',
    icon: Icons.dashboard_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(
        title: 'Plantilla de página',
        description: 'App bar, secciones y footer.',
        builder: (_) => const PageTemplatesPage(),
      ),
      ComponentEntry(
        title: 'Plantilla de detalle',
        description: 'Encabezado fijo y secciones desplazables.',
        builder: (_) => const DetailTemplatesPage(),
      ),
      ComponentEntry(
        title: 'Shell con drawer',
        description: 'Estructura maestra responsiva.',
        builder: (_) => const ShellTemplatesPage(),
      ),
    ],
  ),
  ComponentCategory(
    route: '/examples',
    title: 'Páginas',
    icon: Icons.article_outlined,
    entries: <ComponentEntry>[
      ComponentEntry(
        title: 'Página de equipo',
        description: 'Plantilla + organismos con datos reales.',
        builder: (_) => const TeamPage(),
        fullScreen: true,
      ),
      ComponentEntry(
        title: 'Página de perfil',
        description: 'Plantilla de detalle con datos reales.',
        builder: (_) => const ProfilePage(),
        fullScreen: true,
      ),
    ],
  ),
];
