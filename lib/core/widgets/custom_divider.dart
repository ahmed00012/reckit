import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.pink.withValues(alpha: 0.0),
            AppColors.middleColor.withValues(alpha: 0.2),
            AppColors.purple.withValues(alpha: 0.0),
          ],
        ),
      ),
    );
  }
}