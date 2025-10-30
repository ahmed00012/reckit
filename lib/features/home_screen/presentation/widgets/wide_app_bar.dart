import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reckit/core/constants/colors.dart';
import 'package:reckit/core/constants/text_styles.dart';
import 'package:reckit/gen/assets.gen.dart';

class WideAppBar extends StatelessWidget {
  final Function(String) onSelectTap;
  final List<String> taps;
  final String currentTap;

  const WideAppBar({super.key, required this.onSelectTap, required this.taps, required this.currentTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(1.sw <= 700)
        SvgPicture.asset(Assets.images.menu),
        if(1.sw <= 700)
        25.horizontalSpace,
        SizedBox(
          height: 60,
          child: SvgPicture.asset(Assets.images.logo),
        ),
        Spacer(),
        if(1.sw > 700)
        Row(
          children: List.generate(
            taps.length,
                (index) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: InkWell(
                onTap: () {
                  onSelectTap.call(taps[index]);
                },
                child: Column(
                  children: [
                    30.verticalSpace,
                    Container(
                      height: 30,
                      child: Text(
                        taps[index],
                        style: TextStyles.textStyle14Regular
                            .copyWith(
                          color: currentTap != taps[index]
                              ? AppColors.hintColor
                              : null,
                          fontWeight: currentTap != taps[index]
                              ? FontWeight.w500
                              : null,
                        ),
                      ),
                    ),
                    5.verticalSpace,
                    Container(
                      height: 2,
                      width: 1.sw / 20,
                      color: currentTap != taps[index]
                          ? null
                          : AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(height: 30, width: 1, color: AppColors.blackCard),
        10.horizontalSpace,
        SvgPicture.asset(Assets.images.setting),
        10.horizontalSpace,
        SvgPicture.asset(Assets.images.notifications),
        10.horizontalSpace,
        Container(height: 30, width: 1, color: AppColors.blackCard),
        10.horizontalSpace,
        ClipOval(
          child: Image.asset(
            Assets.images.userImage.path,
            height: 30,
            width: 30,
          ),
        ),
        10.horizontalSpace,
        Text('John Doe', style: TextStyles.textStyle14Regular),
        5.horizontalSpace,
        Icon(Icons.keyboard_arrow_down_outlined),
      ],
    );
  }
}
