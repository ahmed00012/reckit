import 'dart:convert';

import 'package:flutter/material.dart';

import '../constants/colors.dart';

class UserImageCircle extends StatelessWidget {
  final String currentUserImage;
  final double size;
  final bool hasStory;

  const UserImageCircle(
      {super.key,
      required this.currentUserImage,
      this.size = 35,
      this.hasStory = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: hasStory
              ? Border.all(color: AppColors.purple, width: 1.5)
              : null),
      child: ClipOval(
        child: (currentUserImage).contains('http')
            ? Image.network(currentUserImage,
                fit: BoxFit.fill, height: size, width: size)
            : (currentUserImage).contains('base64')
                ? Image.memory(base64Decode(currentUserImage.split(',').last),
                    fit: BoxFit.fill, height: size, width: size)
                : Image.asset(
                    currentUserImage,
                    fit: BoxFit.fill,
                    height: size,
                    width: size,
                  ),
      ),
    );
  }
}
