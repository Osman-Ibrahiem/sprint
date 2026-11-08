import 'package:flutter_test/flutter_test.dart';
import 'package:sprint/features/home/data/mock_home_repository.dart';
import 'package:sprint/features/home/domain/entities/booker_profile.dart';
import 'package:sprint/features/home/domain/entities/booking_mode.dart';
import 'package:sprint/features/home/domain/entities/facility.dart';
import 'package:sprint/features/home/domain/entities/facility_category.dart';
import 'package:sprint/features/home/domain/entities/home_content.dart';
import 'package:sprint/features/home/domain/entities/user_affiliation.dart';
import 'package:sprint/features/home/domain/home_session.dart';
import 'package:sprint/features/home/domain/repositories/home_repository.dart';
import 'package:sprint/features/home/domain/usecases/get_home_content.dart';

const _facility = Facility(
  id: 'f',
  name: 'n',
  category: FacilityCategory.gym,
  bookingMode: BookingMode.free,
  fullPrice: 400,
  discountedPrice: 200,
);

class _LeakyRepository implements HomeRepository {
  @override
  Future<HomeContent> load(HomeSession session) async => const HomeContent(
    facilities: [_facility],
    profile: BookerProfile(
      displayName: 'x',
      affiliation: UserAffiliation.universityAffiliated,
    ),
  );
}

void main() {
  group('Facility.priceFor (BR-07)', () {
    test('guest pays full price', () {
      expect(_facility.priceFor(null), 400);
      expect(_facility.isDiscountedFor(null), isFalse);
    });
    test('external pays full price', () {
      expect(_facility.priceFor(UserAffiliation.external), 400);
    });
    test('university-affiliated pays discounted price', () {
      expect(_facility.priceFor(UserAffiliation.universityAffiliated), 200);
      expect(
        _facility.isDiscountedFor(UserAffiliation.universityAffiliated),
        isTrue,
      );
    });
  });

  group('HomeSession.parse', () {
    test(
      'booker',
      () => expect(HomeSession.parse('booker'), HomeSession.booker),
    );
    test('null and unknown fall back to guest', () {
      expect(HomeSession.parse(null), HomeSession.guest);
      expect(HomeSession.parse('admin'), HomeSession.guest);
    });
  });

  group('GetHomeContent', () {
    const repo = MockHomeRepository(latency: Duration.zero);

    test('guest gets facilities only', () async {
      final c = await const GetHomeContent(repo)(HomeSession.guest);
      expect(c.isGuest, isTrue);
      expect(c.upcomingBooking, isNull);
      expect(c.facilities, isNotEmpty);
    });

    test('booker gets profile and upcoming booking', () async {
      final c = await const GetHomeContent(repo)(HomeSession.booker);
      expect(c.isGuest, isFalse);
      expect(c.affiliation, UserAffiliation.universityAffiliated);
      expect(c.upcomingBooking, isNotNull);
    });

    test('booker without upcoming booking', () async {
      const r = MockHomeRepository(
        latency: Duration.zero,
        hasUpcomingBooking: false,
      );
      final c = await const GetHomeContent(r)(HomeSession.booker);
      expect(c.upcomingBooking, isNull);
    });

    test('guest never receives personal data from a repository', () async {
      final c = await GetHomeContent(_LeakyRepository())(HomeSession.guest);
      expect(c.isGuest, isTrue);
    });

    test('mock offers both booking modes (BR-04)', () {
      final modes = MockHomeRepository.facilities
          .map((f) => f.bookingMode)
          .toSet();
      expect(modes, {BookingMode.free, BookingMode.coached});
    });
  });
}
