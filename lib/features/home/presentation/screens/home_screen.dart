import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sprint/core/adaptive/adaptive_tokens.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/adaptive/size_class.dart';
import 'package:sprint/features/home/domain/entities/home_content.dart';
import 'package:sprint/features/home/domain/home_session.dart';
import 'package:sprint/features/home/presentation/home_layout.dart';
import 'package:sprint/features/home/presentation/providers/home_providers.dart';
import 'package:sprint/features/home/presentation/widgets/facilities_section.dart';
import 'package:sprint/features/home/presentation/widgets/home_greeting.dart';
import 'package:sprint/features/home/presentation/widgets/home_hero.dart';
import 'package:sprint/features/home/presentation/widgets/home_nav.dart';
import 'package:sprint/features/home/presentation/widgets/home_status_views.dart';
import 'package:sprint/features/home/presentation/widgets/home_top_bar.dart';
import 'package:sprint/features/home/presentation/widgets/upcoming_booking_card.dart';

/// Home for [session]. Guest: limited, no navigation. Booker: personalised,
/// with adaptive navigation (bottom bar / rail / extended rail).
class HomeScreen extends ConsumerWidget {
  const HomeScreen({required this.session, super.key});

  final HomeSession session;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(homeContentProvider(session));
    final tokens = AdaptiveTokens.of(SizeClass.ofWindow(context));

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: content.when(
        loading: () => const SafeArea(child: HomeLoadingView()),
        error: (_, _) => SafeArea(
          child: PaneScope(
            child: HomeErrorView(
              onRetry: () => ref.invalidate(homeContentProvider(session)),
            ),
          ),
        ),
        data: (data) => data.isGuest
            ? SafeArea(
                child: PaneScope(child: _GuestHome(content: data)),
              )
            : _BookerShell(content: data, tokens: tokens),
      ),
    );
  }
}

class _GuestHome extends StatelessWidget {
  const _GuestHome({required this.content});

  final HomeContent content;

  @override
  Widget build(BuildContext context) {
    return _HomeScroll(
      topBar: const HomeTopBar(),
      content: content,
      header: const HomeHero(),
    );
  }
}

class _BookerShell extends ConsumerWidget {
  const _BookerShell({required this.content, required this.tokens});

  final HomeContent content;
  final AdaptiveTokens tokens;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(homeNavProvider);
    final select = ref.read(homeNavProvider.notifier).select;
    final body = selected == HomeDestination.home
        ? _HomeScroll(
            content: content,
            header: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                HomeGreeting(name: content.profile!.displayName),
                const SizedBox(height: HomeLayout.gridGap),
                UpcomingBookingCard(booking: content.upcomingBooking),
              ],
            ),
          )
        : const ComingSoonView();

    final pane = SafeArea(
      bottom: tokens.navType != NavType.bottomBar,
      child: PaneScope(child: body),
    );

    if (tokens.navType == NavType.bottomBar) {
      return Column(
        children: [
          Expanded(child: pane),
          HomeBottomBar(selected: selected, onSelect: select),
        ],
      );
    }
    return Row(
      children: [
        HomeSideRail(
          selected: selected,
          onSelect: select,
          navType: tokens.navType,
        ),
        Expanded(child: pane),
      ],
    );
  }
}

/// Scrolling page: optional fixed [topBar], a [header] block, then the
/// facility section. Content is centered and capped at the class's max width.
class _HomeScroll extends StatelessWidget {
  const _HomeScroll({required this.content, required this.header, this.topBar});

  final HomeContent content;
  final Widget header;
  final Widget? topBar;

  @override
  Widget build(BuildContext context) {
    final tokens = PaneScope.tokensOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final side = math.max(
          tokens.margin,
          (constraints.maxWidth - tokens.maxContentWidth) / 2,
        );
        final padding = EdgeInsets.symmetric(horizontal: side);
        return Column(
          children: [
            if (topBar != null) Padding(padding: padding, child: topBar),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: padding.copyWith(
                      top: HomeLayout.gridGap,
                      bottom: HomeLayout.sectionGap,
                    ),
                    sliver: SliverMainAxisGroup(
                      slivers: [
                        SliverToBoxAdapter(child: header),
                        const SliverToBoxAdapter(
                          child: SizedBox(height: HomeLayout.sectionGap),
                        ),
                        const SliverToBoxAdapter(child: FacilitiesTitle()),
                        FacilitiesGrid(
                          facilities: content.facilities,
                          affiliation: content.affiliation,
                          isGuest: content.isGuest,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
