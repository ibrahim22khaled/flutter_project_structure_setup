import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../utils/async.dart';
import '../helpers/local_storage/language_prefrence_helper.dart';
import 'localization_container.dart';
import 'package:equatable/equatable.dart';

part "app_language_state.dart";

enum AppLanguageEnum { en, ar }

@lazySingleton
class AppLanguageCubit extends Cubit<AppLanguageState> {
  final LanguagePreferencesHelper _languagePreferencesHelper;
  final LocalizationContainer _localizationContainer;

  AppLanguageCubit(
      this._languagePreferencesHelper, this._localizationContainer)
      : super(const AppLanguageState.initial());

  static AppLanguageCubit of(BuildContext context) => BlocProvider.of(context);

  Future<void> changeLanguage(AppLanguageEnum langCode) async {
    await _languagePreferencesHelper.setLanguage(langCode);
    _localizationContainer.setLanguage(langCode);
    // await resetDependenciesScope(); // Assuming this will be handled in a DI reset logic
    emit(state.copyWith(langCode: langCode));
  }

  Future<void> init() async {
    final language = await _languagePreferencesHelper.getLanguage();
    _localizationContainer.setLanguage(language);
    emit(state.copyWith(langCode: _localizationContainer.getLang));
  }

  bool get isRtl => isArabic;

  bool get isArabic => state.langCode == AppLanguageEnum.ar;

  bool get isEnglish => state.langCode == AppLanguageEnum.en;

  @override
  void emit(AppLanguageState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
