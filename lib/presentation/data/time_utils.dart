import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../config/theme/color.dart';

class TimeUtils {
  Future<List<DateTime>?> rangeTimePicker(BuildContext context) async {
    try {
      final List<DateTime>? dateTime = await showOmniDateTimeRangePicker(
        context: context,
        startInitialDate: DateTime.now(),
        startFirstDate: DateTime.now().subtract(const Duration(days: 120)),
        startLastDate: DateTime.now().add(
          const Duration(days: 120),
        ),
        endInitialDate: DateTime.now(),
        endFirstDate: DateTime.now().subtract(const Duration(days: 120)),
        endLastDate: DateTime.now().add(
          const Duration(days: 120),
        ),
        is24HourMode: false,
        isShowSeconds: false,
        type: OmniDateTimePickerType.date,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        constraints: const BoxConstraints(
          maxWidth: 350,
          maxHeight: 650,
        ),
        transitionDuration: const Duration(milliseconds: 200),
        barrierDismissible: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: AppColors.color988, fontSize: 16),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue).copyWith(
            surfaceContainerHigh: AppColors.white,
            primary: AppColors.color988,
          ),
        ),
      );

      final firstTime = dateTime?.firstOrNull;
      final lastTime = dateTime?.lastOrNull;
      if (firstTime != null && lastTime != null) {
        final onlyDateStart =
            DateTime(firstTime.year, firstTime.month, firstTime.day);
        final onlyDateEnd =
            DateTime(lastTime.year, lastTime.month, lastTime.day);

        if (onlyDateStart.isAfter(onlyDateEnd)) {
          Fluttertoast.showToast(
              msg: "Ngày bắt đầu không được lớn hơn ngày kết thúc",
              gravity: ToastGravity.BOTTOM,
              toastLength: Toast.LENGTH_LONG);
          return null;
        } else {
          return dateTime;
        }
      }
    } catch (_) {}
    return null;
  }
}
