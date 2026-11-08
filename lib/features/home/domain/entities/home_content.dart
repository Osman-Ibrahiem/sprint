import 'package:sprint/features/home/domain/entities/booker_profile.dart';
import 'package:sprint/features/home/domain/entities/facility.dart';
import 'package:sprint/features/home/domain/entities/upcoming_booking.dart';
import 'package:sprint/features/home/domain/entities/user_affiliation.dart';

/// Everything Home shows. [profile] is null for a guest.
class HomeContent {
  const HomeContent({
    required this.facilities,
    this.profile,
    this.upcomingBooking,
  });

  final List<Facility> facilities;
  final BookerProfile? profile;
  final UpcomingBooking? upcomingBooking;

  bool get isGuest => profile == null;
  UserAffiliation? get affiliation => profile?.affiliation;
}
