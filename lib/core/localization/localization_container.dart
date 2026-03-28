import 'package:injectable/injectable.dart';
import '../localization/app_language_cubit.dart';

@lazySingleton
class LocalizationContainer {
  AppLanguageEnum _langCode = AppLanguageEnum.en;

  AppLanguageEnum get getLang => _langCode;

  void setLanguage(AppLanguageEnum langCode) {
    _langCode = langCode;
  }
}
