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
}
