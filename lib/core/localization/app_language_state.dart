part of "app_language_cubit.dart";

class AppLanguageState extends Equatable {
  final AppLanguageEnum langCode;
  final Async<void> sendAppLanguage;

  const AppLanguageState(this.langCode, this.sendAppLanguage);

  const AppLanguageState.initial()
      : this(AppLanguageEnum.ar, const Async.initial());

  AppLanguageState copyWith({
    AppLanguageEnum? langCode,
    Async<void>? sendAppLanguage,
  }) {
    return AppLanguageState(
      langCode ?? this.langCode,
      sendAppLanguage ?? this.sendAppLanguage,
    );
  }

  @override
  List<Object> get props => [langCode, sendAppLanguage];
}
