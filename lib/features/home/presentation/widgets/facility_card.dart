import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/core/theme/app_typography.dart';
import 'package:sprint/features/home/domain/entities/facility.dart';
import 'package:sprint/features/home/domain/entities/user_affiliation.dart';
import 'package:sprint/features/home/presentation/home_layout.dart';
import 'package:sprint/features/home/presentation/widgets/facility_labels.dart';

/// One facility: art tile with mode badge, name, category and the price for
/// [affiliation] (null = guest, sees the full price).
class FacilityCard extends StatelessWidget {
  const FacilityCard({
    required this.facility,
    required this.affiliation,
    required this.onTap,
    super.key,
  });

  final Facility facility;
  final UserAffiliation? affiliation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final type = AdaptiveTypography.of(PaneScope.of(context));
    final price = facility.priceFor(affiliation);
    final discounted = facility.isDiscountedFor(affiliation);
    final priceText = l10n.homePricePerHour(price);

    return Semantics(
      button: true,
      excludeSemantics: true,
      label: l10n.homeFacilitySemantic(
        facility.name,
        facility.bookingMode.label(l10n),
        priceText,
      ),
      onTap: onTap,
      child: Material(
        color: AppColors.bgSurface,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.lgAll,
          side: BorderSide(color: AppColors.borderSubtle),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Art(facility: facility),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        facility.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: type.bodyLg.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: AppTypography.bold,
                        ),
                      ),
                      Text(
                        facility.category.label(l10n),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: type.sm.copyWith(color: AppColors.textSecondary),
                      ),
                      const Spacer(),
                      Wrap(
                        spacing: AppSpacing.sm,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            priceText,
                            style: type.body.copyWith(
                              color: AppColors.accent,
                              fontWeight: AppTypography.bold,
                            ),
                          ),
                          if (discounted)
                            Text(
                              l10n.homePriceOriginal(facility.fullPrice),
                              style: type.xs.copyWith(
                                color: AppColors.textMuted,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: AppColors.textMuted,
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Art extends StatelessWidget {
  const _Art({required this.facility});

  final Facility facility;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final type = AdaptiveTypography.of(PaneScope.of(context));

    return Container(
      height: HomeLayout.cardArtHeight,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [AppColors.bgElevated, AppColors.sprintGreen],
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              facility.category.icon,
              size: HomeLayout.cardArtIconSize,
              color: AppColors.accentAlpha60,
            ),
          ),
          PositionedDirectional(
            top: AppSpacing.sm,
            start: AppSpacing.sm,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: AppColors.overlay,
                borderRadius: AppRadius.pillAll,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.xs,
                ),
                child: Text(
                  facility.bookingMode.label(l10n),
                  style: type.micro.copyWith(color: AppColors.accent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
