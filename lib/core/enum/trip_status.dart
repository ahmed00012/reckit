import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reckit/core/constants/colors.dart';

enum TripStatus { ready, pending, sent }

extension StatusExtension on TripStatus {

  Color get tripStatusColor {
    switch(this) {
      case TripStatus.ready:
        return AppColors.readyColor;
      case TripStatus.pending:
        return AppColors.pendingColor;
      case TripStatus.sent:
        return AppColors.primaryColor;
    }

  }
}
extension TripStatusExtension on String {
  TripStatus get tripStatus {
    if (toLowerCase().contains("sent")) {
      return TripStatus.sent;
    } else if (toLowerCase().contains("ready")) {
      return TripStatus.ready;
    } else {
      return TripStatus.pending;
    }
  }
}
