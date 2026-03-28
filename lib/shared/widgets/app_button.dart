import 'package:flutter/material.dart';
import '../../core/core.dart';

class AppButton extends StatelessWidget {
  final Color? buttonColor;
  final Color? borderColor;
  final double? buttonRadius;
  final double height;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final Color? textColor;
  final bool isLoading;
  final bool isEnabled;
  final double? elevation;
  final Widget? leading;
  final Widget? trailing;

  const AppButton({
    super.key,
    this.isLoading = false,
    this.isEnabled = true,
    this.buttonColor,
    this.borderColor,
    this.buttonRadius,
    this.height = 48,
    required this.text,
    this.textStyle,
    this.onPressed,
    this.textColor,
    this.elevation,
    this.isExpanded = true,
    this.leading,
    this.trailing,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading || isEnabled == false ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        backgroundColor: (buttonColor != null || isEnabled) ? null : AppColors.gray250,
        disabledBackgroundColor: AppColors.gray250,
        side: borderColor != null
            ? BorderSide(color: borderColor ?? AppColors.secondary)
            : null,
        padding: EdgeInsets.zero,
        minimumSize: Size(isExpanded ? double.infinity : 0, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              buttonRadius ?? 10,
            ),
          ),
        ),
      ).copyWith(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) return AppColors.gray250;
          return buttonColor;
        }),
      ),
      child: Ink(
        decoration: (buttonColor == null && isEnabled)
            ? BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.all(Radius.circular(buttonRadius ?? 10)),
              )
            : null,
        child: Container(
          constraints: BoxConstraints(minWidth: isExpanded ? double.infinity : 0, minHeight: height),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
            children: [
              if (leading != null) ...[
                const SizedBox(width: 5),
                leading!,
                const SizedBox(width: 5),
              ],
              Flexible(
                child: Text(
                  text,
                  style: textStyle ??
                      TextStyles.regular15
                          .copyWith(color: textColor ?? AppColors.white),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                ),
              ),
              if (trailing != null) ...[
                const SizedBox(width: 5),
                (isLoading)
                    ? _LoadingWidth(
                        color: textColor,
                      )
                    : trailing!
              ] else ...[
                const SizedBox(width: 5),
                if (isLoading)
                  _LoadingWidth(
                    color: textColor,
                    ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingWidth extends StatelessWidget {
  const _LoadingWidth({
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      margin: const EdgeInsetsDirectional.only(start: 12),
      child: CircularProgressIndicator(
        color: color ?? AppColors.white,
        strokeWidth: 3,
      ),
    );
  }
}
