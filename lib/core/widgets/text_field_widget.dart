import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/colors.dart';
import '../constants/text_styles.dart';


class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    super.key,
    this.hintText,
    this.controller,
    this.ontap,
    this.suffixIcon,
    this.obscureText = false,
    this.readOnly = false,
    this.validator,
    this.focusNode,
    this.onFieldSubmitted,
    this.initialValue,
    this.prefixIcon,
    this.hintStyle,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.label,
    this.borderRadius,
    this.autofillHints,
    this.textInputAction,
    this.enableInteractiveSelection,
    this.maxLines,
    this.maxLength,
    this.onTap,
    this.hideError = false,
  });

  final String? hintText;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final TextEditingController? controller;
  final bool obscureText;
  final bool hideError;
  final Function()? ontap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? initialValue;
  final int? maxLines;
  final TextStyle? hintStyle;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChanged;
  final VoidCallback? onTap;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double? borderRadius;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final bool? enableInteractiveSelection;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: TextStyles.textStyle14Medium,
          ),
        if (label != null)  10.verticalSpace,
        InkWell(
          onTap: onTap,
          child: TextFormField(
            maxLength: maxLength,
            initialValue: initialValue,
            autofillHints: autofillHints,
            focusNode: focusNode,
            textInputAction: textInputAction,
            validator: validator,
            obscureText: obscureText,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            readOnly: readOnly ?? false,
            enableInteractiveSelection: enableInteractiveSelection ?? true,
            onTap: ontap,
            style: TextStyles.textStyle16Regular,
            keyboardType: keyboardType,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            maxLines: maxLines ?? 1,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(0.2),
              suffixIcon: suffixIcon == null
                  ? null
                  : Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: suffixIcon,
              ),
              prefixIcon: prefixIcon == null
                  ? null
                  : Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.r),
                child: prefixIcon,
              ),
              hintStyle: TextStyles.textStyle14Medium.copyWith(
                color: AppColors.hintColor2
              ),
              hintText: hintText,

              // border: borderBuilder(
              //   borderRadius: borderRadius,
              //   color: provider.themeMode == ThemeMode.light
              //       ? AppColorsNew.black1.withOpacity(0.1)
              //       : AppColorsNew.white1.withOpacity(0.1),
              // ),
              enabledBorder: borderBuilder(
                borderRadius: borderRadius,
              ),
              focusedBorder: borderBuilder(color: AppColors.pink),
              errorStyle: hideError? const TextStyle(height: 0, fontSize: 0) : null,
              // errorBorder: borderBuilder(color: AppColorsNew.red2),
              // focusedErrorBorder: borderBuilder(color: AppColors.pink2),
              // errorStyle: AppTextStylesNew.style12BoldAlmarai.copyWith(
              //   color: AppColorsNew.red2,
              //   fontWeight: FontWeight.w400,
              // ),
            ),
          ),
        ),
      ],
    );
  }
}

EdgeInsets padding() {
  return EdgeInsets.symmetric(
    horizontal: 1.sw > 1100 ? 15.r : 10.r,
    vertical: 1.sw > 1100 ? 15.r : 10.r,
  );
}

OutlineInputBorder borderBuilder({Color? color, double? borderRadius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12.r)),
    borderSide: BorderSide(
      color: AppColors.textFieldBorderColor,
      width: 0.5,
    ),
  );
}

OutlineInputBorder selectedBorderBuilder({double? borderRadius}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 12.r)),
    // borderSide: BorderSide(color: AppColorsNew.primary),
  );
}
