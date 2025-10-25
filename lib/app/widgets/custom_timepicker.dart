// lib/widgets/custom_datetime_picker.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDateTimePicker {
  /// Custom DatePicker
  static Future<DateTime?> showDate({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2020),
      lastDate: lastDate ?? DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00C9A7), // Warna utama
              onPrimary: Colors.white, // Teks tombol OK
              onSurface: Color(0xFF0070C9), // Teks tanggal
            ),
            dialogBackgroundColor: Colors.white,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF0070C9), // Tombol Batal
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    return pickedDate;
  }

  /// Custom TimePicker
  static Future<TimeOfDay?> showTime({
    required BuildContext context,
    TimeOfDay? initialTime,
  }) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF00C9A7), // Warna utama
              onPrimary: Colors.white, // Teks tombol OK
              onSurface: Color(0xFF0070C9), // Teks jam & menit
            ),
            dialogBackgroundColor: Colors.white, // Latar belakang dialog
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFF0070C9), // Tombol Batal
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    return pickedTime;
  }

  /// Format DateTime ke string dd-MM-yyyy
  static String formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.year}';
  }

  /// Format TimeOfDay ke string HH:mm
  static String formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}';
  }
}
