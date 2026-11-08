/// The Booker's next confirmed booking.
class UpcomingBooking {
  const UpcomingBooking({
    required this.id,
    required this.facilityName,
    required this.startTime,
    required this.durationHours,
  });

  final String id;
  final String facilityName;
  final DateTime startTime;
  final int durationHours;
}
