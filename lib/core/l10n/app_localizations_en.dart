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
}
