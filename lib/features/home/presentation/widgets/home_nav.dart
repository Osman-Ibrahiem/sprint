import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_tokens.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/features/home/presentation/providers/home_providers.dart';

class _Item {
  const _Item(this.destination, this.icon, this.selectedIcon);

  final HomeDestination destination;
  final IconData icon;
  final IconData selectedIcon;
}

const List<_Item> _items = [
  _Item(HomeDestination.home, Icons.home_outlined, Icons.home_rounded),
  _Item(
    HomeDestination.bookings,
    Icons.event_note_outlined,
    Icons.event_note_rounded,
  ),
  _Item(
    HomeDestination.notifications,
    Icons.notifications_outlined,
    Icons.notifications_rounded,
  ),
  _Item(
    HomeDestination.profile,
    Icons.person_outline_rounded,
    Icons.person_rounded,
  ),
];

String _label(AppLocalizations l10n, HomeDestination d) => switch (d) {
  HomeDestination.home => l10n.homeNavHome,
  HomeDestination.bookings => l10n.homeNavBookings,
  HomeDestination.notifications => l10n.homeNavNotifications,
  HomeDestination.profile => l10n.homeNavProfile,
};

/// Bottom bar (compact).
class HomeBottomBar extends StatelessWidget {
  const HomeBottomBar({
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final HomeDestination selected;
  final ValueChanged<HomeDestination> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return NavigationBar(
      backgroundColor: AppColors.bgSurface,
      indicatorColor: AppColors.accentAlpha40,
      selectedIndex: selected.index,
      onDestinationSelected: (i) => onSelect(_items[i].destination),
      destinations: [
        for (final item in _items)
          NavigationDestination(
            icon: Icon(item.icon, color: AppColors.textSecondary),
            selectedIcon: Icon(item.selectedIcon, color: AppColors.accent),
            label: _label(l10n, item.destination),
          ),
      ],
    );
  }
}

/// Side rail (medium and up). [navType] `drawer` extends it with labels.
class HomeSideRail extends StatelessWidget {
  const HomeSideRail({
    required this.selected,
    required this.onSelect,
    required this.navType,
    super.key,
  });

  final HomeDestination selected;
  final ValueChanged<HomeDestination> onSelect;
  final NavType navType;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final extended = navType == NavType.drawer;
    return NavigationRail(
      backgroundColor: AppColors.bgSurface,
      indicatorColor: AppColors.accentAlpha40,
      extended: extended,
      labelType: extended
          ? NavigationRailLabelType.none
          : NavigationRailLabelType.all,
      selectedIndex: selected.index,
      onDestinationSelected: (i) => onSelect(_items[i].destination),
      destinations: [
        for (final item in _items)
          NavigationRailDestination(
            icon: Icon(item.icon, color: AppColors.textSecondary),
            selectedIcon: Icon(item.selectedIcon, color: AppColors.accent),
            label: Text(_label(l10n, item.destination)),
          ),
      ],
    );
  }
}
