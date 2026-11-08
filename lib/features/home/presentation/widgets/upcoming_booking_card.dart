import 'package:flutter/material.dart';
import 'package:sprint/core/adaptive/adaptive_typography.dart';
import 'package:sprint/core/adaptive/pane_scope.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/core/theme/app_colors.dart';
import 'package:sprint/core/theme/app_radius.dart';
import 'package:sprint/core/theme/app_spacing.dart';
import 'package:sprint/core/theme/app_typography.dart';
import 'package:sprint/features/home/domain/entities/upcoming_booking.dart';

/// The Booker's next booking, or an empty state when [booking] is null.
class UpcomingBookingCard extends StatelessWidget {
  const UpcomingBookingCard({required this.booking, super.key});

  final UpcomingBooking? booking;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final type = AdaptiveTypography.of(PaneScope.of(context));
    final b = booking;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: AppRadius.lgAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: b == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.homeUpcomingEmptyTitle,
                    style: type.bodyLg.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                  Text(
                    l10n.homeUpcomingEmptyBody,
                    style: type.sm.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.homeUpcomingTitle,
                    style: type.xs.copyWith(color: AppColors.accent),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    b.facilityName,
                    style: type.bodyLg.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: AppTypography.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    '${l10n.homeUpcomingWhen(b.startTime, b.startTime)}'
                    ' · ${l10n.homeUpcomingDuration(b.durationHours)}',
                    style: type.sm.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
      ),
    );
  }
}
