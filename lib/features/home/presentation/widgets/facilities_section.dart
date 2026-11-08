import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/router/app_routes.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/features/home/domain/entities/facility.dart';
import 'package:sprint/features/home/domain/entities/user_affiliation.dart';
import 'package:sprint/features/home/presentation/home_layout.dart';
import 'package:sprint/features/home/presentation/widgets/facility_card.dart';

/// Section title (sliver).
class FacilitiesTitle extends StatelessWidget {
  const FacilitiesTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final type = AdaptiveTypography.of(PaneScope.of(context));
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Text(
        AppLocalizations.of(context)!.homeFacilitiesTitle,
        style: type.h3.copyWith(color: AppColors.textPrimary),
      ),
    );
  }
}

/// Facility grid (sliver). Columns follow the pane's size class. Booking is
/// out of scope, so a tap sends a guest to login and does nothing yet for a
/// signed-in Booker.
class FacilitiesGrid extends StatelessWidget {
  const FacilitiesGrid({
    required this.facilities,
    required this.affiliation,
    required this.isGuest,
    super.key,
  });

  final List<Facility> facilities;
  final UserAffiliation? affiliation;
  final bool isGuest;

  @override
  Widget build(BuildContext context) {
    final columns = HomeLayout.columnsFor(PaneScope.of(context));
    final extent = HomeLayout.cardExtent(MediaQuery.textScalerOf(context));

    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        mainAxisSpacing: HomeLayout.gridGap,
        crossAxisSpacing: HomeLayout.gridGap,
        mainAxisExtent: extent,
      ),
      itemCount: facilities.length,
      itemBuilder: (context, index) => FacilityCard(
        facility: facilities[index],
        affiliation: affiliation,
        onTap: () {
          if (isGuest) context.go(AppRoutes.login);
        },
      ),
    );
  }
}
