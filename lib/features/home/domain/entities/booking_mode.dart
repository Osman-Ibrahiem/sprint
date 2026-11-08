/// How a facility is booked (BR-04). The two flows are never merged.
enum BookingMode {
  /// Pick a day, then an available hour range.
  free,

  /// Pick a trainer first, then one of the trainer's 1-hour slots.
  coached,
}
