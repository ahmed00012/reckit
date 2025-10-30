import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class MainButtonWidget extends StatelessWidget {
  const MainButtonWidget({
    required this.label, super.key,
    this.buttonColor,
    this.width,
    this.height,
    this.iconSize,
    this.rightIcon,
    this.leftIcon,
    this.fontSize,
    this.style,
    this.borderColor,
    this.borderWidth,
    this.onTap,
    this.isPrimary = true,
    this.isCenter = true,
    this.isBlack = false,
    this.gradient,
    this.borderRadius,
  });

  final Color? buttonColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool isPrimary;
  final bool isBlack;
  final bool isCenter;
  final double? width;
  final double? height;
  final Gradient? gradient;
  final Widget? rightIcon;
  final Widget? leftIcon;
  final String label;
  final double? fontSize;
  final TextStyle? style;
  final double? iconSize;
  final double? borderRadius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: isCenter ? null : 1,
      widthFactor: isCenter ? null : 1,
      child: GestureDetector(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Container(
            height: height ?? (1.sw > 1100 ? 60.r : 50.r),
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              color: buttonColor,
              border:
              borderColor != null ?
              Border.all(
                  width: borderWidth ?? 0,
                  color: borderColor!) : null,
              borderRadius:  BorderRadius.circular(borderRadius ?? 14),
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (rightIcon != null) rightIcon!,
                  SizedBox(width: 12.r),
                  Text(
                    label,
                    style: style ,
                  ),
                  SizedBox(width: 12.r),
                  if (leftIcon != null) leftIcon!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
