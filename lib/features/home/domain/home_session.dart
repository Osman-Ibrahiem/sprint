/// Which Home the user sees. Mock until real auth exists.
enum HomeSession {
  guest,
  booker;

  /// Parses the route query value; anything unknown is [guest].
  static HomeSession parse(String? value) => value == 'booker' ? booker : guest;
}
