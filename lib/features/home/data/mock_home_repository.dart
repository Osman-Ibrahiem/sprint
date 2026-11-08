import 'package:sprint/features/home/domain/entities/booker_profile.dart';
import 'package:sprint/features/home/domain/entities/booking_mode.dart';
import 'package:sprint/features/home/domain/entities/facility.dart';
import 'package:sprint/features/home/domain/entities/facility_category.dart';
import 'package:sprint/features/home/domain/entities/home_content.dart';
import 'package:sprint/features/home/domain/entities/upcoming_booking.dart';
import 'package:sprint/features/home/domain/entities/user_affiliation.dart';
import 'package:sprint/features/home/domain/home_session.dart';
import 'package:sprint/features/home/domain/repositories/home_repository.dart';

/// In-memory Home content. Names and prices are placeholders (unconfirmed,
/// see docs/project-context/product-and-ux.md) until the backend exists.
class MockHomeRepository implements HomeRepository {
  const MockHomeRepository({
    this.affiliation = UserAffiliation.universityAffiliated,
    this.hasUpcomingBooking = true,
    this.latency = const Duration(milliseconds: 400),
    this.now,
  });

  final UserAffiliation affiliation;
  final bool hasUpcomingBooking;
  final Duration latency;

  /// Clock override for tests.
  final DateTime Function()? now;

  static const List<Facility> facilities = [
    Facility(
      id: 'pool-olympic',
      name: 'حمام السباحة الأولمبي',
      category: FacilityCategory.pool,
      bookingMode: BookingMode.coached,
      fullPrice: 120,
      discountedPrice: 60,
    ),
    Facility(
      id: 'pitch-5',
      name: 'ملعب كرة القدم خماسي',
      category: FacilityCategory.footballPitch,
      bookingMode: BookingMode.free,
      fullPrice: 400,
      discountedPrice: 200,
    ),
    Facility(
      id: 'gym-main',
      name: 'الجيم الرئيسي',
      category: FacilityCategory.gym,
      bookingMode: BookingMode.free,
      fullPrice: 80,
      discountedPrice: 40,
    ),
    Facility(
      id: 'court-basket',
      name: 'ملعب كرة السلة',
      category: FacilityCategory.basketballCourt,
      bookingMode: BookingMode.free,
      fullPrice: 200,
      discountedPrice: 100,
    ),
  ];

  @override
  Future<HomeContent> load(HomeSession session) async {
    await Future<void>.delayed(latency);
    if (session == HomeSession.guest) {
      return const HomeContent(facilities: facilities);
    }
    final start = (now ?? DateTime.now)().add(const Duration(days: 1));
    return HomeContent(
      facilities: facilities,
      profile: BookerProfile(displayName: 'أحمد', affiliation: affiliation),
      upcomingBooking: hasUpcomingBooking
          ? UpcomingBooking(
              id: 'bk-1',
              facilityName: facilities.first.name,
              startTime: DateTime(start.year, start.month, start.day, 18),
              durationHours: 1,
            )
          : null,
    );
  }
}
