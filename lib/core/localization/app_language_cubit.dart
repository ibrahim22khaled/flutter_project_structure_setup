import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AppLanguageEnum { en, ar }

class AppLanguageState {
  final AppLanguageEnum langCode;
  AppLanguageState(this.langCode);
}

class AppLanguageCubit extends Cubit<AppLanguageState> {
  AppLanguageCubit() : super(AppLanguageState(AppLanguageEnum.en));

  static AppLanguageCubit of(BuildContext context) =>
      BlocProvider.of<AppLanguageCubit>(context);

  void changeLanguage(AppLanguageEnum langCode) {
    emit(AppLanguageState(langCode));
  }
}

// Mock appLocalizer for now if not fully set up
late dynamic appLocalizer; 
