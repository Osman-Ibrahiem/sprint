import 'package:flutter/material.dart';
import 'package:sprint/core/l10n/app_localizations.dart';
import 'package:sprint/features/home/domain/entities/booking_mode.dart';
import 'package:sprint/features/home/domain/entities/facility_category.dart';

/// Presentation mappings for domain enums.
extension FacilityCategoryUi on FacilityCategory {
  IconData get icon => switch (this) {
    FacilityCategory.pool => Icons.pool_rounded,
    FacilityCategory.gym => Icons.fitness_center_rounded,
    FacilityCategory.footballPitch => Icons.sports_soccer_rounded,
    FacilityCategory.basketballCourt => Icons.sports_basketball_rounded,
  };

  String label(AppLocalizations l10n) => switch (this) {
    FacilityCategory.pool => l10n.homeCategoryPool,
    FacilityCategory.gym => l10n.homeCategoryGym,
    FacilityCategory.footballPitch => l10n.homeCategoryFootballPitch,
    FacilityCategory.basketballCourt => l10n.homeCategoryBasketballCourt,
  };
}

extension BookingModeUi on BookingMode {
  String label(AppLocalizations l10n) => switch (this) {
    BookingMode.free => l10n.homeModeFree,
    BookingMode.coached => l10n.homeModeCoached,
  };
}
