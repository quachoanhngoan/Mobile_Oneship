import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../config/config.dart';

class PinputWidget extends StatefulWidget {
  final Function(String) onDone;
  const PinputWidget({super.key, required this.onDone});

  @override
  State<PinputWidget> createState() => _PinputWidgetState();
}

class _PinputWidgetState extends State<PinputWidget> {
  int _timeCount = 60;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    countDownTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 30, bottom: 20),
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          Pinput(
            length: 6,
            defaultPinTheme: PinTheme(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.colorA8A, width: 1),
              ),
            ),
            onChanged: (value) {
              if (value.length == 6) {
                widget.onDone(value);
              }
            },
            showCursor: false,
          ),
          TextButton(
            onPressed: () {
              if (_timeCount == 0) {
                _timeCount = 60;
                countDownTime();
              }
            },
            child: RichText(
                text: TextSpan(children: [
              if (_timeCount != 0) ...[
                TextSpan(
                    text: "Mã OTP hết hạn sau ",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.color723,
                        fontWeight: FontWeight.w400)),
                TextSpan(
                    text: "${_timeCount}s",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.color723,
                        fontWeight: FontWeight.w700))
              ] else ...[
                TextSpan(
                    text: "Bạn không nhận được mã? ",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.color723,
                        fontWeight: FontWeight.w500)),
                TextSpan(
                    text: "Gửi lại",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.color988,
                        fontWeight: FontWeight.w700))
              ]
            ])),
          )
        ],
      ),
    );
  }

  countDownTime() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeCount == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _timeCount--;
        });
      }
    });
  }
}
