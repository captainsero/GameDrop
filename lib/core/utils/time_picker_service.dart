import 'package:flutter/material.dart';

/// Utility for showing time pickers and formatting results.
class TimePickerService {
  TimePickerService._();

  /// Shows a time picker and returns the selected time as "HH:mm",
  /// or `null` if the user dismissed the picker.
  static Future<String?> pickTime(
    BuildContext context, {
    required String currentTime,
  }) async {
    final parts = currentTime.split(':');
    final initial = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );

    final picked = await showTimePicker(
      context: context,
      initialTime: initial,
    );

    if (picked == null) return null;

    return '${picked.hour.toString().padLeft(2, '0')}:'
        '${picked.minute.toString().padLeft(2, '0')}';
  }

  /// Converts a 24-hour "HH:mm" string into a locale-aware display string
  /// (e.g. "4:00 PM").
  static String formatForDisplay(BuildContext context, String time24) {
    final parts = time24.split(':');
    final tod = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
    return tod.format(context);
  }
}
