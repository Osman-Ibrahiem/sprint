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
  String get splashSubtitle => 'احجز ملعبك، من غير زحمة ⚡';

  @override
  String get splashContinueHint => 'اضغط للمتابعة';

  @override
  String get loginTitle => 'أهلاً بيك في سبرنت';

  @override
  String get loginSubtitle => 'ابدأ حجزك دلوقتي';
}
