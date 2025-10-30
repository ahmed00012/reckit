import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

 static Color fromHex(String hex) {
    hex = hex.replaceFirst('#', ''); // Remove the # prefix if present
    if (hex.length == 6) {
      hex = "FF$hex"; // add opacity if missing by prepending FF (full opacity)
    }
    return Color(int.parse(hex, radix: 16)); // Parse the hex string to an integer and create a Color object
  }

  static String toHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  static String formatDateRange(String range) {
    final parts = range.split(' - ');
    if (parts.length != 2) return range;

    final dateFormat = DateFormat('d-M-yyyy');
    final start = dateFormat.parse(parts[0]);
    final end = dateFormat.parse(parts[1]);
    final nights = end.difference(start).inDays;
    final monthFormat = DateFormat('MMM d');
    final endFormat = DateFormat('MMM d, yyyy');

    final formattedRange =
        '(${monthFormat.format(start)} - ${endFormat.format(end)})';

    return '$nights ${nights == 1 ? "Night" : "Nights"} $formattedRange';
  }
}
