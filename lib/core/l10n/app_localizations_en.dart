// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Sprint';

  @override
  String get errorPageTitle => 'Error';

  @override
  String get errorPageMessage => 'Page not found';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get splashTagline => 'Book hassle-free';

  @override
  String get splashUniversity => 'Tanta University';

  @override
  String get splashFaculty => 'Faculty of Physical Education';

  @override
  String get loginTitle => 'Welcome to Sprint';

  @override
  String get loginSubtitle => 'Start booking now';

  @override
  String get loginIdentifierHint => 'Email or phone number';

  @override
  String get loginPasswordHint => 'Password';

  @override
  String get loginButton => 'Sign in';

  @override
  String get loginIdentifierError => 'Please enter your email or phone';

  @override
  String get loginPasswordError => 'Please enter your password';

  @override
  String get loginIdentifierSemantic => 'Email or phone number field';

  @override
  String get loginPasswordSemantic => 'Password field';

  @override
  String get loginButtonSemantic => 'Sign in button';

  @override
  String get loginPasswordShow => 'Show password';

  @override
  String get loginPasswordHide => 'Hide password';

  @override
  String get homeGuestSignIn => 'Sign in';

  @override
  String get homeGuestHeroTitle => 'Book your court without the crowd';

  @override
  String get homeGuestHeroBody =>
      'Browse facilities and prices, then sign in to book.';

  @override
  String get homeGuestHeroCta => 'Sign in and book';

  @override
  String homeGreeting(String name) {
    return 'Hi, $name';
  }

  @override
  String get homeGreetingSubtitle => 'What are you playing today?';

  @override
  String get homeUpcomingTitle => 'Your next booking';

  @override
  String homeUpcomingWhen(DateTime date, DateTime time) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.MMMEd(localeName);
    final String dateString = dateDateFormat.format(date);
    final intl.DateFormat timeDateFormat = intl.DateFormat.jm(localeName);
    final String timeString = timeDateFormat.format(time);

    return '$dateString · $timeString';
  }

  @override
  String homeUpcomingDuration(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '1 hour',
    );
    return '$_temp0';
  }

  @override
  String get homeUpcomingEmptyTitle => 'No upcoming bookings';

  @override
  String get homeUpcomingEmptyBody =>
      'Pick a facility below and book your first session.';

  @override
  String get homeFacilitiesTitle => 'Facilities';

  @override
  String homePricePerHour(int price) {
    return '$price EGP / hour';
  }

  @override
  String homePriceOriginal(int price) {
    return '$price EGP';
  }

  @override
  String get homeModeFree => 'Free booking';

  @override
  String get homeModeCoached => 'With trainer';

  @override
  String get homeCategoryPool => 'Swimming pool';

  @override
  String get homeCategoryGym => 'Gym';

  @override
  String get homeCategoryFootballPitch => 'Football pitch';

  @override
  String get homeCategoryBasketballCourt => 'Basketball court';

  @override
  String homeFacilitySemantic(String name, String mode, String price) {
    return '$name, $mode, $price';
  }

  @override
  String get homeNavHome => 'Home';

  @override
  String get homeNavBookings => 'My bookings';

  @override
  String get homeNavNotifications => 'Notifications';

  @override
  String get homeNavProfile => 'Profile';

  @override
  String get homeComingSoon => 'Coming soon';

  @override
  String get homeErrorMessage => 'Something went wrong loading this page';

  @override
  String get homeRetry => 'Try again';
}
