// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'سبرنت';

  @override
  String get errorPageTitle => 'خطأ';

  @override
  String get errorPageMessage => 'الصفحة غير موجودة';

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String get splashTagline => 'احجز من غير زحمة';

  @override
  String get splashUniversity => 'جامعة طنطا';

  @override
  String get splashFaculty => 'كلية التربية الرياضية';

  @override
  String get loginTitle => 'أهلاً بيك في سبرنت';

  @override
  String get loginSubtitle => 'ابدأ حجزك دلوقتي';

  @override
  String get loginIdentifierHint => 'الإيميل أو رقم الموبايل';

  @override
  String get loginPasswordHint => 'كلمة السر';

  @override
  String get loginButton => 'دخول';

  @override
  String get loginIdentifierError => 'يرجى إدخال الإيميل أو رقم الموبايل';

  @override
  String get loginPasswordError => 'يرجى إدخال كلمة السر';

  @override
  String get loginIdentifierSemantic => 'حقل الإيميل أو رقم الموبايل';

  @override
  String get loginPasswordSemantic => 'حقل كلمة السر';

  @override
  String get loginButtonSemantic => 'زرار الدخول';

  @override
  String get loginPasswordShow => 'إظهار كلمة السر';

  @override
  String get loginPasswordHide => 'إخفاء كلمة السر';

  @override
  String get homeGuestSignIn => 'دخول';

  @override
  String get homeGuestHeroTitle => 'احجز ملعبك من غير زحمة';

  @override
  String get homeGuestHeroBody =>
      'شوف الملاعب والأسعار، وسجّل دخولك عشان تحجز.';

  @override
  String get homeGuestHeroCta => 'سجّل دخولك واحجز';

  @override
  String homeGreeting(String name) {
    return 'أهلاً يا $name';
  }

  @override
  String get homeGreetingSubtitle => 'عايز تلعب إيه النهارده؟';

  @override
  String get homeUpcomingTitle => 'حجزك الجاي';

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
      other: '$count ساعة',
      few: '$count ساعات',
      two: 'ساعتين',
      one: 'ساعة واحدة',
    );
    return '$_temp0';
  }

  @override
  String get homeUpcomingEmptyTitle => 'مفيش حجوزات جاية';

  @override
  String get homeUpcomingEmptyBody => 'اختار ملعب من تحت واحجز أول حصة.';

  @override
  String get homeFacilitiesTitle => 'الملاعب والمرافق';

  @override
  String homePricePerHour(int price) {
    return '$price ج.م / ساعة';
  }

  @override
  String homePriceOriginal(int price) {
    return '$price ج.م';
  }

  @override
  String get homeModeFree => 'حجز حر';

  @override
  String get homeModeCoached => 'مع مدرب';

  @override
  String get homeCategoryPool => 'حمام سباحة';

  @override
  String get homeCategoryGym => 'جيم';

  @override
  String get homeCategoryFootballPitch => 'ملعب كرة قدم';

  @override
  String get homeCategoryBasketballCourt => 'ملعب كرة سلة';

  @override
  String homeFacilitySemantic(String name, String mode, String price) {
    return '$name، $mode، $price';
  }

  @override
  String get homeNavHome => 'الرئيسية';

  @override
  String get homeNavBookings => 'حجوزاتي';

  @override
  String get homeNavNotifications => 'الإشعارات';

  @override
  String get homeNavProfile => 'حسابي';

  @override
  String get homeComingSoon => 'قريبًا';

  @override
  String get homeErrorMessage => 'حصلت مشكلة وإحنا بنحمل الصفحة';

  @override
  String get homeRetry => 'حاول تاني';
}
