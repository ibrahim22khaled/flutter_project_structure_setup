import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/core.dart';
import 'show_modal_bottom_sheet.dart';

class ChangeLanguageBottomSheet extends StatefulWidget {
  const ChangeLanguageBottomSheet({super.key});

  @override
  State<ChangeLanguageBottomSheet> createState() =>
      _ChangeLanguageBottomSheetState();

  static Future<void> show(BuildContext context) async {
    await showAppModalBottomSheet(
      child: const ChangeLanguageBottomSheet(),
      title: "Change Language", // Using hardcoded text as appLocalizer might not be ready
      context: context,
    );
  }
}

class _ChangeLanguageBottomSheetState extends State<ChangeLanguageBottomSheet> {
  AppLanguageEnum currentLang = AppLanguageEnum.en;

  @override
  void initState() {
    currentLang = AppLanguageCubit.of(context).state.langCode;
    super.initState();
  }

  void _onLanguageChange(AppLanguageEnum? lang) {
    setState(() {
      currentLang = lang ?? AppLanguageEnum.en;
    });
    _onSaveLanguage();
  }

  void _onSaveLanguage() {
    Navigator.of(
      context,
      rootNavigator: true,
    ).pop();
    AppLanguageCubit.of(context).changeLanguage(currentLang);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppLanguageCubit, AppLanguageState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 12),
            RadioTile(
              onChanged: _onLanguageChange,
              groupValue: currentLang,
              value: AppLanguageEnum.en,
              titleText: "English",
              icon: '',
            ),
            const SizedBox(height: 8),
            RadioTile(
              onChanged: _onLanguageChange,
              groupValue: currentLang,
              value: AppLanguageEnum.ar,
              titleText: "العربية",
              icon: '',
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }
}

class RadioTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String titleText;
  final String icon;

  const RadioTile({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.titleText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = groupValue == value;
    const selectedColor = AppColors.secondary;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onChanged(value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: isSelected ? AppColors.secondary : AppColors.borderColorF2,
          ),
          color: AppColors.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Row(
          children: [
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              titleText,
              style: TextStyles.regular14.copyWith(
                color: AppColors.gray99,
              ),
            )),
            const SizedBox(
              width: 8,
            ),
            AnimatedOpacity(
              opacity: isSelected ? 1 : 0,
              duration: const Duration(milliseconds: 200),
              child: RadioWidget(
                isSelected: isSelected,
                selectColor: selectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RadioWidget extends StatelessWidget {
  const RadioWidget(
      {super.key,
      required this.isSelected,
      this.selectColor = AppColors.black});
  final bool isSelected;
  final Color selectColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      width: 16,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xffF9F9F9),
          border: Border.all(color: selectColor, width: 1.5),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withAlpha(25),
                blurRadius: 2,
                spreadRadius: 1.5)
          ]),
      child: isSelected
          ? AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? selectColor : Colors.white,
              ),
            )
          : const SizedBox(),
    );
  }
}
