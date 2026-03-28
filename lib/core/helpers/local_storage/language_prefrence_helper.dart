import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import '../../localization/app_language_cubit.dart';

@lazySingleton
class LanguagePreferencesHelper {
  final FlutterSecureStorage _storage;
  static const String _key = 'app_language';

  LanguagePreferencesHelper(this._storage);

  Future<void> setLanguage(AppLanguageEnum langCode) async {
    await _storage.write(key: _key, value: langCode.name);
  }

  Future<AppLanguageEnum> getLanguage() async {
    final lang = await _storage.read(key: _key);
    if (lang == null) return AppLanguageEnum.en;
    return AppLanguageEnum.values.firstWhere(
      (e) => e.name == lang,
      orElse: () => AppLanguageEnum.en,
    );
  }
}
