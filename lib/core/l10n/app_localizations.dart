import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// Application name displayed in the app bar
  ///
  /// In ar, this message translates to:
  /// **'سبرنت'**
  String get appName;

  /// Title shown on the 404/error screen
  ///
  /// In ar, this message translates to:
  /// **'خطأ'**
  String get errorPageTitle;

  /// Body text on the 404/error screen
  ///
  /// In ar, this message translates to:
  /// **'الصفحة غير موجودة'**
  String get errorPageMessage;

  /// Button label on error screen to navigate back to home
  ///
  /// In ar, this message translates to:
  /// **'العودة للرئيسية'**
  String get backToHome;

  /// Tagline shown on the splash screen below the app name
  ///
  /// In ar, this message translates to:
  /// **'احجز من غير زحمة'**
  String get splashTagline;

  /// University name shown in the splash institution badge
  ///
  /// In ar, this message translates to:
  /// **'جامعة طنطا'**
  String get splashUniversity;

  /// Faculty name shown in the splash institution badge
  ///
  /// In ar, this message translates to:
  /// **'كلية التربية الرياضية'**
  String get splashFaculty;

  /// Heading text on the login placeholder screen
  ///
  /// In ar, this message translates to:
  /// **'أهلاً بيك في سبرنت'**
  String get loginTitle;

  /// Subheading text on the login placeholder screen
  ///
  /// In ar, this message translates to:
  /// **'ابدأ حجزك دلوقتي'**
  String get loginSubtitle;

  /// Placeholder hint text for the identifier (email or phone) input field on the login screen
  ///
  /// In ar, this message translates to:
  /// **'الإيميل أو رقم الموبايل'**
  String get loginIdentifierHint;

  /// Placeholder hint text for the password input field on the login screen
  ///
  /// In ar, this message translates to:
  /// **'كلمة السر'**
  String get loginPasswordHint;

  /// Label for the primary login button
  ///
  /// In ar, this message translates to:
  /// **'دخول'**
  String get loginButton;

  /// Validation error caption shown below the identifier field
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال الإيميل أو رقم الموبايل'**
  String get loginIdentifierError;

  /// Validation error caption shown below the password field
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال كلمة السر'**
  String get loginPasswordError;

  /// Accessibility semantic label for the identifier input field
  ///
  /// In ar, this message translates to:
  /// **'حقل الإيميل أو رقم الموبايل'**
  String get loginIdentifierSemantic;

  /// Accessibility semantic label for the password input field
  ///
  /// In ar, this message translates to:
  /// **'حقل كلمة السر'**
  String get loginPasswordSemantic;

  /// Accessibility semantic label for the login button
  ///
  /// In ar, this message translates to:
  /// **'زرار الدخول'**
  String get loginButtonSemantic;

  /// Semantic label for the password visibility toggle icon when password is hidden
  ///
  /// In ar, this message translates to:
  /// **'إظهار كلمة السر'**
  String get loginPasswordShow;

  /// Semantic label for the password visibility toggle icon when password is visible
  ///
  /// In ar, this message translates to:
  /// **'إخفاء كلمة السر'**
  String get loginPasswordHide;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
