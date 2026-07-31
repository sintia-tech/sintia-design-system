import 'package:flutter/material.dart';

import '../atoms/sintia_text.dart';
import '../models/sintia_nav_item.dart';
import '../theme/extensions/sintia_theme_context_extension.dart';
import '../tokens/sintia_duration.dart';
import '../tokens/sintia_icon_size.dart';
import '../tokens/sintia_nav_drawer_metrics.dart';
import '../tokens/sintia_radius.dart';
import '../tokens/sintia_spacing.dart';

/// Ítem de navegación del [SintiaNavigationDrawer].
///
/// Traduce un [SintiaNavItem] a interfaz: ícono con badge opcional,
/// etiqueta que se desvanece al colapsar, estado seleccionado con el color
/// de marca y tooltip cuando el drawer está en modo rail.
///
/// El contenido se maqueta siempre con el ancho expandido y se recorta al
/// colapsar, para que no haya overflow durante la animación de ancho.
class SintiaNavDrawerItem extends StatelessWidget {
  const SintiaNavDrawerItem({
    required this.item,
    required this.selected,
    required this.collapsed,
    required this.onSelected,
    super.key,
  });

  final SintiaNavItem item;
  final bool selected;
  final bool collapsed;
  final ValueChanged<SintiaNavItem> onSelected;

  @override
  Widget build(BuildContext context) {
    final Color foreground = selected
        ? context.colorScheme.onPrimary
        : context.colorScheme.onSurfaceVariant;

    final Widget tile = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SintiaNavDrawerMetrics.itemMargin,
        vertical: SintiaSpacing.extraExtraSmall,
      ),
      child: Material(
        color: selected ? context.colorScheme.primary : Colors.transparent,
        borderRadius: SintiaRadius.borderMedium,
        clipBehavior: Clip.antiAlias,
        animationDuration: SintiaDuration.normal,
        child: InkWell(
          onTap: () => onSelected(item),
          child: SizedBox(
            height: SintiaNavDrawerMetrics.itemHeight,
            child: OverflowBox(
              alignment: Alignment.centerLeft,
              minWidth: SintiaNavDrawerMetrics.itemContentWidth,
              maxWidth: SintiaNavDrawerMetrics.itemContentWidth,
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: SintiaNavDrawerMetrics.iconLeadingSpace,
                  ),
                  _ItemIcon(item: item, selected: selected, color: foreground),
                  const SizedBox(
                    width: SintiaNavDrawerMetrics.iconLabelGap,
                  ),
                  Expanded(
                    child: AnimatedOpacity(
                      duration: SintiaDuration.normal,
                      curve: Curves.easeInOut,
                      opacity: collapsed ? 0 : 1,
                      child: SintiaText(
                        item.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: foreground,
                          fontWeight: selected
                              ? FontWeight.w600
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: SintiaSpacing.small),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (item.dividerAbove)
          const Divider(
            indent: SintiaSpacing.medium,
            endIndent: SintiaSpacing.medium,
          ),
        Semantics(
          selected: selected,
          child: collapsed
              ? Tooltip(
                  message: item.label,
                  preferBelow: false,
                  child: tile,
                )
              : tile,
        ),
      ],
    );
  }
}

/// Ícono del ítem, con badge cuando corresponde.
class _ItemIcon extends StatelessWidget {
  const _ItemIcon({
    required this.item,
    required this.selected,
    required this.color,
  });

  final SintiaNavItem item;
  final bool selected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final int? badgeCount = item.badgeCount;
    final bool hasCount = badgeCount != null && badgeCount > 0;
    return Badge(
      isLabelVisible: hasCount || item.showBadge,
      label: hasCount ? Text('$badgeCount') : null,
      child: Icon(
        item.iconFor(selected: selected),
        size: SintiaIconSize.medium,
        color: color,
      ),
    );
  }
}
