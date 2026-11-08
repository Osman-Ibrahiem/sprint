import 'package:sprint/features/home/domain/entities/booking_mode.dart';
import 'package:sprint/features/home/domain/entities/facility_category.dart';
import 'package:sprint/features/home/domain/entities/user_affiliation.dart';

/// A bookable sports facility as shown on Home. Prices are whole EGP per hour.
class Facility {
  const Facility({
    required this.id,
    required this.name,
    required this.category,
    required this.bookingMode,
    required this.fullPrice,
    required this.discountedPrice,
  }) : assert(discountedPrice <= fullPrice, 'discount must not exceed full');

  final String id;
  final String name;
  final FacilityCategory category;
  final BookingMode bookingMode;
  final int fullPrice;
  final int discountedPrice;

  /// Price for [affiliation] (BR-07). Guests (`null`) and external visitors
  /// pay the full price; university-affiliated users get the discount.
  int priceFor(UserAffiliation? affiliation) =>
      affiliation == UserAffiliation.universityAffiliated
      ? discountedPrice
      : fullPrice;

  /// True when [affiliation] pays less than the full price.
  bool isDiscountedFor(UserAffiliation? affiliation) =>
      priceFor(affiliation) < fullPrice;
}
