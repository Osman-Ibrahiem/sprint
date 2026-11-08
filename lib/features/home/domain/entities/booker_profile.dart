import 'package:sprint/features/home/domain/entities/user_affiliation.dart';

/// The signed-in Booker as far as Home needs.
class BookerProfile {
  const BookerProfile({required this.displayName, required this.affiliation});

  final String displayName;
  final UserAffiliation affiliation;
}
